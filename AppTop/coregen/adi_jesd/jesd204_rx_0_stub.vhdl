-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4.1 (win64) Build 2117270 Tue Jan 30 15:32:00 MST 2018
-- Date        : Sun Jul 15 19:41:18 2018
-- Host        : DESKTOP-CKBT0LV running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Mitch/workspace/hdl/library/jesd204/jesd204_rx/jesd204_rx.srcs/sources_1/ip/jesd204_rx_0/jesd204_rx_0_stub.vhdl
-- Design      : jesd204_rx_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010iclg225-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jesd204_rx_0 is
  Port ( 
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    phy_data : in STD_LOGIC_VECTOR ( 319 downto 0 );
    phy_charisk : in STD_LOGIC_VECTOR ( 39 downto 0 );
    phy_notintable : in STD_LOGIC_VECTOR ( 39 downto 0 );
    phy_disperr : in STD_LOGIC_VECTOR ( 39 downto 0 );
    sysref : in STD_LOGIC;
    lmfc_edge : out STD_LOGIC;
    lmfc_clk : out STD_LOGIC;
    event_sysref_alignment_error : out STD_LOGIC;
    event_sysref_edge : out STD_LOGIC;
    sync : out STD_LOGIC_VECTOR ( 0 to 0 );
    phy_en_char_align : out STD_LOGIC;
    rx_data : out STD_LOGIC_VECTOR ( 319 downto 0 );
    rx_valid : out STD_LOGIC;
    rx_eof : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rx_sof : out STD_LOGIC_VECTOR ( 3 downto 0 );
    cfg_lanes_disable : in STD_LOGIC_VECTOR ( 9 downto 0 );
    cfg_links_disable : in STD_LOGIC_VECTOR ( 0 to 0 );
    cfg_beats_per_multiframe : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cfg_octets_per_frame : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cfg_lmfc_offset : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cfg_sysref_disable : in STD_LOGIC;
    cfg_sysref_oneshot : in STD_LOGIC;
    cfg_buffer_early_release : in STD_LOGIC;
    cfg_buffer_delay : in STD_LOGIC_VECTOR ( 7 downto 0 );
    cfg_disable_char_replacement : in STD_LOGIC;
    cfg_disable_scrambler : in STD_LOGIC;
    ctrl_err_statistics_reset : in STD_LOGIC;
    ctrl_err_statistics_mask : in STD_LOGIC_VECTOR ( 2 downto 0 );
    status_err_statistics_cnt : out STD_LOGIC_VECTOR ( 319 downto 0 );
    ilas_config_valid : out STD_LOGIC_VECTOR ( 9 downto 0 );
    ilas_config_addr : out STD_LOGIC_VECTOR ( 19 downto 0 );
    ilas_config_data : out STD_LOGIC_VECTOR ( 319 downto 0 );
    status_ctrl_state : out STD_LOGIC_VECTOR ( 1 downto 0 );
    status_lane_cgs_state : out STD_LOGIC_VECTOR ( 19 downto 0 );
    status_lane_ifs_ready : out STD_LOGIC_VECTOR ( 9 downto 0 );
    status_lane_latency : out STD_LOGIC_VECTOR ( 139 downto 0 )
  );

end jesd204_rx_0;

architecture stub of jesd204_rx_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,reset,phy_data[319:0],phy_charisk[39:0],phy_notintable[39:0],phy_disperr[39:0],sysref,lmfc_edge,lmfc_clk,event_sysref_alignment_error,event_sysref_edge,sync[0:0],phy_en_char_align,rx_data[319:0],rx_valid,rx_eof[3:0],rx_sof[3:0],cfg_lanes_disable[9:0],cfg_links_disable[0:0],cfg_beats_per_multiframe[7:0],cfg_octets_per_frame[7:0],cfg_lmfc_offset[7:0],cfg_sysref_disable,cfg_sysref_oneshot,cfg_buffer_early_release,cfg_buffer_delay[7:0],cfg_disable_char_replacement,cfg_disable_scrambler,ctrl_err_statistics_reset,ctrl_err_statistics_mask[2:0],status_err_statistics_cnt[319:0],ilas_config_valid[9:0],ilas_config_addr[19:0],ilas_config_data[319:0],status_ctrl_state[1:0],status_lane_cgs_state[19:0],status_lane_ifs_ready[9:0],status_lane_latency[139:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "jesd204_rx,Vivado 2017.4.1";
begin
end;
