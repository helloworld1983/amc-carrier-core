-------------------------------------------------------------------------------
-- Title      : 
-------------------------------------------------------------------------------
-- File       : DebugRtmEth.vhd
-- Author     : Larry Ruckman  <ruckman@slac.stanford.edu>
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2016-04-14
-- Last update: 2016-04-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 Common Carrier Core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 Common Carrier Core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.UdpEnginePkg.all;
use work.IpV4EnginePkg.all;
use work.AmcCarrierPkg.all;
use work.AmcCarrierRegPkg.all;

entity DebugRtmEth is
   generic (
      TPD_G            : time            := 1 ns;
      EN_SW_RSSI_G     : boolean         := true;
      EN_BP_MSG_G      : boolean         := false;
      AXI_ERROR_RESP_G : slv(1 downto 0) := AXI_RESP_DECERR_C);
   port (
      -- Local Configuration and status
      localMac          : in  slv(47 downto 0);  --  big-Endian configuration
      localIp           : in  slv(31 downto 0);  --  big-Endian configuration   
      ethPhyReady       : out sl;
      -- Master AXI-Lite Interface
      mAxilReadMasters  : out AxiLiteReadMasterArray(1 downto 0);
      mAxilReadSlaves   : in  AxiLiteReadSlaveArray(1 downto 0);
      mAxilWriteMasters : out AxiLiteWriteMasterArray(1 downto 0);
      mAxilWriteSlaves  : in  AxiLiteWriteSlaveArray(1 downto 0);
      -- AXI-Lite Interface
      axilClk           : in  sl;
      axilRst           : in  sl;
      axilReadMaster    : in  AxiLiteReadMasterType;
      axilReadSlave     : out AxiLiteReadSlaveType;
      axilWriteMaster   : in  AxiLiteWriteMasterType;
      axilWriteSlave    : out AxiLiteWriteSlaveType;
      -- BSA Ethernet Interface
      obBsaMasters      : in  AxiStreamMasterArray(2 downto 0);
      obBsaSlaves       : out AxiStreamSlaveArray(2 downto 0);
      ibBsaMasters      : out AxiStreamMasterArray(2 downto 0);
      ibBsaSlaves       : in  AxiStreamSlaveArray(2 downto 0);
      -- Backplane Messaging Interface
      bpMsgMasters      : in  AxiStreamMasterArray(BP_MSG_SIZE_C-1 downto 0);
      bpMsgSlaves       : out AxiStreamSlaveArray(BP_MSG_SIZE_C-1 downto 0);
      ----------------------
      -- Top Level Interface
      ----------------------
      -- Backplane Messaging Interface (bpMsgClk domain)
      bpMsgClk          : in  sl := '0';
      bpMsgRst          : in  sl := '0';
      bpMsgBus          : out BpMsgBusArray(BP_MSG_SIZE_C-1 downto 0);
      ----------------
      -- Core Ports --
      ----------------   
      -- RTM Ethernet Ports
      ethRxP            : in  sl;
      ethRxN            : in  sl;
      ethTxP            : out sl;
      ethTxN            : out sl;
      xauiClkP          : in  sl;
      xauiClkN          : in  sl);
end DebugRtmEth;

