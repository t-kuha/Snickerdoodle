
# Create Vivado project
hw:
	echo "... Creating Vivado Project ..."
	vivado -mode batch -source src/vivado/create_vivado_project.tcl

# Petalinux
sw:


# SDSoC platform
pfm:


# Build hello world
prebuilt_hw:


# SDSoC platform (w/ prebuilt data)
pfm2:


# 
all:


# Clean all output
clean:
	rm -rf vivado
