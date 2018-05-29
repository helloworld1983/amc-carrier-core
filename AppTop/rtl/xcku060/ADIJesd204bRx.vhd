-------------------------------------------------------------------------------
-- File       : ADIJesd204bRx.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2015-04-14
-- Last update: 2018-05-03
-------------------------------------------------------------------------------
-- Description: JESD204b multi-lane receiver module
--              Receiver JESD204b module.
--              Supports a subset of features from JESD204b standard.
--              Supports sub-class 1 deterministic latency.
--              Supports sub-class 0 non deterministic latency.
--              Features:
--              - Synchronization of LMFC to SYSREF
--              - Multi-lane operation (L_G: 1-16)
--              - Lane alignment using RX buffers
--              - Serial lane error check
--              - Alignment character replacement and alignment check
--               
--          Note: sampleDataArr_o is little endian and not byte-swapped
--                First sample in time:  sampleData_o(15 downto 0) 
--                Second sample in time: sampleData_o(31 downto 16)
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'SLAC Firmware Standard Library', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.StdRtlPkg.all;
use work.AxiLitePkg.all;
use work.AxiStreamPkg.all;
use work.SsiPkg.all;

use work.Jesd204bPkg.all;

entity ADIJesd204bRx is
   generic ( 
      TPD_G : time := 1 ns;

      -- Test tx module instead of GTX
      TEST_G : boolean := false;

      -- JESD generics

      -- Number of bytes in a frame (1,2,or 4)
      F_G : positive := 2;

      -- Number of frames in a multi frame (32)
      K_G : positive := 32;

      -- Number of RX lanes (1 to 32)
      L_G : positive range 1 to 32 := 2);

   port (
      -- AXI interface      
      -- Clocks and Resets
      axiClk : in sl;
      axiRst : in sl;

      -- AXI-Lite Register Interface
      axilReadMaster  : in  AxiLiteReadMasterType;
      axilReadSlave   : out AxiLiteReadSlaveType;
      axilWriteMaster : in  AxiLiteWriteMasterType;
      axilWriteSlave  : out AxiLiteWriteSlaveType;

      -- Sample data output (Use if external data acquisition core is attached)
      sampleDataArr_o : out sampleDataArray(L_G-1 downto 0);
      dataValidVec_o  : out slv(L_G-1 downto 0);

      -- JESD
      -- Clocks and Resets   
      devClk_i : in sl;
      devRst_i : in sl;

      -- SYSREF for subclass 1 fixed latency
      sysRef_i : in sl;

      -- SYSREF output for debug
      sysRefDbg_o : out sl;

      -- Data and character inputs from GT (transceivers)
      r_jesdGtRxArr : in  jesdGtRxLaneTypeArray(L_G-1 downto 0);
      phyEnCharAlign: out sl;
      gtRxReset_o   : out slv(L_G-1 downto 0);

      rxPowerDown : out slv(L_G-1 downto 0);
      rxPolarity  : out slv(L_G-1 downto 0);

      -- Synchronization output combined from all receivers 
      nSync_o : out sl;

      -- Debug signals
      pulse_o : out slv(L_G-1 downto 0);
      leds_o  : out slv(1 downto 0)
      );
end ADIJesd204bRx;

