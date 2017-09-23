# Makefile

ifndef PETALINUX
$(error "ERROR: PETALINUX environment variable not set...")
endif

ifndef PROJ_NAME
$(error "Usage: make PROJ_NAME=<petalinux project name>")
endif

#PETALINUX_ROOT := ~/xilinx/petalinux

Q ?= @

.PHONY:
all:
	# Source petalinux & Yocto tools
	# source ${PETALINUX}/settings.sh
	# $(shell source)
	$(Q) /bin/sh ${PETALINUX}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	$(Q) . ${PETALINUX}/components/yocto/source/arm/layers/core/oe-init-build-env
	#$(Q) export 
	PATH=${PETALINUX}/tools/hsm/bin:${PATH}
	#$(Q) export 
	BB_ENV_EXTRAWHITE="$(BB_ENV_EXTRAWHITE) $(PETALINUX)"
	petalinux-create -t project -s $(PROJ_NAME).bsp
	petalinux-build -p $(PROJ_NAME)

clean:
	$(Q) -rm -rf build
	$(Q) -rm -rf $(PROJ_NAME)
