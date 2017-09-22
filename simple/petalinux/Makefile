# Makefile

PETALINUX_ROOT := ~/xilinx/petalinux

Q ?= @

.PHONY:
all:
	# Source petalinux & Yocto tools
	$(Q) source ${PETALINUX_ROOT}/settings.sh
	$(Q) source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	$(Q) source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
	$(Q) export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
	$(Q) export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"
	petalinux-create -t project -s sd_blk.bsp
	petalinux-build -p sd_blk	

clean:
	$(Q) -rm -r build
	$(Q) -rm -r sd_blk