architecture rtl of ADIJesd204bRx is

   component jesd204_rx_0
      port (
         clk                          : in  std_logic;
         reset                        : in  std_logic;
         phy_data                     : in  std_logic_vector(32*10-1 downto 0);
         phy_charisk                  : in  std_logic_vector(4*10-1 downto 0);
         phy_notintable               : in  std_logic_vector(4*10-1 downto 0);
         phy_disperr                  : in  std_logic_vector(4*10-1 downto 0);
         sysref                       : in  std_logic;
         lmfc_edge                    : out std_logic;
         lmfc_clk                     : out std_logic;
         event_sysref_alignment_error : out std_logic;
         event_sysref_edge            : out std_logic;
         sync                         : out std_logic_vector(1-1 downto 0);
         phy_en_char_align            : out std_logic;
         rx_data                      : out std_logic_vector(32*10-1 downto 0);
         rx_valid                     : out std_logic;
         rx_eof                       : out std_logic_vector(3 downto 0);
         rx_sof                       : out std_logic_vector(3 downto 0);
         cfg_lanes_disable            : in  std_logic_vector(10-1 downto 0);
         cfg_links_disable            : in  std_logic_vector(0 downto 0);
         cfg_beats_per_multiframe     : in  std_logic_vector(7 downto 0);
         cfg_octets_per_frame         : in  std_logic_vector(7 downto 0);
         cfg_lmfc_offset              : in  std_logic_vector(7 downto 0);
         cfg_sysref_disable           : in  std_logic;
         cfg_sysref_oneshot           : in  std_logic;
         cfg_buffer_early_release     : in  std_logic;
         cfg_buffer_delay             : in  std_logic_vector(7 downto 0);
         cfg_disable_char_replacement : in  std_logic;
         cfg_disable_scrambler        : in  std_logic;
         ctrl_err_statistics_reset    : in  std_logic;
         ctrl_err_statistics_mask     : in  std_logic_vector(2 downto 0);
         status_err_statistics_cnt    : out std_logic_vector(32*10-1 downto 0);
         ilas_config_valid            : out std_logic_vector(10-1 downto 0);
         ilas_config_addr             : out std_logic_vector(10*2-1 downto 0);
         ilas_config_data             : out std_logic_vector(10*32-1 downto 0);
         status_ctrl_state            : out std_logic_vector(1 downto 0);
         status_lane_cgs_state        : out std_logic_vector(10*2-1 downto 0);
         status_lane_ifs_ready        : out std_logic_vector(10-1 downto 0);
         status_lane_latency          : out std_logic_vector(10*14-1 downto 0)
      );
   end component;

   component axi_jesd204_rx_0
      port (
         s_axi_aclk                        : in std_logic;
         s_axi_aresetn                     : in std_logic;
         s_axi_awvalid                     : in std_logic;
         s_axi_awaddr                      : in std_logic_vector(13 downto 0);
         s_axi_awready                     : out std_logic;
         s_axi_awprot                      : in std_logic_vector(2 downto 0);
         s_axi_wvalid                      : in std_logic;
         s_axi_wdata                       : in std_logic_vector(31 downto 0);
         s_axi_wstrb                       : in std_logic_vector(3 downto 0);
         s_axi_wready                      : out std_logic;
         s_axi_bvalid                      : out std_logic;
         s_axi_bresp                       : out std_logic_vector(1 downto 0);
         s_axi_bready                      : in std_logic;
         s_axi_arvalid                     : in std_logic;
         s_axi_araddr                      : in std_logic_vector(13 downto 0);
         s_axi_arready                     : out std_logic;
         s_axi_arprot                      : in std_logic_vector(2 downto 0);
         s_axi_rvalid                      : out std_logic;
         s_axi_rready                      : in std_logic;
         s_axi_rresp                       : out std_logic_vector(1 downto 0);
         s_axi_rdata                       : out std_logic_vector(31 downto 0);
         irq                               : out std_logic;
         core_clk                          : in std_logic;
         core_reset_ext                    : in std_logic;
         core_reset                        : out std_logic;
         core_cfg_lanes_disable            : out std_logic_vector(10-1 downto 0);
         core_cfg_links_disable            : out std_logic_vector(0 downto 0);
         core_cfg_beats_per_multiframe     : out std_logic_vector(7 downto 0);
         core_cfg_octets_per_frame         : out std_logic_vector(7 downto 0);
         core_cfg_disable_scrambler        : out std_logic;
         core_cfg_disable_char_replacement : out std_logic;
         core_cfg_lmfc_offset              : out std_logic_vector(7 downto 0);
         core_cfg_sysref_oneshot           : out std_logic;
         core_cfg_sysref_disable           : out std_logic;
         core_cfg_buffer_early_release     : out std_logic;
         core_cfg_buffer_delay             : out std_logic_vector(7 downto 0);
         core_ilas_config_valid            : in  std_logic_vector(10-1 downto 0);
         core_ilas_config_addr             : in  std_logic_vector(10*2-1 downto 0);
         core_ilas_config_data             : in  std_logic_vector(10*32-1 downto 0);
         core_event_sysref_alignment_error : in  std_logic;
         core_event_sysref_edge            : in  std_logic;
         core_ctrl_err_statistics_mask     : out std_logic_vector(2 downto 0);
         core_ctrl_err_statistics_reset    : out std_logic;
         core_status_err_statistics_cnt    : in  std_logic_vector(10*32-1 downto 0);
         core_status_ctrl_state            : in  std_logic_vector(1 downto 0);
         core_status_lane_cgs_state        : in  std_logic_vector(10*2-1 downto 0);
         core_status_lane_ifs_ready        : in  std_logic_vector(10-1 downto 0);
         core_status_lane_latency          : in  std_logic_vector(10*14-1 downto 0)
      );
   end component;

   -- Internal signals
   signal s_sampleDataArr                : sampleDataArray(L_G-1 downto 0);
   signal s_rx_data                      : slv(L_G*32-1 downto 0);
   signal s_rx_valid                     : sl;
   signal s_sync                         : slv(1-1 downto 0);
   signal s_event_sysref_edge            : sl;
   signal s_core_reset                   : sl;
   signal s_cfg_lanes_disable            : slv(L_G-1 downto 0);
   signal s_cfg_links_disable            : slv(0 downto 0);
   signal s_cfg_beats_per_multiframe     : slv(7 downto 0);
   signal s_cfg_octets_per_frame         : slv(7 downto 0);
   signal s_cfg_lmfc_offset              : slv(7 downto 0);
   signal s_cfg_sysref_disable           : sl;
   signal s_cfg_sysref_oneshot           : sl;
   signal s_cfg_buffer_early_release     : sl;
   signal s_cfg_buffer_delay             : slv(7 downto 0);
   signal s_cfg_disable_char_replacement : sl;
   signal s_cfg_disable_scrambler        : sl;
   signal s_ctrl_err_statistics_reset    : sl;
   signal s_ctrl_err_statistics_mask     : slv(2 downto 0);
   signal s_status_err_statistics_cnt    : slv(L_G*32-1 downto 0);
   signal s_ilas_config_valid            : slv(L_G-1 downto 0);
   signal s_ilas_config_addr             : slv(L_G*2-1 downto 0);
   signal s_ilas_config_data             : slv(L_G*32-1 downto 0);
   signal s_status_ctrl_state            : slv(1 downto 0);
   signal s_status_lane_cgs_state        : slv(L_G*2-1 downto 0);
   signal s_status_lane_ifs_ready        : slv(L_G-1 downto 0);
   signal s_status_lane_latency          : slv(L_G*14-1 downto 0);
   signal s_event_sysref_alignment_error : sl;

   signal s_phy_data       : slv(L_G*32-1 downto 0);
   signal s_phy_charisk    : slv(L_G*4-1 downto 0);
   signal s_phy_notintable : slv(L_G*4-1 downto 0);
   signal s_phy_disperr    : slv(L_G*4-1 downto 0);

