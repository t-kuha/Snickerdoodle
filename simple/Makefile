# Makefile

PF_NAME=sd_blk
DIR_PF=platform
DIR_OUTPUT=output
DIR_TMP=tmp
DIR_DOWNLOAD=download
KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

PETALINUX_ROOT=/home/imagingtechnerd/xilinx/2017.1

PREPARE_SW:
	mkdir -p ${DIR_DOWNLOAD}
	wget https://github.com/Xilinx/linux-xlnx/archive/xilinx-v2016.4-sdsoc.tar.gz -O ./${DIR_DOWNLOAD}/${KERNEL_SRC_NAME}
	tar xf ./${DIR_DOWNLOAD}/${KERNEL_SRC_NAME} #-C 


HW: 
	vivado -mode batch -source src/vivado.tcl -nojournal -tclargs $(PF_NAME) 
	
SW: PREPARE_SW	
	# Source petalinux & Yocto tools
	source ${PETALINUX_ROOT}/settings.sh
	source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
	export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
	export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"


PLATFORM: HW SW
	sdspfm \
	-vendor 'krtkl' \
	-name $(PF_NAME) \
	-version '1.0' \
	-desc 'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr vivado/$(PF_NAME).xpr \
	-bd $(PF_NAME).bd \
	-pfmtcl hpfm.tcl \
	-o $(DIR_PF) \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif src/linux.bif \
	-readme src/generic.readme \
	-boot petalinux/image \
	-image petalinux/image \
	-sds-end 

PREBUILT_PLATFORM:
	petalinux-build sd_blk.bsp
	

all: HW SW PLATFORM
	

clean:
	rm -r vivado
	rm -r tmp
	rm -r output