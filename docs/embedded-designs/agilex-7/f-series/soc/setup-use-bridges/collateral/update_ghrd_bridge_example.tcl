load_package vds
project_open top -r baseline
vds::open_system src/vds/qsys_top/qsys_top.vds
vds::set_properties {parameters:F2S_Width 3} [vds::get_cells agilex_hps]
vds::set_properties {parameters:ARCACHE_OVERRIDE 15 parameters:ARDOMAIN_OVERRIDE 2 parameters:AWCACHE_OVERRIDE 15 parameters:AWDOMAIN_OVERRIDE 2 parameters:AxPROT_OVERRIDE 3 parameters:CONTROL_INTERFACE 2 parameters:DATA_WIDTH 128} [vds::get_cells cache_coherency_translator_0]
vds::create_cell -properties {parameters:BURST_ENABLE 1 parameters:DATA_FIFO_DEPTH 512 parameters:DATA_WIDTH 128 parameters:DESCRIPTOR_FIFO_DEPTH 64 parameters:ENHANCED_FEATURES 1 parameters:MAX_BURST_COUNT 64 parameters:MAX_BYTE 4096 parameters:PREFETCHER_DATA_WIDTH 128 parameters:PROGRAMMABLE_BURST_ENABLE 1 parameters:RESPONSE_PORT 0} -vlnv altera.com:ip:altera_msgdma:19.3.3 msgdma_0
vds::connect_net -dest [vds::get_pins clk_100|out_clk] -src [vds::get_pins cache_coherency_translator_0|csr_clock]
vds::connect_net -dest [vds::get_pins rst_in|out_reset] -src [vds::get_pins cache_coherency_translator_0|csr_reset]
vds::connect_interface_net -dest agilex_hps|h2f_lw_axi_master -src cache_coherency_translator_0|csr
vds::connect_net -dest [vds::get_pins clk_100|out_clk] -src [vds::get_pins msgdma_0|clock]
vds::connect_net -dest [vds::get_pins rst_in|out_reset] -src [vds::get_pins msgdma_0|reset_n]
vds::connect_interface_net -dest agilex_hps|h2f_lw_axi_master -src msgdma_0|csr
vds::connect_interface_net -dest agilex_hps|h2f_lw_axi_master -src msgdma_0|descriptor_slave
vds::connect_interface_net -dest agilex_hps|h2f_lw_axi_master -src msgdma_0|response
vds::connect_interface_net -dest cache_coherency_translator_0|s0 -src msgdma_0|mm_read
vds::connect_interface_net -dest cache_coherency_translator_0|s0 -src msgdma_0|mm_write
vds::lock_base_address -interface agilex_hps|f2h_axi_slave
vds::lock_base_address -interface fpga_m2ocm_pb|s0
vds::lock_base_address -interface ocm|axi_s1
vds::lock_base_address -interface periph|pb_cpu_0_s0
vds::lock_base_address -interface sysid|control_slave
vds::assign_base_address
vds::save_system qsys_top
vds::close_system qsys_top
project_close