begin

   -- Check JESD generics
   assert (((K_G * F_G) mod GT_WORD_SIZE_C) = 0) report "K_G setting is incorrect" severity failure;
   assert (F_G = 1 or F_G = 2 or (F_G = 4 and GT_WORD_SIZE_C = 4)) report "F_G setting must be 1,2,or 4*" severity failure;

   ----------------------------------------------------------- 
   U_GEN_PHY_DATA : for i in L_G-1 downto 0 generate
      s_phy_data(       32*(i+1)-1 downto 32*i) <= r_jesdGtRxArr(i).data;
      s_phy_charisk(     4*(i+1)-1 downto  4*i) <= r_jesdGtRxArr(i).dataK;
      s_phy_notintable(  4*(i+1)-1 downto  4*i) <= r_jesdGtRxArr(i).decErr;
      s_phy_disperr(     4*(i+1)-1 downto  4*i) <= r_jesdGtRxArr(i).dispErr;
   end generate;

   U_JESD204_RX : jesd204_rx_0
      port map (
         clk                          => devClk_i,
         reset                        => s_core_reset,
         phy_data                     => s_phy_data, 
         phy_charisk                  => s_phy_charisk,
         phy_notintable               => s_phy_notintable,
         phy_disperr                  => s_phy_disperr,
         sysref                       => sysRef_i,
         lmfc_edge                    => open,
         lmfc_clk                     => open,
         event_sysref_alignment_error => s_event_sysref_alignment_error,
         event_sysref_edge            => s_event_sysref_edge,
         sync                         => s_sync,
         phy_en_char_align            => phyEnCharAlign,
         rx_data                      => s_rx_data,
         rx_valid                     => s_rx_valid,
         rx_eof                       => open,
         rx_sof                       => open,
         cfg_lanes_disable            => s_cfg_lanes_disable,
         cfg_links_disable            => s_cfg_links_disable,
         cfg_beats_per_multiframe     => s_cfg_beats_per_multiframe,
         cfg_octets_per_frame         => s_cfg_octets_per_frame,
         cfg_lmfc_offset              => s_cfg_lmfc_offset,
         cfg_sysref_disable           => s_cfg_sysref_disable,
         cfg_sysref_oneshot           => s_cfg_sysref_oneshot,
         cfg_buffer_early_release     => s_cfg_buffer_early_release,
         cfg_buffer_delay             => s_cfg_buffer_delay,
         cfg_disable_char_replacement => s_cfg_disable_char_replacement,
         cfg_disable_scrambler        => s_cfg_disable_scrambler,
         ctrl_err_statistics_reset    => s_ctrl_err_statistics_reset,
         ctrl_err_statistics_mask     => s_ctrl_err_statistics_mask,
         status_err_statistics_cnt    => s_status_err_statistics_cnt,
         ilas_config_valid            => s_ilas_config_valid,
         ilas_config_addr             => s_ilas_config_addr,
         ilas_config_data             => s_ilas_config_data,
         status_ctrl_state            => s_status_ctrl_state,
         status_lane_cgs_state        => s_status_lane_cgs_state,
         status_lane_ifs_ready        => s_status_lane_ifs_ready,
         status_lane_latency          => s_status_lane_latency);

   U_AXI_JESD204_RX : axi_jesd204_rx_0
      port map (
         s_axi_aclk                        => axiClk,
         s_axi_aresetn                     => not(axiRst),
         s_axi_awvalid                     => axilWriteMaster.awvalid,
         s_axi_awaddr                      => axilWriteMaster.awaddr(13 downto 0),
         s_axi_awready                     => axilWriteSlave.awready,
         s_axi_awprot                      => axilWriteMaster.awprot,
         s_axi_wvalid                      => axilWriteMaster.wvalid,
         s_axi_wdata                       => axilWriteMaster.wdata,
         s_axi_wstrb                       => axilWriteMaster.wstrb,
         s_axi_wready                      => axilWriteSlave.wready,
         s_axi_bvalid                      => axilWriteSlave.bvalid,
         s_axi_bresp                       => axilWriteSlave.bresp,
         s_axi_bready                      => axilWriteMaster.bready,
         s_axi_arvalid                     => axilReadMaster.arvalid,
         s_axi_araddr                      => axilReadMaster.araddr(13 downto 0),
         s_axi_arready                     => axilReadSlave.arready,
         s_axi_arprot                      => axilReadMaster.arprot,
         s_axi_rvalid                      => axilReadSlave.rvalid,
         s_axi_rready                      => axilReadMaster.rready,
         s_axi_rresp                       => axilReadSlave.rresp,
         s_axi_rdata                       => axilReadSlave.rdata,
         irq                               => open,
         core_clk                          => devClk_i,
         core_reset_ext                    => devRst_i,
         core_reset                        => s_core_reset,
         core_cfg_lanes_disable            => s_cfg_lanes_disable,
         core_cfg_links_disable            => s_cfg_links_disable,
         core_cfg_beats_per_multiframe     => s_cfg_beats_per_multiframe,
         core_cfg_octets_per_frame         => s_cfg_octets_per_frame,
         core_cfg_disable_scrambler        => s_cfg_disable_scrambler,
         core_cfg_disable_char_replacement => s_cfg_disable_char_replacement,
         core_cfg_lmfc_offset              => s_cfg_lmfc_offset,
         core_cfg_sysref_oneshot           => s_cfg_sysref_oneshot,
         core_cfg_sysref_disable           => s_cfg_sysref_disable,
         core_cfg_buffer_early_release     => s_cfg_buffer_early_release,
         core_cfg_buffer_delay             => s_cfg_buffer_delay,
         core_ilas_config_valid            => s_ilas_config_valid,
         core_ilas_config_addr             => s_ilas_config_addr,
         core_ilas_config_data             => s_ilas_config_data,
         core_event_sysref_alignment_error => s_event_sysref_alignment_error,
         core_event_sysref_edge            => s_event_sysref_edge,
         core_ctrl_err_statistics_mask     => s_ctrl_err_statistics_mask ,
         core_ctrl_err_statistics_reset    => s_ctrl_err_statistics_reset,
         core_status_err_statistics_cnt    => s_status_err_statistics_cnt,
         core_status_ctrl_state            => s_status_ctrl_state,
         core_status_lane_cgs_state        => s_status_lane_cgs_state,
         core_status_lane_ifs_ready        => s_status_lane_ifs_ready,
         core_status_lane_latency          => s_status_lane_latency);

   U_GEN_OUTPUT : 
   for i in L_G-1 downto 0 generate
      dataValidVec_o(i)  <= s_rx_valid;
      s_sampleDataArr(i) <= s_rx_data(32*(i+1)-1 downto 32*i); 
      sampleDataArr_o(i) <= s_sampleDataArr(i)(23 downto 16) & s_sampleDataArr(i)(31 downto 24) & s_sampleDataArr(i)(7 downto 0) & s_sampleDataArr(i)(15 downto 8); 
   end generate; 

   nSync_o      <= s_sync(0);

   gtRxReset_o  <= (others => '0');
   rxPowerDown  <= (others => '0');
   rxPolarity   <= "0100000000";    -- 0x100

   sysRefDbg_o  <= '0';
   leds_o       <= (others => '0');
   pulse_o      <= (others => '0');

end rtl;
