# For Snickerdoodle black

# Setting
set PRJ_NAME    sdb_simple
set PRJ_DIR     vivado
set SRC_DIR     src/vivado


# Create project
create_project ${PRJ_NAME} ${PRJ_DIR} -part xc7z020clg400-3
set_property board_part krtkl.com:snickerdoodle_black:part0:1.0 [current_project]

# Block design & HDL wrapper
create_bd_design ${PRJ_NAME}

set SRCS [get_files ${PRJ_DIR}/${PRJ_NAME}.srcs/sources_1/bd/${PRJ_NAME}/${PRJ_NAME}.bd]
#  [format "%s" ${PRJ_DIR}/${PRJ_NAME}.srcs/sources_1/bd/${PRJ_NAME}/${PRJ_NAME}.bd ]
make_wrapper -files ${SRCS} -top
add_files -norecurse ${PRJ_DIR}/${PRJ_NAME}.srcs/sources_1/bd/${PRJ_NAME}/hdl/${PRJ_NAME}_wrapper.v

# PS
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {0} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]

# Resets
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_2

# Clocking wizard
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.4 clk_wiz_0
set_property -dict [list CONFIG.ENABLE_CLOCK_MONITOR {false} CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_USED {true} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {150.000} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200.000} CONFIG.PRIMITIVE {MMCM} CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.000} CONFIG.MMCM_CLKOUT1_DIVIDE {8} CONFIG.MMCM_CLKOUT2_DIVIDE {6} CONFIG.NUM_OUT_CLKS {3} CONFIG.CLKOUT1_JITTER {115.831} CONFIG.CLKOUT1_PHASE_ERROR {87.180} CONFIG.CLKOUT2_JITTER {107.567} CONFIG.CLKOUT2_PHASE_ERROR {87.180} CONFIG.CLKOUT3_JITTER {102.086} CONFIG.CLKOUT3_PHASE_ERROR {87.180} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.RESET_PORT {resetn}] [get_bd_cells clk_wiz_0]

# Concat
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0
set_property -dict [list CONFIG.NUM_PORTS {1}] [get_bd_cells xlconcat_0]

# Connection
connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins clk_wiz_0/resetn]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins proc_sys_reset_0/ext_reset_in]
connect_bd_net [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins proc_sys_reset_2/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins proc_sys_reset_2/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
connect_bd_net [get_bd_pins proc_sys_reset_1/dcm_locked] [get_bd_pins clk_wiz_0/locked]
connect_bd_net [get_bd_pins proc_sys_reset_2/dcm_locked] [get_bd_pins clk_wiz_0/locked]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins clk_wiz_0/clk_in1]


# Create platform
source ${SRC_DIR}/create_sds_pfm.tcl


regenerate_bd_layout
validate_bd_design
save_bd_design

# Generate HW
set SRCS [get_files ${PRJ_DIR}/${PRJ_NAME}.srcs/sources_1/bd/${PRJ_NAME}/${PRJ_NAME}.bd]
generate_target all ${SRCS}
file mkdir ${PRJ_DIR}/sdb_simple.sdk
write_hwdef -force  -file ${PRJ_DIR}/${PRJ_NAME}.sdk/${PRJ_NAME}_wrapper.hdf

# Export DSA
write_dsa –force ${PRJ_DIR}/${PRJ_NAME}.dsa
validate_dsa ${PRJ_DIR}/${PRJ_NAME}.dsa