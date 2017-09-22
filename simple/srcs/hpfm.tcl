set dst vivado/sd_blk.hpfm
set pfm [sdsoc::create_pfm $dst]
sdsoc::pfm_name $pfm "krtkl.inc" "xd" "sd_blk" "1.0"
sdsoc::pfm_description $pfm "Snickerdoodle Black for SDSoC"
sdsoc::pfm_clock  $pfm FCLK_CLK0 ps7 0 false ps_rst_0
sdsoc::pfm_clock  $pfm FCLK_CLK1 ps7 1 true ps_rst_1
sdsoc::pfm_clock  $pfm FCLK_CLK2 ps7 2 false ps_rst_2
sdsoc::pfm_clock  $pfm FCLK_CLK3 ps7 3 false ps_rst_3
sdsoc::pfm_axi_port $pfm M_AXI_GP0 ps7 M_AXI_GP
sdsoc::pfm_axi_port $pfm M_AXI_GP1 ps7 M_AXI_GP
sdsoc::pfm_axi_port $pfm S_AXI_ACP ps7 S_AXI_ACP
sdsoc::pfm_axi_port $pfm S_AXI_HP0 ps7 S_AXI_HP
sdsoc::pfm_axi_port $pfm S_AXI_HP1 ps7 S_AXI_HP
sdsoc::pfm_axi_port $pfm S_AXI_HP2 ps7 S_AXI_HP
sdsoc::pfm_axi_port $pfm S_AXI_HP3 ps7 S_AXI_HP
for {set i 0} {$i < 16} {incr i} { sdsoc::pfm_irq $pfm In$i xlconcat }
sdsoc::generate_hw_pfm $pfm
