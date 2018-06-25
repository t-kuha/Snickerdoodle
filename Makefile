# Makefile

# Setting
## Name of this SDSoC platform
PF_NAME=sdb_simple
## Source files directory
DIR_SRC=src
## Vivado project directory
DIR_VIVADO=vivado
## Working directory for Petalinux
DIR_PETALINUX=$(PF_NAME)_plnx
## Output directory of (1st) SDSoC platform
DIR_PF_FIRST=pfm1
## Output directory of SDSoC platform (w/ prebuilt data)
DIR_PF_PREBUILT=pfm2
## Working directory for helloworld
DIR_HW=hello_world


# Comment this line for debugging
Q ?= @

# Create Vivado project
.PHONY: hw
hw:
	$(Q) if [ -e vivado/$(PF_NAME).xpr ]; then \
		/bin/echo "... Skipping Vivado Project ..."; \
	else \
		/bin/echo "... Creating Vivado Project ..."; \
		vivado -mode batch -source $(DIR_SRC)/vivado/create_vivado_project.tcl -tclargs $(PF_NAME); \
	fi


# Petalinux
.PHONY: sw
sw: hw
	$(Q) if [ -d $(DIR_PETALINUX) ]; then \
		/bin/echo "... Skipping SW (Petalinux) project ..."; \
	else \
		/bin/echo "... Creating Petalinux ..."; \
		petalinux-create -t project -s $(DIR_SRC)/petalinux/petalinux.bsp; \
		petalinux-build -p $(DIR_PETALINUX); \
	fi

# SDSoC platform
.PHONY: pfm
pfm: sw
	$(Q) /bin/echo "... Creating (Initial) Platform ..."
	
	# Delete already existing platform directory
	$(Q) -rm -rf $(DIR_PF_FIRST)
	
	# Copy necessary files
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub $(TMPDIR)/image
	
	# Not "sdspfm" any more
	$(Q) xsct -sdx $(DIR_SRC)/platform/sdx_pfm.tcl $(PF_NAME) $(DIR_PF_FIRST) $(TMPDIR)/image


# Build hello world
.PHONY: hello_world
hello_world: pfm
	$(Q) /bin/echo "... Creating (Prebuilt) Image ..."

	$(Q) /bin/mkdir -p $(DIR_HW)
	$(Q) cd $(DIR_HW); sds++ -sds-pf ../$(DIR_PF_FIRST)/$(PF_NAME)/export/$(PF_NAME) ../$(DIR_SRC)/hello_world/hello_world.cpp -c -o $@.o
	$(Q) cd $(DIR_HW); sds++ -sds-pf ../$(DIR_PF_FIRST)/$(PF_NAME)/export/$(PF_NAME) $@.o -o $@.elf


# SDSoC platform (w/ prebuilt data)
.PHONY: pfm2
pfm2: hello_world
	#  hello_world
	$(Q) /bin/echo "... Creating (Prebuilt) Platform ..."

	# Delete already existing platform directory
	$(Q) -rm -rf $(DIR_PF_PREBUILT)

	# Copy image.ub
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub $(TMPDIR)/image

	# Copy portinfo.c/h, apsys_0.xml, bitstream.bit, <platform>.hdf, partitions.xml
	$(Q) $(eval TMPDIR2=$(shell /bin/mktemp -d))

	$(Q) cp $(DIR_HW)/_sds/swstubs/portinfo.c     $(TMPDIR2)
	$(Q) cp $(DIR_HW)/_sds/swstubs/portinfo.h     $(TMPDIR2)
	$(Q) cp $(DIR_HW)/_sds/.llvm/partitions.xml   $(TMPDIR2)
	$(Q) cp $(DIR_HW)/_sds/.llvm/apsys_0.xml      $(TMPDIR2)
	$(Q) cp $(DIR_VIVADO)/$(PF_NAME).sdk/$(PF_NAME)_wrapper.hdf $(TMPDIR2)/$(PF_NAME).hdf
	$(Q) cp $(DIR_HW)/_sds/p0/vpl/system.bit      $(TMPDIR2)/bitstream.bit

	$(Q) xsct -sdx $(DIR_SRC)/platform/sdx_pfm.tcl $(PF_NAME) $(DIR_PF_PREBUILT) $(TMPDIR)/image $(TMPDIR2)

# 
.PHONY: all
all: pfm2
	# Copy generated platform into top directory
	$(Q) cp -R $(DIR_PF_PREBUILT)/$(PF_NAME)/export/$(PF_NAME) .


# Clean all output
clean:
	$(Q) -rm -rf $(DIR_VIVADO)
	$(Q) -rm -rf $(DIR_PETALINUX)
	$(Q) -rm -rf $(DIR_HW)
	$(Q) -rm -rf $(DIR_PF_FIRST)
	$(Q) -rm -rf $(DIR_PF_PREBUILT)
