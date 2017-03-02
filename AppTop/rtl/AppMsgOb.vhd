-------------------------------------------------------------------------------
-- File       : AppMsgOb.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2017-03-01
-- Last update: 2017-03-01
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;
use work.EthMacPkg.all;

entity AppMsgOb is
   generic (
      TPD_G             : time            := 1 ns;
      HDR_SIZE_G        : positive        := 1;
      DATA_SIZE_G       : positive        := 1;
      EN_CRC_G          : boolean         := true;
      BRAM_EN_G         : boolean         := true;
      FIFO_ADDR_WIDTH_G : positive        := 9;
      TDEST_G           : slv(7 downto 0) := x"00");
   port (
      -- Application Messaging Interface (clk domain)      
      clk         : in  sl;
      rst         : in  sl;
      strobe      : in  sl;
      header      : in  Slv32Array(HDR_SIZE_G-1 downto 0);
      timeStamp   : in  slv(63 downto 0);
      data        : in  Slv32Array(DATA_SIZE_G-1 downto 0);
      -- Backplane Messaging Interface  (axilClk domain)
      axilClk     : in  sl;
      axilRst     : in  sl;
      obMsgMaster : out AxiStreamMasterType;
      obMsgSlave  : in  AxiStreamSlaveType);
end AppMsgOb;

architecture rtl of AppMsgOb is

   constant SIZE_C        : positive            := (2+HDR_SIZE_G+DATA_SIZE_G);  -- 64-bit timestamp + header + data
   constant DATA_WIDTH_G  : positive            := (32*SIZE_C);  -- 32-bit words
   constant AXIS_CONFIG_C : AxiStreamConfigType := ssiAxiStreamConfig(4);

   function toSlv (
      hdr : Slv32Array(HDR_SIZE_G-1 downto 0);
      ts  : slv(63 downto 0);
      msg : Slv32Array(DATA_SIZE_G-1 downto 0)) return slv is
      variable retVar : slv(DATA_WIDTH_G-1 downto 0);
      variable i      : natural;
      variable idx    : natural;
   begin
      -- Reset the variables
      retVar := (others => '0');
      idx    := 0;

      -- Load the header array
      for i in (HDR_SIZE_G-1) downto 0 loop
         retVar((idx*32)+31 downto (idx*32)) := hdr(i);
         idx                                 := idx + 1;
      end loop;

      -- Load the 64-bit time stamp
      for i in 1 downto 0 loop
         retVar((idx*32)+31 downto (idx*32)) := ts((i*32)+31 downto (i*32));
         idx                                 := idx + 1;
      end loop;

      -- Load the message array
      for i in (DATA_SIZE_G-1) downto 0 loop
         retVar((idx*32)+31 downto (idx*32)) := msg(i);
         idx                                 := idx + 1;
      end loop;

      return retVar;
   end function;

   type StateType is (
      IDLE_S,
      DATA_S,
      CRC_S);

   type RegType is record
      cnt      : natural range 0 to SIZE_C;
      fifoRd   : sl;
      crcRst   : sl;
      crcValid : sl;
      crcData  : slv(31 downto 0);
      txMaster : AxiStreamMasterType;
      state    : StateType;
   end record RegType;
   constant REG_INIT_C : RegType := (
      cnt      => 0,
      fifoRd   => '0',
      crcRst   => '1',
      crcValid => '0',
      crcData  => (others => '0'),
      txMaster => AXI_STREAM_MASTER_INIT_C,
      state    => IDLE_S);

   signal r   : RegType := REG_INIT_C;
   signal rin : RegType;

   signal txMaster : AxiStreamMasterType;
   signal txSlave  : AxiStreamSlaveType;

   signal valid     : sl;
   signal fifoRd    : sl;
   signal fifoDin   : slv(DATA_WIDTH_G-1 downto 0);
   signal fifoDout  : slv(DATA_WIDTH_G-1 downto 0);
   signal crcResult : slv(31 downto 0) := (others => '0');

   -- attribute dont_touch             : string;
   -- attribute dont_touch of r        : signal is "TRUE";   

