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
source ~/petalinux/settings.sh 

# Create & configure project
petalinux-create -t project -n sdb_simple  --template zynq
petalinux-config -p sdb_simple --get-hw-description=./vivado/sdb_simple.sdk

# Apply modification for SDSoC platform
petalinux-config -p sdb_simple -c kernel
petalinux-config -p sdb_simple -c rootfs

# Copy device tree source (system-user.dtsi)
cp system-user.dtsi ./sdb_simple/project-spec/meta-user/r
ecipes-bsp/device-tree/files/system-user.dtsi

# Start build
petalinux-build -p sdb_simple

# Package BSP
petalinux-package --bsp -o sdb_simple.bsp -p sdb_simple
```