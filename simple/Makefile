# Makefile

# Directory of this Makefile
DIR_ROOT=$(shell pwd)
# Source files directory
DIR_SRC=srcs
# VIvado project directory
DIR_VIVADO=vivado
# Output directory of (1st) SDSoC platform
DIR_PF_FIRST=platform
# Output directory of (prebuilt) SDSoC platform
DIR_PF_PREBUILT=platform_prebuilt

# Working directory for Petalinux
DIR_PETALINUX=petalinux
# Name of this SDSoC platform
PF_NAME=sd_blk

APP=helloworld


# Comment this line for debugging
Q ?= @


HW:
	$(Q) -rm -rf $(DIR_VIVADO)
	vivado -mode batch -source $(DIR_ROOT)/$(DIR_SRC)/vivado.tcl -nolog -nojournal -tclargs $(PF_NAME) $(DIR_VIVADO)
	
SW: HW
	# Make petalinux project
	$(Q) $(MAKE) -C $(DIR_PETALINUX) clean PROJ_NAME=$(PF_NAME)
	$(Q) $(MAKE) -C $(DIR_PETALINUX) all   PROJ_NAME=$(PF_NAME)

PLATFORM: SW
	# Delete already existing platform directory
	$(Q) -rm -rf $(DIR_PF_FIRST)
	
	# Copy necessary files
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	
	$(Q) /bin/cp $(DIR_PETALINUX)/$(PF_NAME)/images/linux/image.ub $(TMPDIR)/image/
	
	$(Q) sdspfm \
	-vendor  'krtkl' \
	-name    $(PF_NAME) \
	-version '1.0' \
	-desc    'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr     $(DIR_VIVADO)/$(PF_NAME).xpr \
	-bd      $(PF_NAME).bd \
	-pfmtcl  $(DIR_SRC)/hpfm.tcl \
	-o       $(DIR_PF_FIRST) \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif     $(DIR_SRC)/linux.bif \
	-readme  $(DIR_SRC)/generic.readme \
	-boot    $(DIR_PETALINUX)/$(PF_NAME)/images/linux \
	-image   $(TMPDIR)/image \
	-sds-end 

all: #PLATFORM
	$(Q) /bin/echo "Building Snickerdoodle Black SDSoC platform (simple) ..."


PREBUILD_PLATFORM:	# all
	# Build sample app & bitstream along the way
	$(Q) $(MAKE) -C $(APP) clean
	$(Q) $(MAKE) -C $(APP) FIRST_PLATFORM=$(DIR_ROOT)/$(DIR_PF_FIRST)/$(PF_NAME)
	
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
	
	$(Q) /bin/cp $(DIR_PETALINUX)/$(PF_NAME)/images/linux/image.ub         $(TMPDIR)/image/
	
	#Delete already existing platform directory
	$(Q) -rm -rf $(DIR_PF_PREBUILT)
	
	# Run sdspfm
	$(Q) sdspfm \
	-vendor  'krtkl' \
	-name     $(PF_NAME) \
	-version '1.0' \
	-desc    'Snickerdoodle Black:Simple SDSoC platform' \
	-xpr      $(DIR_VIVADO)/$(PF_NAME).xpr \
	-bd       $(PF_NAME).bd \
	-pfmtcl   $(DIR_SRC)/hpfm.tcl \
	-o        $(DIR_PF_PREBUILT) \
	-prebuilt $(TMPDIR)/prebuilt \
	-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
	-id config0_0 -rt cpp \
	-bif      $(DIR_SRC)/linux.bif \
	-readme   $(DIR_SRC)/generic.readme \
	-boot     $(DIR_PETALINUX)/$(PF_NAME)/images/linux \
	-image    $(TMPDIR)/image \
	-sds-end 
	
clean:
	$(Q) -rm -rf $(DIR_VIVADO)
	$(Q) $(MAKE) -C $(DIR_PETALINUX) clean PROJ_NAME=$(PF_NAME)
	$(Q) $(MAKE) -C $(APP) clean
	$(Q) -rm -rf $(DIR_PF_FIRST)
	$(Q) -rm -rf $(DIR_PF_PREBUILT)
	