architecture mapping of DebugRtmEth is

   constant RSSI_TIMEOUT_C : real     := 1.0E-3;  -- In units of seconds
   constant MTU_C          : positive := 1500;
   constant SERVER_SIZE_C  : positive := 4;
   constant CLIENT_SIZE_C  : positive := 2;

   constant NUM_AXI_MASTERS_C : natural := 4;

   constant PHY_INDEX_C    : natural := 0;
   constant UDP_INDEX_C    : natural := 1;
   constant SRP_INDEX_C    : natural := 2;
   constant BP_MSG_INDEX_C : natural := 3;

   constant PHY_ADDR_C    : slv(31 downto 0) := (XAUI_ADDR_C + x"00000000");
   constant UDP_ADDR_C    : slv(31 downto 0) := (XAUI_ADDR_C + x"00010000");
   constant SRP_ADDR_C    : slv(31 downto 0) := (XAUI_ADDR_C + x"00020000");
   constant BP_MSG_ADDR_C : slv(31 downto 0) := (XAUI_ADDR_C + x"00030000");

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := (
      PHY_INDEX_C     => (
         baseAddr     => PHY_ADDR_C,
         addrBits     => 16,
         connectivity => X"FFFF"),
      UDP_INDEX_C     => (
         baseAddr     => UDP_ADDR_C,
         addrBits     => 16,
         connectivity => X"FFFF"),
      SRP_INDEX_C     => (
         baseAddr     => SRP_ADDR_C,
         addrBits     => 16,
         connectivity => X"FFFF"),
      BP_MSG_INDEX_C  => (
         baseAddr     => BP_MSG_ADDR_C,
         addrBits     => 16,
         connectivity => X"FFFF"));   

   function ServerPorts return PositiveArray is
      variable retConf   : PositiveArray(SERVER_SIZE_C-1 downto 0);
      variable baseIndex : positive;
   begin
      baseIndex := 8192;
      for i in SERVER_SIZE_C-1 downto 0 loop
         retConf(i) := baseIndex+i;
      end loop;
      return retConf;
   end function;

   function ClientPorts return PositiveArray is
      variable retConf   : PositiveArray(CLIENT_SIZE_C-1 downto 0);
      variable baseIndex : positive;
   begin
      baseIndex := 8192+SERVER_SIZE_C;
      for i in CLIENT_SIZE_C-1 downto 0 loop
         retConf(i) := baseIndex+i;
      end loop;
      return retConf;
   end function;

   signal ibMacMaster : AxiStreamMasterType;
   signal ibMacSlave  : AxiStreamSlaveType;
   signal obMacMaster : AxiStreamMasterType;
   signal obMacSlave  : AxiStreamSlaveType;

   signal obServerMasters : AxiStreamMasterArray(SERVER_SIZE_C-1 downto 0);
   signal obServerSlaves  : AxiStreamSlaveArray(SERVER_SIZE_C-1 downto 0);
   signal ibServerMasters : AxiStreamMasterArray(SERVER_SIZE_C-1 downto 0);
   signal ibServerSlaves  : AxiStreamSlaveArray(SERVER_SIZE_C-1 downto 0);

   signal obClientMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal obClientSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);
   signal ibClientMasters : AxiStreamMasterArray(CLIENT_SIZE_C-1 downto 0);
   signal ibClientSlaves  : AxiStreamSlaveArray(CLIENT_SIZE_C-1 downto 0);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

   signal phyReady : sl;
   
