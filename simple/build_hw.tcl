#-----------------------------------------------------------
# Vivado v2017.1_sdx (64-bit)
# SW Build 1915620 on Thu Jun 22 17:54:59 MDT 2017
# IP Build 1908669 on Thu Jun 22 19:20:41 MDT 2017
# Start of session at: Sat Sep  2 05:52:23 2017
# Process ID: 2487
# Current directory: /home/imagingtechnerd
# Command line: vivado
# Log file: /home/imagingtechnerd/vivado.log
# Journal file: /home/imagingtechnerd/vivado.jou
#-----------------------------------------------------------
#start_gui

set proj_name=sd_blk
set proj_root=.

create_project sd_blk /home/imagingtechnerd/vivado/2017.1/sd_blk -part xc7z020clg400-3
set_property board_part krtkl.com:snickerdoodle_black:part0:1.0 [current_project]
create_bd_design "sd_blk"

update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_
preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
save_bd_design
make_wrapper -files [get_files /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd
] -top
add_files -norecurse /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/hdl/sd_blk_wrapper.
v
generate_target all [get_files  /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.b
d]
export_ip_user_files -of_objects [get_files /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_
blk/sd_blk.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs
/sources_1/bd/sd_blk/sd_blk.bd]
launch_runs -jobs 2 sd_blk_processing_system7_0_0_synth_1
export_simulation -of_objects [get_files /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk
/sd_blk.bd] -directory /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.ip_user_files/sim_scripts -ip_user_files_d
ir /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.ip_user_files -ipstatic_source_dir /home/imagingtechnerd/vivad
o/2017.1/sd_blk/sd_blk.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/imagingtechnerd/vivado/2017.1/sd_
blk/sd_blk.cache/compile_simlib/modelsim} {questa=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_s
imlib/questa} {ies=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/ies} {vcs=/home/imagingte
chnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/vcs} {riviera=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd
_blk.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
catch { config_ip_cache -export [get_ips -all sd_blk_proc_sys_reset_2_0] }
launch_runs synth_1 -jobs 2
wait_on_run synth_1
launch_runs impl_1 -jobs 2
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1
open_run impl_1
file mkdir /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.sdk
file copy -force /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.runs/impl_1/sd_blk_wrapper.sysdef /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.sdk/sd_blk_wrapper.hdf

launch_sdk -workspace /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.sdk -hwspec /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.sdk/sd_blk_wrapper.hdf
archive_project /home/imagingtechnerd/vivado/2017.1/sd_blk.xpr.zip -force
open_bd_design {/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd}
startgroup
set_property -dict [list CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0
endgroup
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
startgroup
set_property -dict [list CONFIG.NUM_PORTS {1}] [get_bd_cells xlconcat_0]
endgroup
delete_bd_objs [get_bd_nets processing_system7_0_FCLK_CLK0]
startgroup
set_property -dict [list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {125} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {25} CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_EN_CLK2_PORT {1} CONFIG.PCW_EN_CLK3_PORT {1}] [get_bd_cells processing_system7_0]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK0]
endgroup
delete_bd_objs [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_ports FCLK_CLK0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:rst_gen:1.0 rst_gen_0
endgroup
delete_bd_objs [get_bd_cells rst_gen_0]
set_property name ps7 [get_bd_cells processing_system7_0]
set_property name xlconcat [get_bd_cells xlconcat_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/ps7/FCLK_CLK0 (125 MHz)" }  [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config {rst_polarity "ACTIVE_LOW" }  [get_bd_pins proc_sys_reset_0/ext_reset_in]
endgroup
delete_bd_objs [get_bd_nets reset_rtl_1] [get_bd_ports reset_rtl]
connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins ps7/FCLK_RESET0_N]
save_bd_design
set_property name ps_rst_0 [get_bd_cells proc_sys_reset_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
endgroup
connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins ps7/FCLK_RESET0_N]
connect_bd_net [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK1]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1
endgroup
connect_bd_net [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK2]
connect_bd_net [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins ps7/FCLK_RESET0_N]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_2
endgroup
connect_bd_net [get_bd_pins proc_sys_reset_2/slowest_sync_clk] [get_bd_pins ps7/FCLK_CLK3]
connect_bd_net [get_bd_pins proc_sys_reset_2/ext_reset_in] [get_bd_pins ps7/FCLK_RESET0_N]
regenerate_bd_layout
startgroup
set_property -dict [list CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1}] [get_bd_cells ps7]
endgroup
set_property name ps_rst_1 [get_bd_cells proc_sys_reset_0]
set_property name ps_rst_2 [get_bd_cells proc_sys_reset_1]
set_property name ps_rst_3 [get_bd_cells proc_sys_reset_2]
save_bd_design
validate_bd_design
startgroup
set_property -dict [list CONFIG.PCW_USE_M_AXI_GP0 {0}] [get_bd_cells ps7]
endgroup

# Validate design
validate_bd_design

# Generate Output Product
generate_target all [get_files  /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd]
catch { config_ip_cache -export [get_ips -all sd_blk_processing_system7_0_0] }
catch { config_ip_cache -export [get_ips -all sd_blk_xlconcat_0_0] }
catch { config_ip_cache -export [get_ips -all sd_blk_proc_sys_reset_0_0] }
catch { config_ip_cache -export [get_ips -all sd_blk_proc_sys_reset_0_1] }
catch { config_ip_cache -export [get_ips -all sd_blk_proc_sys_reset_1_0] }
catch { config_ip_cache -export [get_ips -all sd_blk_proc_sys_reset_2_0] }
export_ip_user_files -of_objects [get_files /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd]
launch_runs -jobs 2 {sd_blk_processing_system7_0_0_synth_1 sd_blk_xlconcat_0_0_synth_1 sd_blk_proc_sys_reset_0_0_synth_1 sd_blk_proc_sys_reset_0_1_synth_1 sd_blk_proc_sys_reset_1_0_synth_1 sd_blk_proc_sys_reset_2_0_synth_1}
export_simulation -of_objects [get_files /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd] -directory /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.ip_user_files/sim_scripts -ip_user_files_dir /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.ip_user_files -ipstatic_source_dir /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.ip_user_files/ipstatic -lib_map_path [list {modelsim=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/modelsim} {questa=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/questa} {ies=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/ies} {vcs=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/vcs} {riviera=/home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
write_hwdef -force  -file /home/imagingtechnerd/vivado/2017.1/sd_blk/sd_blk.sdk/sd_blk_wrapper.hdf
archive_project /home/imagingtechnerd/vivado/2017.1/sd_blk_sds_1.xpr.zip -force