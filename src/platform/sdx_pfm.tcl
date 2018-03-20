# SDSoC platform generation

# Setting
## Platform name
set PF_NAME       sdb_simple
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
-prebuilt;platform -write

# platform -read {/home/pentaxmedical/sdx/workspace/sdb_simple/platform.spr}
system \
-name {Linux} \
-display-name {Linux} \
-desc {} \
-boot ${DIR_PETALINUX}/images/linux;boot \
-bif  ${DIR_SRC}/platform/linux.bif

::scw::get_supported_os
::scw::get_supported_proc -os linux
::scw::get_supported_proc -os freertos
::scw::get_supported_proc -os standalone
domain \
-name {Linux} \
-os {linux} \
-proc {ps7_cortexa9} \
-display-name {Linux} \
-desc {} \
-runtime {cpp} \
-image {/home/pentaxmedical/Snickerdoodle/sdb_simple/images/linux}

platform -write
platform -generate