begin

   --------------------------
   -- AXI-Lite: Crossbar Core
   --------------------------  
   U_XBAR : entity work.AxiLiteCrossbar
      generic map (
         TPD_G              => TPD_G,
         DEC_ERROR_RESP_G   => AXI_ERROR_RESP_G,
         NUM_SLAVE_SLOTS_G  => 1,
         NUM_MASTER_SLOTS_G => NUM_AXI_MASTERS_C,
         MASTERS_CONFIG_G   => AXI_CONFIG_C)
      port map (
         axiClk              => axilClk,
         axiClkRst           => axilRst,
         sAxiWriteMasters(0) => axilWriteMaster,
         sAxiWriteSlaves(0)  => axilWriteSlave,
         sAxiReadMasters(0)  => axilReadMaster,
         sAxiReadSlaves(0)   => axilReadSlave,
         mAxiWriteMasters    => axilWriteMasters,
         mAxiWriteSlaves     => axilWriteSlaves,
         mAxiReadMasters     => axilReadMasters,
         mAxiReadSlaves      => axilReadSlaves);

   -----------------
   -- 10 GigE Module
   -----------------
   U_10GigE : entity work.TenGigEthGthUltraScaleWrapper
      generic map (
         TPD_G             => TPD_G,
         REF_CLK_FREQ_G    => 156.25E+6,
         NUM_LANE_G        => 1,
         QPLL_REFCLK_SEL_G => "001",
         AXI_ERROR_RESP_G  => AXI_ERROR_RESP_G,
         AXIS_CONFIG_G     => (others => IP_ENGINE_CONFIG_C))
      port map (
         -- Local Configurations
         localMac(0)            => localMac,
         -- Streaming DMA Interface 
         dmaClk(0)              => axilClk,
         dmaRst(0)              => axilRst,
         dmaIbMasters(0)        => obMacMaster,
         dmaIbSlaves(0)         => obMacSlave,
         dmaObMasters(0)        => ibMacMaster,
         dmaObSlaves(0)         => ibMacSlave,
         -- Slave AXI-Lite Interface 
         axiLiteClk(0)          => axilClk,
         axiLiteRst(0)          => axilRst,
         axiLiteReadMasters(0)  => axilReadMasters(PHY_INDEX_C),
         axiLiteReadSlaves(0)   => axilReadSlaves(PHY_INDEX_C),
         axiLiteWriteMasters(0) => axilWriteMasters(PHY_INDEX_C),
         axiLiteWriteSlaves(0)  => axilWriteSlaves(PHY_INDEX_C),
         -- Misc. Signals
         extRst                 => axilRst,
         phyClk                 => open,
         phyRst                 => open,
         phyReady(0)            => phyReady,
         -- MGT Clock Port (156.25 MHz or 312.5 MHz)
         gtClkP                 => xauiClkP,
         gtClkN                 => xauiClkN,
         -- MGT Ports
         gtTxP(0)               => ethTxP,
         gtTxN(0)               => ethTxN,
         gtRxP(0)               => ethRxP,
         gtRxN(0)               => ethRxN);   

   U_Sync : entity work.Synchronizer
      generic map (
         TPD_G => TPD_G)
      port map (
         clk     => axilClk,
         dataIn  => phyReady,
         dataOut => ethPhyReady);         

   ----------------------
   -- IPv4/ARP/UDP Engine
   ----------------------
   U_UdpEngineWrapper : entity work.UdpEngineWrapper
      generic map (
         -- Simulation Generics
         TPD_G              => TPD_G,
         SIM_ERROR_HALT_G   => false,
         -- UDP General Generic
         RX_MTU_G           => MTU_C,
         RX_FORWARD_EOFE_G  => false,
         TX_FORWARD_EOFE_G  => false,
         TX_CALC_CHECKSUM_G => true,
         -- UDP Server Generics
         SERVER_EN_G        => true,
         SERVER_SIZE_G      => SERVER_SIZE_C,
         SERVER_PORTS_G     => ServerPorts,
         SERVER_MTU_G       => MTU_C,
         -- UDP Client Generics
         CLIENT_EN_G        => true,
         CLIENT_SIZE_G      => CLIENT_SIZE_C,
         CLIENT_PORTS_G     => ClientPorts,
         CLIENT_MTU_G       => MTU_C,
         -- IPv4/ARP Generics
         CLK_FREQ_G         => AXI_CLK_FREQ_C,  -- In units of Hz
         COMM_TIMEOUT_EN_G  => true,    -- Disable the timeout by setting to false
         COMM_TIMEOUT_G     => 30,  -- In units of seconds, Client's Communication timeout before re-ARPing
         ARP_TIMEOUT_G      => 156250000,       -- 1 second ARP request timeout
         VLAN_G             => false,   -- no VLAN
         AXI_ERROR_RESP_G   => AXI_ERROR_RESP_G)            
      port map (
         -- Local Configurations
         localMac        => localMac,
         localIp         => localIp,
         -- Interface to Ethernet Media Access Controller (MAC)
         obMacMaster     => obMacMaster,
         obMacSlave      => obMacSlave,
         ibMacMaster     => ibMacMaster,
         ibMacSlave      => ibMacSlave,
         -- Interface to UDP Server engine(s)
         obServerMasters => obServerMasters,
         obServerSlaves  => obServerSlaves,
         ibServerMasters => ibServerMasters,
         ibServerSlaves  => ibServerSlaves,
         -- Interface to UDP Client engine(s)
         obClientMasters => obClientMasters,
         obClientSlaves  => obClientSlaves,
         ibClientMasters => ibClientMasters,
         ibClientSlaves  => ibClientSlaves,
         -- AXI-Lite Interface
         axilReadMaster  => axilReadMasters(UDP_INDEX_C),
         axilReadSlave   => axilReadSlaves(UDP_INDEX_C),
         axilWriteMaster => axilWriteMasters(UDP_INDEX_C),
         axilWriteSlave  => axilWriteSlaves(UDP_INDEX_C),
         -- Clock and Reset
         clk             => axilClk,
         rst             => axilRst);

   ---------------------------------------------
   -- Legacy AXI-Lite Master without RSSI Server
   ---------------------------------------------
   U_SRPv0 : entity work.SrpV0AxiLite
      generic map (
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => true,
         EN_32BIT_ADDR_G     => true,
         BRAM_EN_G           => true,
         GEN_SYNC_FIFO_G     => true,
         AXI_STREAM_CONFIG_G => IP_ENGINE_CONFIG_C)   
      port map (
         -- Streaming Slave (Rx) Interface (sAxisClk domain) 
         sAxisClk            => axilClk,
         sAxisRst            => axilRst,
         sAxisMaster         => obServerMasters(0),
         sAxisSlave          => obServerSlaves(0),
         -- Streaming Master (Tx) Data Interface (mAxisClk domain)
         mAxisClk            => axilClk,
         mAxisRst            => axilRst,
         mAxisMaster         => ibServerMasters(0),
         mAxisSlave          => ibServerSlaves(0),
         -- AXI Lite Bus (axiLiteClk domain)
         axiLiteClk          => axilClk,
         axiLiteRst          => axilRst,
         mAxiLiteReadMaster  => mAxilReadMasters(0),
         mAxiLiteReadSlave   => mAxilReadSlaves(0),
         mAxiLiteWriteMaster => mAxilWriteMasters(0),
         mAxiLiteWriteSlave  => mAxilWriteSlaves(0));   

   -----------------------------------
   -- Software's RSSI Server Interface
   -----------------------------------
   GEN_SW_RSSI : if (EN_SW_RSSI_G = true) generate
      U_RssiServer : entity work.AmcCarrierEthRssi
         generic map (
            TPD_G            => TPD_G,
            TIMEOUT_G        => RSSI_TIMEOUT_C,
            AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
         port map (
            -- Slave AXI-Lite Interface
            axilClk          => axilClk,
            axilRst          => axilRst,
            axilReadMaster   => axilReadMasters(SRP_INDEX_C),
            axilReadSlave    => axilReadSlaves(SRP_INDEX_C),
            axilWriteMaster  => axilWriteMasters(SRP_INDEX_C),
            axilWriteSlave   => axilWriteSlaves(SRP_INDEX_C),
            -- Master AXI-Lite Interface
            mAxilReadMaster  => mAxilReadMasters(1),
            mAxilReadSlave   => mAxilReadSlaves(1),
            mAxilWriteMaster => mAxilWriteMasters(1),
            mAxilWriteSlave  => mAxilWriteSlaves(1),
            -- BSA Ethernet Interface
            obBsaMasters     => obBsaMasters,
            obBsaSlaves      => obBsaSlaves,
            ibBsaMasters     => ibBsaMasters,
            ibBsaSlaves      => ibBsaSlaves,
            -- Interface to UDP Server engines
            obServerMaster   => obServerMasters(1),
            obServerSlave    => obServerSlaves(1),
            ibServerMaster   => ibServerMasters(1),
            ibServerSlave    => ibServerSlaves(1));   
   end generate;

   BYPASS_SW_RSSI : if (EN_SW_RSSI_G = false) generate
      
      U_AxiLiteEmpty : entity work.AxiLiteEmpty
         generic map (
            TPD_G            => TPD_G,
            AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
         port map (
            axiClk         => axilClk,
            axiClkRst      => axilRst,
            axiReadMaster  => axilReadMasters(SRP_INDEX_C),
            axiReadSlave   => axilReadSlaves(SRP_INDEX_C),
            axiWriteMaster => axilWriteMasters(SRP_INDEX_C),
            axiWriteSlave  => axilWriteSlaves(SRP_INDEX_C));  

      mAxilReadMasters(1)  <= AXI_LITE_READ_MASTER_INIT_C;
      mAxilWriteMasters(1) <= AXI_LITE_WRITE_MASTER_INIT_C;
      obBsaSlaves          <= (others => AXI_STREAM_SLAVE_FORCE_C);
      ibBsaMasters         <= (others => AXI_STREAM_MASTER_INIT_C);
      obServerSlaves(1)    <= AXI_STREAM_SLAVE_FORCE_C;
      ibServerMasters(1)   <= AXI_STREAM_MASTER_INIT_C;
      
   end generate;

   -----------------------
   -- BP Messenger Network
   -----------------------
   GEN_BP_MSG : if (EN_BP_MSG_G = true) generate
      U_BpMsg : entity work.AmcCarrierEthBpMsg
         generic map(
            TPD_G            => TPD_G,
            RSSI_G           => true,
            TIMEOUT_G        => RSSI_TIMEOUT_C,
            AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
            AXI_BASE_ADDR_G  => AXI_CONFIG_C(BP_MSG_INDEX_C).baseAddr)   
         port map (
            -- AXI-Lite Interface
            axilClk         => axilClk,
            axilRst         => axilRst,
            axilReadMaster  => axilReadMasters(BP_MSG_INDEX_C),
            axilReadSlave   => axilReadSlaves(BP_MSG_INDEX_C),
            axilWriteMaster => axilWriteMasters(BP_MSG_INDEX_C),
            axilWriteSlave  => axilWriteSlaves(BP_MSG_INDEX_C),
            -- Interface to UDP Server engines
            obServerMasters => obServerMasters(3 downto 2),
            obServerSlaves  => obServerSlaves(3 downto 2),
            ibServerMasters => ibServerMasters(3 downto 2),
            ibServerSlaves  => ibServerSlaves(3 downto 2),
            -- Interface to UDP Client engines
            obClientMasters => obClientMasters,
            obClientSlaves  => obClientSlaves,
            ibClientMasters => ibClientMasters,
            ibClientSlaves  => ibClientSlaves,
            -- Backplane Messaging Interface
            bpMsgMasters    => bpMsgMasters,
            bpMsgSlaves     => bpMsgSlaves,
            ----------------------
            -- Top Level Interface
            ----------------------
            -- Backplane Messaging Interface (bpMsgClk domain)
            bpMsgClk        => bpMsgClk,
            bpMsgRst        => bpMsgRst,
            bpMsgBus        => bpMsgBus);
   end generate;

   BYPASS_BP_MSG : if (EN_BP_MSG_G = false) generate
      
      U_AxiLiteEmpty : entity work.AxiLiteEmpty
         generic map (
            TPD_G            => TPD_G,
            AXI_ERROR_RESP_G => AXI_ERROR_RESP_G)
         port map (
            axiClk         => axilClk,
            axiClkRst      => axilRst,
            axiReadMaster  => axilReadMasters(BP_MSG_INDEX_C),
            axiReadSlave   => axilReadSlaves(BP_MSG_INDEX_C),
            axiWriteMaster => axilWriteMasters(BP_MSG_INDEX_C),
            axiWriteSlave  => axilWriteSlaves(BP_MSG_INDEX_C));    

      obServerSlaves(3 downto 2)  <= (others => AXI_STREAM_SLAVE_FORCE_C);
      ibServerMasters(3 downto 2) <= (others => AXI_STREAM_MASTER_INIT_C);
      obClientSlaves              <= (others => AXI_STREAM_SLAVE_FORCE_C);
      ibClientMasters             <= (others => AXI_STREAM_MASTER_INIT_C);
      bpMsgSlaves                 <= (others => AXI_STREAM_SLAVE_FORCE_C);
      bpMsgBus                    <= (others => BP_MSG_BUS_INIT_C);

   end generate;

end mapping;