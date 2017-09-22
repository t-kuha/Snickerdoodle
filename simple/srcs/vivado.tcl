# Reference: 
#    http://qiita.com/ikwzm/items/666dcf3b90c36d16a0ed
#    http://masahir0y.blogspot.jp/2014/01/zynq.html

# Detect open project
#close_project

set proj_name    [lindex $argv 0]
set root_dir     [file dirname [info script]]
set proj_root    ${root_dir}/../[lindex $argv 1]

set bd_file      ${root_dir}/bd.tcl
set hw_pfm       ${root_dir}/hpfm.tcl

# Create project
create_project ${proj_name} ${proj_root} -part xc7z020clg400-3 -force
#create_project $proj_name $proj_root -part xc7z020clg400-3

# Set parts
set_property board_part krtkl.com:snickerdoodle_black:part0:1.0 [current_project]
create_bd_design ${proj_name}

# Create Block design
source ${bd_file}
validate_bd_design
save_bd_design

# Generate Output Product
generate_target all [get_files  ${proj_root}/${proj_name}.srcs/sources_1/bd/${proj_name}/${proj_name}.bd]

# Export HW for petalinux
file mkdir  ${proj_root}/${proj_name}.sdk
write_hwdef -force -file ${proj_root}/${proj_name}.sdk/${proj_name}_wrapper.hdf

# Export HW for SDSoC HW platform
# Not needed - sdspfm can handle it
#source ${hw_pfm}

# Archive - Unnecessary (sdspfm handles it)
#archive_project ${root_dir}/${proj_name}.zip -force

# END
close_project
