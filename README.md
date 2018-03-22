# Snickerdoodle

SDSoC platform for Snickerdoodle Black (Compatible with SDSoC 2017.4)

#### simple
	-　Simple SDSoC Platform


#### How to build
```bash
# Source setting file
$ source <SDx installation directory>/SDx/2017.4/settings64.sh

# Generate vivado project
$ make hw
```

***
#### How to build Linux image (via petalinux; TODO)


***
#### How to make Petalinux project from scratch

```bash
# Setup petalinux
source <Petalinux Installation DIrectory>/settings.sh 

# Set petalinux project name
export PRJ_NAME=petalinux

# Create & configure project
petalinux-create -t project -n ${PRJ_NAME}  --template zynq
petalinux-config -p ${PRJ_NAME} --get-hw-description=./vivado/sdb_simple.sdk

# Apply modification for SDSoC platform according to UG1146 (SDSoC Environment Platform Development Guide)
## Add SDSoC driver
petalinux-config -p ${PRJ_NAME} -c kernel
## Add libstdc++
petalinux-config -p ${PRJ_NAME} -c rootfs

# Copy device tree source (system-user.dtsi)
cp src/petalinux/system-user.dtsi ${PRJ_NAME}/project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi

# Start build
petalinux-build -p ${PRJ_NAME}

# Package BSP
petalinux-package --bsp -o ${PRJ_NAME}.bsp -p ${PRJ_NAME}
```
