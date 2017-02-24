-------------------------------------------------------------------------------
-- File       : AmcGenericAdcDacDualCore.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-12-04
-- Last update: 2017-02-02
-------------------------------------------------------------------------------
-- Description: https://confluence.slac.stanford.edu/display/AIRTRACK/PC_379_396_13_CXX
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

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.jesd204bpkg.all;

entity AmcGenericAdcDacDualCore is
   generic (
      TPD_G            : time             := 1 ns;
      TRIG_CLK_G       : boolean          := false;
      CAL_CLK_G        : boolean          := false;
      AXI_CLK_FREQ_G   : real             := 156.25E+6;
      AXI_ERROR_RESP_G : slv(1 downto 0)  := AXI_RESP_DECERR_C;
      AXI_BASE_ADDR_G  : slv(31 downto 0) := (others => '0'));
   port (
      -- JESD SYNC Interface
      jesdClk         : in    slv(1 downto 0);
      jesdRst         : in    slv(1 downto 0);
      jesdSysRef      : out   slv(1 downto 0);
      jesdRxSync      : in    slv(1 downto 0);
      jesdTxSync      : out   slv(1 downto 0);
      -- ADC/DAC Interface (jesdClk domain)
      adcValids       : in    Slv7Array(1 downto 0);
      adcValues       : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
      dacValues       : in    sampleDataVectorArray(1 downto 0, 6 downto 0);
      dacVcoCtrl      : in    Slv16Array(1 downto 0);
      -- AXI-Lite Interface
      axilClk         : in    sl;
      axilRst         : in    sl;
      axilReadMaster  : in    AxiLiteReadMasterType;
      axilReadSlave   : out   AxiLiteReadSlaveType;
      axilWriteMaster : in    AxiLiteWriteMasterType;
      axilWriteSlave  : out   AxiLiteWriteSlaveType;
      -- Pass through Interfaces
      fpgaClk         : in    slv(1 downto 0);
      smaTrig         : in    slv(1 downto 0);
      adcCal          : in    slv(1 downto 0);
      lemoDin         : out   Slv2Array(1 downto 0);
      lemoDout        : in    Slv2Array(1 downto 0);
      bcm             : in    slv(1 downto 0);
      -----------------------
      -- Application Ports --
      -----------------------
      -- AMC's JTAG Ports
      jtagPri         : inout Slv5Array(1 downto 0);
      jtagSec         : inout Slv5Array(1 downto 0);
      -- AMC's FPGA Clock Ports
      fpgaClkP        : inout Slv2Array(1 downto 0);
      fpgaClkN        : inout Slv2Array(1 downto 0);
      -- AMC's System Reference Ports
      sysRefP         : inout Slv4Array(1 downto 0);
      sysRefN         : inout Slv4Array(1 downto 0);
      -- AMC's Sync Ports
      syncInP         : inout Slv4Array(1 downto 0);
      syncInN         : inout Slv4Array(1 downto 0);
      syncOutP        : inout Slv10Array(1 downto 0);
      syncOutN        : inout Slv10Array(1 downto 0);
      -- AMC's Spare Ports
      spareP          : inout Slv16Array(1 downto 0);
      spareN          : inout Slv16Array(1 downto 0));
end AmcGenericAdcDacDualCore;

architecture mapping of AmcGenericAdcDacDualCore is

   constant NUM_AXI_MASTERS_C : natural := 2;

   constant AXI_CONFIG_C : AxiLiteCrossbarMasterConfigArray(NUM_AXI_MASTERS_C-1 downto 0) := genAxiLiteConfig(NUM_AXI_MASTERS_C, AXI_BASE_ADDR_G, 20, 19);

   signal axilWriteMasters : AxiLiteWriteMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilWriteSlaves  : AxiLiteWriteSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadMasters  : AxiLiteReadMasterArray(NUM_AXI_MASTERS_C-1 downto 0);
   signal axilReadSlaves   : AxiLiteReadSlaveArray(NUM_AXI_MASTERS_C-1 downto 0);

begin

   ---------------------
   -- AXI-Lite Crossbar
   ---------------------
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

   -----------
   -- AMC Core
   -----------
   GEN_AMC : for i in 1 downto 0 generate
      U_AMC : entity work.AmcGenericAdcDacCore
         generic map (
            TPD_G            => TPD_G,
            TRIG_CLK_G       => TRIG_CLK_G,
            CAL_CLK_G        => CAL_CLK_G,
            AXI_CLK_FREQ_G   => AXI_CLK_FREQ_G,
            AXI_ERROR_RESP_G => AXI_ERROR_RESP_G,
            AXI_BASE_ADDR_G  => AXI_CONFIG_C(i).baseAddr)
         port map(
            -- JESD SYNC Interface
            jesdClk         => jesdClk(i),
            jesdRst         => jesdRst(i),
            jesdSysRef      => jesdSysRef(i),
            jesdRxSync      => jesdRxSync(i),
            jesdTxSync      => jesdTxSync(i),
            -- ADC/DAC Interface
            adcValids(0)    => adcValids(i)(0),
            adcValids(1)    => adcValids(i)(1),
            adcValids(2)    => adcValids(i)(2),
            adcValids(3)    => adcValids(i)(3),
            adcValues(0)    => adcValues(i, 0),
            adcValues(1)    => adcValues(i, 1),
            adcValues(2)    => adcValues(i, 2),
            adcValues(3)    => adcValues(i, 3),
            dacValues(0)    => dacValues(i, 0),
            dacValues(1)    => dacValues(i, 1),
            dacVcoCtrl      => dacVcoCtrl(i),
            -- AXI-Lite Interface
            axilClk         => axilClk,
            axilRst         => axilRst,
            axilReadMaster  => axilReadMasters(i),
            axilReadSlave   => axilReadSlaves(i),
            axilWriteMaster => axilWriteMasters(i),
            axilWriteSlave  => axilWriteSlaves(i),
            -- Pass through Interfaces
            fpgaClk         => fpgaClk(i),
            smaTrig         => smaTrig(i),
            adcCal          => adcCal(i),
            lemoDin         => lemoDin(i),
            lemoDout        => lemoDout(i),
            bcm             => bcm(i),
            -----------------------
            -- Application Ports --
            -----------------------
            -- AMC's JTAG Ports
            jtagPri         => jtagPri(i),
            jtagSec         => jtagSec(i),
            -- AMC's FPGA Clock Ports
            fpgaClkP        => fpgaClkP(i),
            fpgaClkN        => fpgaClkN(i),
            -- AMC's System Reference Ports
            sysRefP         => sysRefP(i),
            sysRefN         => sysRefN(i),
            -- AMC's Sync Ports
            syncInP         => syncInP(i),
            syncInN         => syncInN(i),
            syncOutP        => syncOutP(i),
            syncOutN        => syncOutN(i),
            -- AMC's Spare Ports
            spareP          => spareP(i),
            spareN          => spareN(i));
   end generate GEN_AMC;

end mapping;