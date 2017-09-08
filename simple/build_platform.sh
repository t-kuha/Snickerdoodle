#!/bin/bash

# Create HW for Snickerdoodle...

# HW Platfrom
# Build Vivado Project

# Export SDSoC HW platform 

# Archive


# Build SW

# Download linux kernel for SDSoC
echo "Downloading Linux Kernel source for SDSoC..."

KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

mkdir -p download 
wget https://github.com/Xilinx/linux-xlnx/archive/xilinx-v2016.4-sdsoc.tar.gz -O ${KERNEL_SRC_NAME}
tar xf ./download/${KERNEL_SRC_NAME} -C 

# Petalinux


# SW Platform


# Run SDSoC once to create pre-built data