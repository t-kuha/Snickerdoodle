#!/bin/bash

# Create HW for Snickerdoodle...

echo "------------------------------------------------------------------------"

PF_NAME=sd_blk
PF_DIR=platform

# Call sdspfm utility
sdspfm  \
-vendor 'krtkl' \
-name ${PF_NAME} \
-version '1.0' \
-desc 'Snickerdoodle Black:Simple SDSoC platform' \
-xpr vivado/${PF_NAME}.xpr \
-bd sd_blk.bd \
-pfmtcl hpfm.tcl \
-o ${PF_DIR} \
-sds-cfg -arch cortex-a9 -os linux -name "Standalone Config 0" \
-id config0_0 -rt cpp \
-bif src/linux.bif \
-readme src/generic.readme \
-boot petalinux/image \
-image petalinux/image \
-sds-end 



# Preparation
DIR_OUTPUT=output
DIR_TMP=tmp
DIR_DOWNLOAD=download
DIR_PF_HW=platform/hw
DIR_PF_SW=platform/sw
#DIR_VIVADO=vivado

mkdir -p ${DIR_OUTPUT}
mkdir -p ${DIR_TMP}
mkdir -p ${DIR_DOWNLOAD}
mkdir -p ${DIR_PF_HW} ${DIR_PF_HW}/vivado
mkdir -p ${DIR_PF_SW}
mkdir -p ${DIR_PF_SW}/linux ${DIR_PF_SW}/linux/image ${DIR_PF_SW}/linux/boot
mkdir -p ${DIR_PF_SW}/prebuilt



# ***** HW *****
# Copy *.hpfm file
cp ${PF_NAME}.hpfm ${DIR_PF_HW}

# Extract archive & copy necessary files to platform/hw
unzip ${DIR_OUTPUT}/${PF_NAME}.zip -d ${DIR_TMP}

cp    ${DIR_VIVADO}/${PF_NAME}.xpr  ${DIR_PF_HW}/vivado
cp -R ${DIR_VIVADO}/${PF_NAME}.srcs ${DIR_PF_HW}/vivado
cp -R ${DIR_VIVADO}/${PF_NAME}.hw   ${DIR_PF_HW}/vivado


# ***** SW *****
cp src/base.spfm ${DIR_PF_SW}/${PF_NAME}.spfm
cp src/generic.readme ${DIR_PF_SW}/linux/boot/generic.readme
cp src/linux.bif ${DIR_PF_SW}/linux/boot/linux.bif
cp <petalinux>/image/image.ub ${DIR_PF_SW}/linux/image
cp <petalinux>/image/zynq_fsbl.elf ${DIR_PF_SW}/linux/boot/fsbl.elf
cp <petalinux>/image/u-boot.elf ${DIR_PF_SW}/linux/boot/u-boot.elf


# ***** Integrate *****
# sdspfm command


# ***** Run SDSoC once to create pre-built data


# Copy prebuilt files


# Update *xpfm

