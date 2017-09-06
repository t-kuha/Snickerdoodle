#!/bin/bash

echo "... Building petalinux for Snickerdoodle Black ..."

PETALINUX_ROOT=/home/imagingtechnerd/xilinx/2017.1
PROJECT_NAME=sd_blk

# Source petalinux & Yocto tools
source ${PETALINUX_ROOT}/settings.sh
source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"

# Download linux kernel for SDSoC
KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

if 

echo "Downloading Linux Kernel source for SDSoC..."
if [ ! -e download ]; then
	mkdir -p download 
fi

if [ ! -f ./download/${KERNEL_SRC_NAME} ]; then
	wget https://github.com/Xilinx/linux-xlnx/archive/xilinx-v2016.4-sdsoc.tar.gz -O ./download/${KERNEL_SRC_NAME}
fi


tar xf ./download/${KERNEL_SRC_NAME} #-C kernel
# Untar-ed folder name: linux-xlnx-xilinx-v2016.4-sdsoc


# Building
#rm -rf ${PROJECT_NAME}
petalinux-create --type project --template zynq --name ${PROJECT_NAME}
cd ./${PROJECT_NAME}
petalinux-config --get-hw-description=..
# https://www.xilinx.com/support/answers/69126.html
# ps7_uart_1 -> ps7_uart_0
# vi ./build/tmp/work/plnx_arm-xilinx-linux-gnueabi/device-tree-generation/xilinx+gitAUTOINC+94fc615234-r0/device-tree-generation.yaml
petalinux-build

# Create petalinux BSP if needed
cd ..
petalinux-package --bsp -p ${PROJECT_NAME} --output ${PROJECT_NAME}.bsp

echo "... Done ..."
