# Snickerdoodle

Snickerdoodle Projects

#### Simple
	-　Simple SDSoC Platform
    
#### Video (TODO)
	-  Video Processing with HDMI In/Out (TODO)

#### How to build
```console
# Source setting file
$ source <SDx installation directory>/SDx/2017.2/settings64.sh

# make vivado project
$ make HW
```

***
#### How to build Linux image (via petalinux)

```console
# Make project
$ petalinux-create --type project --template zynq --name sd_blk
$ petalinux-config --get-hw-description=~/snickerdoodle/simple/vivado/sd_blk.sdk -p sd_blk

# Configure Linux Kernel & rootfs
$ petalinux-config -c kernel -p sd_blk
$ petalinux-config -c rootfs -p sd_blk

# Build
$ petalinux-build -p sd_blk

# Package BSP

```
