# Makefile

ROOT_DIR=$(shell pwd)
PF_NAME=sd_blk
DIR_PF=platform
DIR_OUTPUT=output
DIR_TMP=tmp
#DIR_DOWNLOAD=download
#KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

PETALINUX_ROOT=/home/imagingtechnerd/xilinx/petalinux

#PREPARE_SW:
	

HW: 
	vivado -mode batch -source `pwd`/srcs/vivado.tcl -nojournal -tclargs $(PF_NAME) 
	
SW: PREPARE_SW	
	# Source petalinux & Yocto tools
	source ${PETALINUX_ROOT}/settings.sh
	source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
	export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
	export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"
	
	petalinux-create -t petalinux -s srcs/sd_blk.bsp
	petalinux-build -p petalinux

PLATFORM: #HW SW
	sdspfm \
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
	-boot sd_blk/images/linux \
	-image sd_blk/images/linux \
	-sds-end 

all: HW SW PLATFORM
	/bin/echo "Building Snickerdoodle Black SDSoC platform (simple) ..."


PREBUILD_PLATFORM:
	#$(MAKE) -C helloworld clean
	#$(MAKE) -C helloworld FIRST_PLATFORM=$(ROOT_DIR)/$(DIR_PF)/$(PF_NAME)
	# Copy necessary files
	$(eval TMPDIR=$(shell /bin/mktemp -d))
	/bin/echo $(TMPDIR)
	/bin/mkdir -p $(TMPDIR)/prebuilt
	/bin/mkdir -p $(TMPDIR)/image
	
	/bin/cp helloworld/_sds/.llvm/apsys_0.xml    $(TMPDIR)/prebuilt
	/bin/cp helloworld/_sds/.llvm/partitions.xml $(TMPDIR)/prebuilt
	/bin/cp helloworld/_sds/p0/vpl/system.bit    $(TMPDIR)/prebuilt/bitstream.bit
	/bin/cp helloworld/_sds/swstubs/portinfo.c   $(TMPDIR)/prebuilt
	/bin/cp helloworld/_sds/swstubs/portinfo.h   $(TMPDIR)/prebuilt
	/bin/cp helloworld/_sds/p0/vpl/system.hdf    $(TMPDIR)/prebuilt/sd_blk.hdf
	
	/bin/cp sd_blk/images/linux/image.ub         $(TMPDIR)/image
	
	#Delete already existing platform directory
	if [ -e $(DIR_PF)2 ]; then \
		/bin/rm -r $(DIR_PF)2; \
	fi
#	$(eval PF_DIR_EXIST=$(shell [ -e $(DIR_PF)2 ] && echo 1 || echo 0 ))
#ifeq ($(PF_DIR_EXIST), 1)
#	/bin/rm -r $(DIR_PF)2	
#endif
	
	# Run sdspfm
	sdspfm \
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
	-boot sd_blk/images/linux \
	-image $(TMPDIR)/image \
	-sds-end 
	
clean:
	rm -r vivado
	rm -r tmp
	rm -r output
