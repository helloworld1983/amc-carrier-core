// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Tue Jan  9 15:26:40 2018
// Host        : rdsrv221 running 64-bit Red Hat Enterprise Linux Server release 6.9 (Santiago)
// Command     : write_verilog -force -mode synth_stub
//               /u1/strauman/amc-carrier-project-template/firmware/submodules/amc-carrier-core/AmcCarrierCore/debug/dcp/Impl/images/UdpDebugBridge_stub.v
// Design      : UdpDebugBridge
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module UdpDebugBridge(axisClk, axisRst, \mAxisReq[tValid] , 
  \mAxisReq[tData] , \mAxisReq[tStrb] , \mAxisReq[tKeep] , \mAxisReq[tLast] , 
  \mAxisReq[tDest] , \mAxisReq[tId] , \mAxisReq[tUser] , \sAxisReq[tReady] , 
  \mAxisTdo[tValid] , \mAxisTdo[tData] , \mAxisTdo[tStrb] , \mAxisTdo[tKeep] , 
  \mAxisTdo[tLast] , \mAxisTdo[tDest] , \mAxisTdo[tId] , \mAxisTdo[tUser] , 
  \sAxisTdo[tReady] )
/* synthesis syn_black_box black_box_pad_pin="axisClk,axisRst,\mAxisReq[tValid] ,\mAxisReq[tData] [127:0],\mAxisReq[tStrb] [15:0],\mAxisReq[tKeep] [15:0],\mAxisReq[tLast] ,\mAxisReq[tDest] [7:0],\mAxisReq[tId] [7:0],\mAxisReq[tUser] [127:0],\sAxisReq[tReady] ,\mAxisTdo[tValid] ,\mAxisTdo[tData] [127:0],\mAxisTdo[tStrb] [15:0],\mAxisTdo[tKeep] [15:0],\mAxisTdo[tLast] ,\mAxisTdo[tDest] [7:0],\mAxisTdo[tId] [7:0],\mAxisTdo[tUser] [127:0],\sAxisTdo[tReady] " */;
  input axisClk;
  input axisRst;
  input \mAxisReq[tValid] ;
  input [127:0]\mAxisReq[tData] ;
  input [15:0]\mAxisReq[tStrb] ;
  input [15:0]\mAxisReq[tKeep] ;
  input \mAxisReq[tLast] ;
  input [7:0]\mAxisReq[tDest] ;
  input [7:0]\mAxisReq[tId] ;
  input [127:0]\mAxisReq[tUser] ;
  output \sAxisReq[tReady] ;
  output \mAxisTdo[tValid] ;
  output [127:0]\mAxisTdo[tData] ;
  output [15:0]\mAxisTdo[tStrb] ;
  output [15:0]\mAxisTdo[tKeep] ;
  output \mAxisTdo[tLast] ;
  output [7:0]\mAxisTdo[tDest] ;
  output [7:0]\mAxisTdo[tId] ;
  output [127:0]\mAxisTdo[tUser] ;
  input \sAxisTdo[tReady] ;
endmodule
