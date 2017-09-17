#!/bin/bash

echo "... Building petalinux for Snickerdoodle Black ..."

# <root>/petalinux/sd_blk/<...>


PF_NAME=sd_blk
PROJ_ROOT=petalinux
PETALINUX_ROOT=/home/imagingtechnerd/xilinx/2017.1

# Source petalinux & Yocto tools
source ${PETALINUX_ROOT}/settings.sh
source ${PETALINUX_ROOT}/components/yocto/source/arm/environment-setup-cortexa9hf-neon-xilinx-linux-gnueabi
source ${PETALINUX_ROOT}/components/yocto/source/arm/layers/core/oe-init-build-env
export PATH=${PETALINUX_ROOT}/tools/hsm/bin:${PATH}
export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PETALINUX"


# Preparation
DIR_OUTPUT=output
DIR_TMP=tmp
DIR_DOWNLOAD=download
DIR_PF_HW=platform/hw
DIR_PF_SW=platform/sw
DIR_VIVADO=vivado

#mkdir -p ${DIR_OUTPUT}
mkdir -p ${DIR_TMP}
#mkdir -p ${DIR_DOWNLOAD}
mkdir -p ${DIR_PF_HW} ${DIR_PF_HW}/vivado
mkdir -p ${DIR_PF_SW}


# Download linux kernel for SDSoC
KERNEL_SRC_NAME=xilinx-v2016.4-sdsoc.tar.gz

if 

echo "Downloading Linux Kernel source for SDSoC..."
if [ ! -e ${DIR_DOWNLOAD} ]; then
	mkdir -p ${DIR_DOWNLOAD} 
fi

if [ ! -f ./${DIR_DOWNLOAD}/${KERNEL_SRC_NAME} ]; then
	wget https://github.com/Xilinx/linux-xlnx/archive/xilinx-v2016.4-sdsoc.tar.gz -O ./${DIR_DOWNLOAD}/${KERNEL_SRC_NAME}
fi


tar xf ./${DIR_DOWNLOAD}/${KERNEL_SRC_NAME} -C ${DIR_TMP}
# Untar-ed folder name: linux-xlnx-xilinx-v2016.4-sdsoc


# Building
#rm -rf ${PF_NAME}
cd ${PROJ_ROOT}

petalinux-create --type project --template zynq --name ${PF_NAME}
cd ${PF_NAME}
petalinux-config --get-hw-description=${DIR_PF_HW}/vivado/${PF_NAME}.sdk

# https://www.xilinx.com/support/answers/69126.html
# ps7_uart_1 -> ps7_uart_0
# vi ./build/tmp/work/plnx_arm-xilinx-linux-gnueabi/device-tree-generation/xilinx+gitAUTOINC+94fc615234-r0/device-tree-generation.yaml
petalinux-build

# Create petalinux BSP if needed
petalinux-package --bsp -p ${PF_NAME} --output ${DIR_OUTPUT}/${PF_NAME}.bsp

echo "... Done ..."
