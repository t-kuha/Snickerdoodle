# Makefile

ROOT_DIR=$(shell pwd)
PF_NAME=sd_blk
DIR_PF=platform
APP=helloworld
DIR_PETALINUX=petalinux
#DIR_OUTPUT=output
#DIR_TMP=tmp
#DIR_DOWNLOAD=download
#KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

PETALINUX_ROOT := ~/xilinx/petalinux

Q ?= @

HW: 
	vivado -mode batch -source `pwd`/srcs/vivado.tcl -nojournal -tclargs $(PF_NAME)
	
SW:
	$(MAKE) -C $(DIR_PETALINUX) clean
	$(MAKE) -C $(DIR_PETALINUX) all

	# Source petalinux & Yocto tools
	#$(Q) source ${PETALINUX_ROOT}/settings.sh
	#$(Q) source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	#$(Q) source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
	#$(Q) export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
	#$(Q) export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"
	#
	#petalinux-create -t project -s srcs/sd_blk.bsp
	#petalinux-build -p $(DIR_PETALINUX)

PLATFORM: #HW SW
	#Delete already existing platform directory
	$(Q) if [ -e $(DIR_PF) ]; then \
		/bin/rm -r $(DIR_PF); \
	fi
	
	$(Q) sdspfm \
	-vendor 'krtkl' \
	-name $(PF_NAME) \
	-version '1.0' \
	-desc 'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr vivado/$(PF_NAME).xpr \
	-bd $(PF_NAME).bd \
	-pfmtcl srcs/hpfm.tcl \
	-o $(DIR_PF) \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif srcs/linux.bif \
	-readme srcs/generic.readme \
	-boot $(DIR_PETALINUX)/images/linux \
	-image $(DIR_PETALINUX)/images/linux \
	-sds-end 

all: HW SW PLATFORM
	/bin/echo "Building Snickerdoodle Black SDSoC platform (simple) ..."


PREBUILD_PLATFORM:
	# Build sample app & bitstream along the way
	$(MAKE) -C $(APP) clean
	$(MAKE) -C $(APP) FIRST_PLATFORM=$(ROOT_DIR)/$(DIR_PF)/$(PF_NAME)
	
	# Copy necessary files
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/echo $(TMPDIR)
	$(Q) /bin/mkdir -p $(TMPDIR)/prebuilt
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	
	$(Q) /bin/cp $(APP)/_sds/.llvm/apsys_0.xml    $(TMPDIR)/prebuilt
	$(Q) /bin/cp $(APP)/_sds/.llvm/partitions.xml $(TMPDIR)/prebuilt
	$(Q) /bin/cp $(APP)/_sds/p0/vpl/system.bit    $(TMPDIR)/prebuilt/bitstream.bit
	$(Q) /bin/cp $(APP)/_sds/swstubs/portinfo.c   $(TMPDIR)/prebuilt
	$(Q) /bin/cp $(APP)/_sds/swstubs/portinfo.h   $(TMPDIR)/prebuilt
	$(Q) /bin/cp $(APP)/_sds/p0/vpl/system.hdf    $(TMPDIR)/prebuilt/sd_blk.hdf
	
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub         $(TMPDIR)/image
	
	#Delete already existing platform directory
	$(Q) if [ -e $(DIR_PF)2 ]; then \
		/bin/rm -r $(DIR_PF)2; \
	fi
#	$(eval PF_DIR_EXIST=$(shell [ -e $(DIR_PF)2 ] && echo 1 || echo 0 ))
#ifeq ($(PF_DIR_EXIST), 1)
#	/bin/rm -r $(DIR_PF)2	
#endif
	
	# Run sdspfm
	$(Q) sdspfm \
	-vendor 'krtkl' \
	-name $(PF_NAME) \
	-version '1.0' \
	-desc 'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr vivado/$(PF_NAME).xpr \
	-bd $(PF_NAME).bd \
	-pfmtcl srcs/hpfm.tcl \
	-o $(DIR_PF)2 \
	-prebuilt $(TMPDIR)/prebuilt \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif srcs/linux.bif \
	-readme srcs/generic.readme \
	-boot $(DIR_PETALINUX)/images/linux \
	-image $(TMPDIR)/image \
	-sds-end 
	

clean:
	$(Q) rm -r vivado

superclean:
	$(Q) rm -r $(APP)
	$(Q) rm -r $(PF_DIR)
	
