// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4.1 (win64) Build 2117270 Tue Jan 30 15:32:00 MST 2018
// Date        : Mon May 28 13:35:14 2018
// Host        : DESKTOP-CKBT0LV running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/mitch/workspace/hdl/library/jesd204/axi_jesd204_rx/axi_jesd204_rx.srcs/sources_1/ip/axi_jesd204_rx_0/axi_jesd204_rx_0_stub.v
// Design      : axi_jesd204_rx_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010iclg225-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi_jesd204_rx,Vivado 2017.4.1" *)
module axi_jesd204_rx_0(s_axi_aclk, s_axi_aresetn, s_axi_awvalid, 
  s_axi_awaddr, s_axi_awready, s_axi_awprot, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, 
  s_axi_wready, s_axi_bvalid, s_axi_bresp, s_axi_bready, s_axi_arvalid, s_axi_araddr, 
  s_axi_arready, s_axi_arprot, s_axi_rvalid, s_axi_rready, s_axi_rresp, s_axi_rdata, irq, 
  core_clk, core_reset_ext, core_reset, core_cfg_lanes_disable, 
  core_cfg_beats_per_multiframe, core_cfg_octets_per_frame, core_cfg_disable_scrambler, 
  core_cfg_disable_char_replacement, core_cfg_lmfc_offset, core_cfg_sysref_oneshot, 
  core_cfg_sysref_disable, core_cfg_buffer_early_release, core_cfg_buffer_delay, 
  core_ilas_config_valid, core_ilas_config_addr, core_ilas_config_data, 
  core_event_sysref_alignment_error, core_event_sysref_edge, core_status_ctrl_state, 
  core_status_lane_cgs_state, core_status_lane_ifs_ready, core_status_lane_latency)
/* synthesis syn_black_box black_box_pad_pin="s_axi_aclk,s_axi_aresetn,s_axi_awvalid,s_axi_awaddr[13:0],s_axi_awready,s_axi_awprot[2:0],s_axi_wvalid,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wready,s_axi_bvalid,s_axi_bresp[1:0],s_axi_bready,s_axi_arvalid,s_axi_araddr[13:0],s_axi_arready,s_axi_arprot[2:0],s_axi_rvalid,s_axi_rready,s_axi_rresp[1:0],s_axi_rdata[31:0],irq,core_clk,core_reset_ext,core_reset,core_cfg_lanes_disable[9:0],core_cfg_beats_per_multiframe[7:0],core_cfg_octets_per_frame[7:0],core_cfg_disable_scrambler,core_cfg_disable_char_replacement,core_cfg_lmfc_offset[7:0],core_cfg_sysref_oneshot,core_cfg_sysref_disable,core_cfg_buffer_early_release,core_cfg_buffer_delay[7:0],core_ilas_config_valid[9:0],core_ilas_config_addr[19:0],core_ilas_config_data[319:0],core_event_sysref_alignment_error,core_event_sysref_edge,core_status_ctrl_state[1:0],core_status_lane_cgs_state[19:0],core_status_lane_ifs_ready[9:0],core_status_lane_latency[139:0]" */;
  input s_axi_aclk;
  input s_axi_aresetn;
  input s_axi_awvalid;
  input [13:0]s_axi_awaddr;
  output s_axi_awready;
  input [2:0]s_axi_awprot;
  input s_axi_wvalid;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  output s_axi_wready;
  output s_axi_bvalid;
  output [1:0]s_axi_bresp;
  input s_axi_bready;
  input s_axi_arvalid;
  input [13:0]s_axi_araddr;
  output s_axi_arready;
  input [2:0]s_axi_arprot;
  output s_axi_rvalid;
  input s_axi_rready;
  output [1:0]s_axi_rresp;
  output [31:0]s_axi_rdata;
  output irq;
  input core_clk;
  input core_reset_ext;
  output core_reset;
  output [9:0]core_cfg_lanes_disable;
  output [7:0]core_cfg_beats_per_multiframe;
  output [7:0]core_cfg_octets_per_frame;
  output core_cfg_disable_scrambler;
  output core_cfg_disable_char_replacement;
  output [7:0]core_cfg_lmfc_offset;
  output core_cfg_sysref_oneshot;
  output core_cfg_sysref_disable;
  output core_cfg_buffer_early_release;
  output [7:0]core_cfg_buffer_delay;
  input [9:0]core_ilas_config_valid;
  input [19:0]core_ilas_config_addr;
  input [319:0]core_ilas_config_data;
  input core_event_sysref_alignment_error;
  input core_event_sysref_edge;
  input [1:0]core_status_ctrl_state;
  input [19:0]core_status_lane_cgs_state;
  input [9:0]core_status_lane_ifs_ready;
  input [139:0]core_status_lane_latency;
endmodule
