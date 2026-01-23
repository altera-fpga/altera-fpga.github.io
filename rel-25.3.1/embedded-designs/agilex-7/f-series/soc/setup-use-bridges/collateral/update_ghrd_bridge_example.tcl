# Execute it with qsys-script --qpf=ghrd_agfb014r24b2e2v.qpf --script=update_ghrd_bridge_example.tcl --system-file=qsys_top.qsys

package require qsys

# Update HPS component
load_component agilex_hps
set_component_parameter_value F2S_Width {3}
save_component

load_instantiation agilex_hps
save_instantiation

# Update Cache coherency Translator
load_component intel_cache_coherency_translator_0
set_component_parameter_value ARCACHE_OVERRIDE {15}
set_component_parameter_value ARDOMAIN_OVERRIDE {2}
set_component_parameter_value AWCACHE_OVERRIDE {15}
set_component_parameter_value AWDOMAIN_OVERRIDE {2}
set_component_parameter_value AxPROT_OVERRIDE {3}
set_component_parameter_value CONTROL_INTERFACE {2}
set_component_parameter_value DATA_WIDTH {128}
save_component

load_instantiation intel_cache_coherency_translator_0
save_instantiation

# Adding msgdma_0 component
add_component msgdma_0 ip/qsys_top/qsys_top_msgdma_0.ip altera_msgdma msgdma_0

# Updating Parameters mgsdma_0 component
load_component msgdma_0
set_component_parameter_value BURST_ENABLE {1}
set_component_parameter_value BURST_WRAPPING_SUPPORT {0}
set_component_parameter_value CHANNEL_ENABLE {0}
set_component_parameter_value CHANNEL_WIDTH {8}
set_component_parameter_value DATA_FIFO_DEPTH {512}
set_component_parameter_value DATA_WIDTH {128}
set_component_parameter_value DESCRIPTOR_FIFO_DEPTH {64}
set_component_parameter_value ENHANCED_FEATURES {1}
set_component_parameter_value ERROR_ENABLE {0}
set_component_parameter_value ERROR_WIDTH {8}
set_component_parameter_value EXPOSE_ST_PORT {0}
set_component_parameter_value FIX_ADDRESS_WIDTH {32}
set_component_parameter_value MAX_BURST_COUNT {64}
set_component_parameter_value MAX_BYTE {4096}
set_component_parameter_value MAX_STRIDE {1}
set_component_parameter_value MODE {0}
set_component_parameter_value NO_BYTEENABLES {0}
set_component_parameter_value PACKET_ENABLE {0}
set_component_parameter_value PREFETCHER_DATA_WIDTH {128}
set_component_parameter_value PREFETCHER_ENABLE {0}
set_component_parameter_value PREFETCHER_MAX_READ_BURST_COUNT {2}
set_component_parameter_value PREFETCHER_READ_BURST_ENABLE {0}
set_component_parameter_value PROGRAMMABLE_BURST_ENABLE {1}
set_component_parameter_value RESPONSE_PORT {0}
set_component_parameter_value STRIDE_ENABLE {0}
set_component_parameter_value TRANSFER_TYPE {Aligned Accesses}
set_component_parameter_value USE_FIX_ADDRESS_WIDTH {0}
set_component_parameter_value WRITE_RESPONSE_ENABLE {0}
set_component_project_property HIDE_FROM_IP_CATALOG {false}
save_component

load_instantiation msgdma_0
save_instantiation

# Connect cache coherency translator
add_connection agilex_hps.h2f_lw_axi_master/intel_cache_coherency_translator_0.csr
add_connection clk_100.out_clk/intel_cache_coherency_translator_0.csr_clock
add_connection rst_in.out_reset/intel_cache_coherency_translator_0.csr_reset


# Connect msgmdma
add_connection agilex_hps.h2f_lw_axi_master/msgdma_0.csr
add_connection agilex_hps.h2f_lw_axi_master/msgdma_0.descriptor_slave
add_connection agilex_hps.h2f_lw_axi_master/msgdma_0.response
add_connection clk_100.out_clk/msgdma_0.clock
add_connection rst_in.out_reset/msgdma_0.reset_n

# Connect msgmdma with cache coherency translator
add_connection msgdma_0.mm_read/intel_cache_coherency_translator_0.s0
add_connection msgdma_0.mm_write/intel_cache_coherency_translator_0.s0


# Set Base address to the components
# sysid
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/sysid.control_slave baseAddress {0x0000}
# ocram
set_connection_parameter_value agilex_hps.h2f_axi_master/ocm.axi_s1 baseAddress {0x0000}
# fpga_m2ocm_pb
set_connection_parameter_value jtg_mst.fpga_m_master/fpga_m2ocm_pb.s0 baseAddress {0x80000000}
# periph
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/periph.pb_cpu_0_s0 baseAddress {0x1000}
# intel_cache_coherency_translator
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/intel_cache_coherency_translator_0.csr baseAddress {0x0010}
set_connection_parameter_value jtg_mst.hps_m_master/intel_cache_coherency_translator_0.s0 baseAddress {0x0000}
# msgdma
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/msgdma_0.csr baseAddress {0x0040}
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/msgdma_0.descriptor_slave baseAddress {0x0020}
set_connection_parameter_value agilex_hps.h2f_lw_axi_master/msgdma_0.response baseAddress {0x0008}

sync_sysinfo_parameters
save_system qsys_top

puts "Update complete."