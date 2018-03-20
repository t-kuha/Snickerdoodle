# Makefile

# Setting
## Name of this SDSoC platform
PF_NAME=sdb_simple
## Source files directory
DIR_SRC=src
## Vivado project directory
DIR_VIVADO=vivado
## Working directory for Petalinux
DIR_PETALINUX=$(PF_NAME)
## Output directory of (1st) SDSoC platform
DIR_PF_FIRST=pfm1
## Working directory for helloworld
DIR_HW=hello_world


# Comment this line for debugging
# Q ?= @

# Create Vivado project
.PHONY: hw
hw:
	$(Q) /bin/echo "... Creating Vivado Project ..."
	$(Q) vivado -mode batch -source $(DIR_SRC)/vivado/create_vivado_project.tcl -tclargs 

# Petalinux
.PHONY: sw
sw:
	$(Q) /bin/echo "... Creating Petalinux ..."


# SDSoC platform
.PHONY: pfm
pfm:
	$(Q) /bin/echo "... Creating (Initial) platform ..."
	
	# Delete already existing platform directory
	$(Q) -rm -rf platform
	
	# Copy necessary files
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub $(TMPDIR)/image
	
	# Not "sdspfm" any more
	$(Q) xsct -sdx $(DIR_SRC)/platform/sdx_pfm.tcl $(PF_NAME) $(TMPDIR)/image


# Build hello world
.PHONY: hello_world
hello_world:
	$(Q) /bin/echo "... Creating (prebuilt) image ..."

	$(Q) /bin/mkdir -p $(DIR_HW)
	$(Q) sds++ -sds-pf platform/$(PF_NAME)/export/$(PF_NAME) $(DIR_SRC)/helloworld/helloworld.cpp -c -o $(DIR_HW)/helloworld.o
	$(Q) sds++ -sds-pf platform/$(PF_NAME)/export/$(PF_NAME) $(DIR_HW)/helloworld.o -o $(DIR_HW)/helloworld.elf


# SDSoC platform (w/ prebuilt data)
.PHONY: pfm2
pfm2:
	#  hello_world
	$(Q) /bin/echo "... Creating (Prebuilt) Platform ..."

	# Copy image.ub
	$(Q) $(eval TMPDIR=$(shell /bin/mktemp -d))
	$(Q) /bin/mkdir -p $(TMPDIR)/image
	$(Q) /bin/cp $(DIR_PETALINUX)/images/linux/image.ub $(TMPDIR)/image

	# Copy necessary files
	# portinfo.c/h, apsys_0.xml, bitstream.bit, <platform>.hdf, partitions.xml
	$(Q) $(eval TMPDIR2=$(shell /bin/mktemp -d))

	$(Q) cp _sds/swstubs/portinfo.c     $(TMPDIR2)
	$(Q) cp _sds/swstubs/portinfo.h     $(TMPDIR2)
	$(Q) cp _sds/.llvm/partitions.xml   $(TMPDIR2)
	$(Q) cp _sds/.llvm/apsys_0.xml      $(TMPDIR2)
	$(Q) cp $(DIR_VIVADO)/$(PF_NAME).sdk/$(PF_NAME)_wrapper.hdf $(TMPDIR2)/$(PF_NAME).hdf
	$(Q) cp _sds/p0/vpl/system.bit      $(TMPDIR2)/bitstream.bit

	$(Q) xsct -sdx $(DIR_SRC)/platform/sdx_pfm.tcl $(PF_NAME) $(TMPDIR)/image $(TMPDIR2)

# 
.PHONY: all
all:


# Clean all output
clean:
	$(Q) -rm -rf vivado
	$(Q) -rm -rf sdb_simple
