
package require -exact qsys 25.1

add_component intel_jop_blaster_0 ip/qsys_top/qsys_top_intel_jop_blaster_0.ip intel_jop_blaster intel_jop_blaster_0 1.2.2
load_component intel_jop_blaster_0
set_component_parameter_value EXPORT_SLD_ED {0}
set_component_parameter_value MEM_SIZE {4096}
set_component_parameter_value MEM_WIDTH {64}
set_component_parameter_value USE_TCK_ENA {1}
set_component_project_property HIDE_FROM_IP_CATALOG {false}
save_component

add_connection clk_100.out_clk/intel_jop_blaster_0.clk
set_connection_parameter_value clk_100.out_clk/intel_jop_blaster_0.clk clockDomainSysInfo {1}
set_connection_parameter_value clk_100.out_clk/intel_jop_blaster_0.clk clockRateSysInfo {100000000.0}
set_connection_parameter_value clk_100.out_clk/intel_jop_blaster_0.clk clockResetSysInfo {}
set_connection_parameter_value clk_100.out_clk/intel_jop_blaster_0.clk resetDomainSysInfo {1}

add_connection rst_in.out_reset/intel_jop_blaster_0.reset
set_connection_parameter_value rst_in.out_reset/intel_jop_blaster_0.reset clockDomainSysInfo {5}
set_connection_parameter_value rst_in.out_reset/intel_jop_blaster_0.reset clockResetSysInfo {}
set_connection_parameter_value rst_in.out_reset/intel_jop_blaster_0.reset resetDomainSysInfo {5}

add_connection agilex_hps.h2f_lw_axi_master/intel_jop_blaster_0.avmm_s

set_connection_parameter_value agilex_hps.h2f_lw_axi_master/intel_jop_blaster_0.avmm_s baseAddress {0x00020000}

save_system qsys_top.qsys

puts "Update complete."