begin

   fifoDin <= toSlv(header, timeStamp, data);

   RX_FIFO : entity work.SynchronizerFifo
      generic map (
         TPD_G        => TPD_G,
         DATA_WIDTH_G => DATA_WIDTH_G)
      port map (
         rst    => rst,
         -- Write Ports
         wr_clk => clk,
         wr_en  => strobe,
         din    => fifoDin,
         -- Read Ports
         rd_clk => axilClk,
         rd_en  => fifoRd,
         valid  => valid,
         dout   => fifoDout);

   comb : process (axilRst, crcResult, fifoDout, r, txSlave, valid) is
      variable v : RegType;
   begin
      -- Latch the current value
      v := r;

      -- Reset the flags
      v.fifoRd   := '0';
      v.crcRst   := '0';
      v.crcValid := '0';
      if txSlave.tReady = '1' then
         v.txMaster.tValid := '0';
         v.txMaster.tLast  := '0';
         v.txMaster.tUser  := (others => '0');
      end if;

      -- State Machine
      case r.state is
         ----------------------------------------------------------------------
         when IDLE_S =>
            -- Check for new data
            if (valid = '1') then
               -- Next state
               v.state := DATA_S;
            end if;
         ----------------------------------------------------------------------
         when DATA_S =>
            -- Check if ready to move data
            if (v.txMaster.tValid = '0') then
               -- Move data
               v.txMaster.tValid             := '1';
               v.txMaster.tData(31 downto 0) := fifoDout((32*r.cnt)+31 downto (32*r.cnt));
               -- Update the CRC engine
               v.crcValid                    := '1';
               v.crcData                     := v.txMaster.tData(31 downto 0);
               -- Increment the counter
               v.cnt                         := r.cnt + 1;
               -- Check for first FIFO word
               if (r.cnt = 0) then
                  -- Set SOF
                  ssiSetUserSof(AXIS_CONFIG_C, v.txMaster, '1');
               end if;
               -- Check for last FIFO word
               if (r.cnt = (SIZE_C-1)) then
                  -- Reset the counter
                  v.cnt    := 0;
                  -- Accept the data from the FIFO
                  v.fifoRd := '1';
                  -- Check if CRC is enabled
                  if (EN_CRC_G = true) then
                     -- Next state
                     v.state := CRC_S;
                  else
                     -- Set the EOF flag
                     v.txMaster.tLast := '1';
                     -- Next state
                     v.state          := IDLE_S;
                  end if;
               end if;
            end if;
         ----------------------------------------------------------------------
         when CRC_S =>
            -- Increment the counter
            if (r.cnt /= 3) then
               v.cnt := r.cnt + 1;
            end if;
            -- Check if ready to move data
            if (v.txMaster.tValid = '0') and (r.cnt = 3) then
               -- Move data
               v.txMaster.tValid             := '1';
               v.txMaster.tLast              := '1';
               v.txMaster.tData(31 downto 0) := crcResult;
               -- Reset the counter
               v.cnt                         := 0;
               -- Reset the CRC engine
               v.crcRst                      := '1';
               -- Next state
               v.state                       := IDLE_S;
            end if;
      ----------------------------------------------------------------------
      end case;

      -- Update the TDEST routing
      v.txMaster.tDest := TDEST_G;

      -- Reset
      if (axilRst = '1') then
         v := REG_INIT_C;
      end if;

      -- Register the variable for next clock cycle
      rin <= v;

      -- Outputs        
      fifoRd   <= v.fifoRd;
      txMaster <= r.txMaster;

   end process comb;

   seq : process (axilClk) is
   begin
      if rising_edge(axilClk) then
         r <= rin after TPD_G;
      end if;
   end process seq;

   GEN_CRC : if (EN_CRC_G = true) generate
      U_Crc32 : entity work.Crc32Parallel
         generic map (
            TPD_G        => TPD_G,
            BYTE_WIDTH_G => 4)
         port map (
            crcClk       => axilClk,
            crcReset     => r.crcRst,
            crcDataWidth => "011",      -- 4 bytes 
            crcDataValid => r.crcValid,
            crcIn        => r.crcData,
            crcOut       => crcResult);
   end generate;

   TX_FIFO : entity work.AxiStreamFifoV2
      generic map (
         -- General Configurations
         TPD_G               => TPD_G,
         SLAVE_READY_EN_G    => true,
         VALID_THOLD_G       => 1,
         -- FIFO configurations
         BRAM_EN_G           => BRAM_EN_G,
         GEN_SYNC_FIFO_G     => true,
         FIFO_ADDR_WIDTH_G   => FIFO_ADDR_WIDTH_G,
         -- AXI Stream Port Configurations
         SLAVE_AXI_CONFIG_G  => AXIS_CONFIG_C,
         MASTER_AXI_CONFIG_G => EMAC_AXIS_CONFIG_C)
      port map (
         -- Slave Port
         sAxisClk    => axilClk,
         sAxisRst    => axilRst,
         sAxisMaster => txMaster,
         sAxisSlave  => txSlave,
         -- Master Port
         mAxisClk    => axilClk,
         mAxisRst    => axilRst,
         mAxisMaster => obMsgMaster,
         mAxisSlave  => obMsgSlave);

end rtl;