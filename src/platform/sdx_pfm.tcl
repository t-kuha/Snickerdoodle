# SDSoC platform generation

# Check # of input arguments



# Setting
## Platform name
set PF_NAME         [lindex $argv 0]
# set PF_NAME       sdb_simple

## Image data
set DIR_IMAGE       [lindex $argv 1]

## Prebuilt data
set DIR_PREBUILT    [lindex $argv 2]

## Source
set DIR_SRC       src
## Vivado project directory
set DIR_VIVADO    vivado
## Working directory for Petalinux
set DIR_PETALINUX ${PF_NAME}
## Output directory
set DIR_PFM       platform


platform -name ${PF_NAME} \
-hw ${DIR_VIVADO}/${PF_NAME}.dsa \
-out ${DIR_PFM} \
-prebuilt ${DIR_PREBUILT}
# ;platform -write

# platform -read {/home/pentaxmedical/sdx/workspace/sdb_simple/platform.spr}
system \
-name {linux} \
-display-name {linux} \
-desc {} \
-boot ${DIR_PETALINUX}/images/linux;boot \
-bif  ${DIR_SRC}/platform/linux.bif

::scw::get_supported_os
::scw::get_supported_proc -os linux
::scw::get_supported_proc -os freertos
::scw::get_supported_proc -os standalone

domain \
-name {linux} \
-os {linux} \
-proc {ps7_cortexa9} \
-display-name {linux} \
-desc {} \
-runtime {cpp} \
-image ${DIR_IMAGE}
#/images/linux

platform -write
platform -generate