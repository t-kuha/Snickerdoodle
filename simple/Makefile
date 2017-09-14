# Makefile

PF_NAME=sd_blk
PF_DIR=platform

PREPARE_SW:
	wget 


HW: PREPARE_SW
	vivado source vivado.tcl
	

SW:

PLATFORM: HW SW
	sdspfm \
	-vendor 'krtkl' \
	-name $(PF_NAME) \
	-version '1.0' \
	-desc 'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr vivado/$(PF_NAME).xpr \
	-bd $(PF_NAME).bd \
	-pfmtcl hpfm.tcl \
	-o $(PF_DIR) \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif src/linux.bif \
	-readme src/generic.readme \
	-boot petalinux/image \
	-image petalinux/image \
	-sds-end 

PREBUILT_PLATFORM:
	
	

all: HW SW PLATFORM
	

clean:
	