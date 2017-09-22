# Makefile

# Directory of this Makefile
DIR_ROOT=$(shell pwd)
# Source files directory
DIR_SRC=srcs
# Output directory of (1st) SDSoC platform
DIR_PF_FIRST=platform
# Output directory of (prebuilt) SDSoC platform
DIR_PF_PREBUILT=platform_prebuilt

# Working directory for Petalinux
DIR_PETALINUX=petalinux
# Name of this SDSoC platform
PF_NAME=sd_blk

APP=helloworld
#DIR_OUTPUT=output
#DIR_TMP=tmp
#DIR_DOWNLOAD=download
#KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz
#PETALINUX_ROOT := ~/xilinx/petalinux

# Comment this line for debugging
Q ?= @


HW: 
	vivado -mode batch -source `pwd`/$(DIR_SRC)/vivado.tcl -nojournal -tclargs $(PF_NAME)
	
SW:	# HW
	# Make petalinux project
	$(MAKE) -C $(DIR_PETALINUX) clean
	$(MAKE) -C $(DIR_PETALINUX) all

	# Source petalinux & Yocto tools
	#$(Q) source ${PETALINUX}/settings.sh
	#$(Q) source ${PETALINUX}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
	#$(Q) source ${PETALINUX}/components/yocto/source/arm/layers/core/oe-init-build-env
	#$(Q) export PATH=${PETALINUX}/tools/hsm/bin:${PATH}
	#$(Q) export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"
	#
	#petalinux-create -t project -s srcs/sd_blk.bsp
	#petalinux-build -p $(DIR_PETALINUX)

PLATFORM: #SW
	# Delete already existing platform directory
	-rm -r $(DIR_PF_FIRST)
	#$(Q) if [ -e $(DIR_PF_FIRST) ]; then \
	#	/bin/rm -r $(DIR_PF_FIRST); \
	#fi
	
	$(Q) sdspfm \
	-vendor  'krtkl' \
	-name    $(PF_NAME) \
	-version '1.0' \
	-desc    'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr     vivado/$(PF_NAME).xpr \
	-bd      $(PF_NAME).bd \
	-pfmtcl  $(DIR_SRC)/hpfm.tcl \
	-o       $(DIR_PF_FIRST) \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif     $(DIR_SRC)/linux.bif \
	-readme  $(DIR_SRC)/generic.readme \
	-boot    $(DIR_PETALINUX)/images/linux \
	-image   $(DIR_PETALINUX)/images/linux \
	-sds-end 

all: #PLATFORM
	/bin/echo "Building Snickerdoodle Black SDSoC platform (simple) ..."


PREBUILD_PLATFORM:	# all
	# Build sample app & bitstream along the way
	$(MAKE) -C $(APP) clean
	$(MAKE) -C $(APP) FIRST_PLATFORM=$(DIR_ROOT)/$(DIR_PF_FIRST)/$(PF_NAME)
	
	# Copy necessary files
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	#$(Q) /bin/echo $(TMPDIR)
	$(Q) /bin/mkdir -p $(TMPDIR)/prebuilt
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	
	$(Q) /bin/cp $(APP)/_sds/.llvm/apsys_0.xml    $(TMPDIR)/prebuilt/
	$(Q) /bin/cp $(APP)/_sds/.llvm/partitions.xml $(TMPDIR)/prebuilt/
	$(Q) /bin/cp $(APP)/_sds/p0/vpl/system.bit    $(TMPDIR)/prebuilt/bitstream.bit
	$(Q) /bin/cp $(APP)/_sds/swstubs/portinfo.c   $(TMPDIR)/prebuilt/
	$(Q) /bin/cp $(APP)/_sds/swstubs/portinfo.h   $(TMPDIR)/prebuilt/
	$(Q) /bin/cp $(APP)/_sds/p0/vpl/system.hdf    $(TMPDIR)/prebuilt/sd_blk.hdf
	
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub         $(TMPDIR)/image/
	
	#Delete already existing platform directory
	-rm -r $(DIR_PF_PREBUILT)
	#$(Q) if [ -e $(DIR_PF)2 ]; then \
	#	/bin/rm -r $(DIR_PF)2; \
	#fi
#	$(eval PF_DIR_EXIST=$(shell [ -e $(DIR_PF)2 ] && echo 1 || echo 0 ))
#ifeq ($(PF_DIR_EXIST), 1)
#	/bin/rm -r $(DIR_PF)2	
#endif
	
	# Run sdspfm
	$(Q) sdspfm \
	-vendor  'krtkl' \
	-name     $(PF_NAME) \
	-version '1.0' \
	-desc    'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr      vivado/$(PF_NAME).xpr \
	-bd       $(PF_NAME).bd \
	-pfmtcl   $(DIR_SRC)/hpfm.tcl \
	-o        $(DIR_PF_PREBUILT) \
	-prebuilt $(TMPDIR)/prebuilt \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif      $(DIR_SRC)/linux.bif \
	-readme   $(DIR_SRC)/generic.readme \
	-boot     $(DIR_PETALINUX)/images/linux \
	-image    $(TMPDIR)/image \
	-sds-end 
	

clean:
	$(Q) -rm -r vivado

superclean:
	$(Q) -rm -r $(APP)
	$(Q) -rm -r $(PF_DIR)
	
