##############################################################################
## This file is part of 'LCLS2 Common Carrier Core'.
## It is subject to the license terms in the LICENSE.txt file found in the 
## top-level directory of this distribution and at: 
##    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
## No part of 'LCLS2 Common Carrier Core', including this file, 
## may be copied, modified, propagated, or distributed except according to 
## the terms contained in the LICENSE.txt file.
##############################################################################

## Get variables and Custom Procedures
set VIVADO_BUILD_DIR $::env(VIVADO_BUILD_DIR)
source -quiet ${VIVADO_BUILD_DIR}/vivado_env_var_v1.tcl
source -quiet ${VIVADO_BUILD_DIR}/vivado_proc_v1.tcl

## Check for version 2016.2 of Vivado
if { [VersionCheck 2016.2] < 0 } {
   close_project
   exit -1
}

# Check for Application Microblaze build
if { [expr [info exists ::env(SDK_SRC_PATH)]] == 0 } {
   ## Add the Microblaze Calibration Code
   add_files ${TOP_DIR}/modules/AmcCarrierCore/$::env(AMC_TAG)/coregen/MigCoreMicroblazeCalibration.elf
   set_property SCOPED_TO_REF   {MigCore} [get_files MigCoreMicroblazeCalibration.elf]
   set_property SCOPED_TO_CELLS {inst/u_ddr3_mem_intfc/u_ddr_cal_riu/mcs0/microblaze_I} [get_files MigCoreMicroblazeCalibration.elf]

   add_files ${TOP_DIR}/modules/AmcCarrierCore/$::env(AMC_TAG)/coregen/MigCoreMicroblazeCalibration.bmm
   set_property SCOPED_TO_REF   {MigCore} [get_files MigCoreMicroblazeCalibration.bmm]
   set_property SCOPED_TO_CELLS {inst/u_ddr3_mem_intfc/u_ddr_cal_riu/mcs0} [get_files MigCoreMicroblazeCalibration.bmm]
}

## BSA's .DCP files
add_files -quiet -fileset sources_1 ${TOP_DIR}/modules/BsaCore/$::env(BSA_TAG)/cores/BsaAxiInterconnect/xilinxUltraScale/BsaAxiInterconnect.dcp

## Place and Route strategies 
set_property strategy Performance_Explore [get_runs impl_1]
set_property STEPS.OPT_DESIGN.ARGS.DIRECTIVE Explore [get_runs impl_1]

## Skip the utilization check during placement
set_param place.skipUtilizationCheck 1
