#!/bin/bash

echo "... Building Vivado Project for Snickerdoodle Black ..."

# Run vivado in tcl mode & create project archive
vivado source vivado.tcl

# Export ***.hpfm
#open_project vivado/sd_blk.xpr

# Need to open block design
#open_bd_design vivado/sd_blk.srcs/sources_1/bd/sd_blk/sd_blk.bd

#source hpfm.tcl

#close_project


