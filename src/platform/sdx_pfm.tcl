# SDSoC platform generation

# Check # of input arguments
if {$argc < 3 | $argc > 4} {
    puts "Invalid num of arguments to sdx_pfm.tcl"
    return
}

# Setting
## Platform name
set PF_NAME         [lindex $argv 0]

## Output directory
set DIR_PFM         [lindex $argv 1]

## Image data (image.ub)
set DIR_IMAGE       [lindex $argv 2]

## Prebuilt data (portinfo.c/h, apsys_0.xml, bitstream.bit, <platform>.hdf, partitions.xml)
set DIR_PREBUILT    [lindex $argv 3]


## Source
set DIR_SRC       src
## Vivado project directory
set DIR_VIVADO    vivado
## Working directory for Petalinux
set DIR_PETALINUX ${PF_NAME}


platform -name ${PF_NAME} \
-hw ${DIR_VIVADO}/${PF_NAME}.dsa \
-out ${DIR_PFM} \
-prebuilt ${DIR_PREBUILT}

system \
-name {linux} \
-display-name {linux} \
-desc {} \
-boot ${DIR_PETALINUX}/images/linux;boot \
-bif  ${DIR_SRC}/platform/linux.bif

::scw::get_supported_os
::scw::get_supported_proc -os linux
# ::scw::get_supported_proc -os standalone

domain \
-name {linux} \
-os {linux} \
-proc {ps7_cortexa9} \
-display-name {linux} \
-desc {} \
-runtime {cpp} \
-image ${DIR_IMAGE} 

# Specify prebuilt data
if { $argc == 4 } {
    domain -prebuilt-data ${DIR_PREBUILT}
}

platform -write
platform -generate