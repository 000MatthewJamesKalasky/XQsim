define_design_lib WORK -path ./WORK

set TOP_MODULE QID
set src_path "/home/qusdlfrnjs/CryoQC/XQsim_release/src/XQ-estimator/QID/baseline/rtl"
set out_path "/home/qusdlfrnjs/CryoQC/XQsim_release/src/XQ-estimator/QID/baseline/cmos/D5_Q15"
set PDK_path "./freepdk-45nm/stdview"
set SYN_path "/home/synopsys/dc_compiler_2019/syn/P-2019.03/libraries/syn"

set search_path "$src_path \ $PDK_path \ $SYN_path"
set ddc_path "$out_path/${TOP_MODULE}_77k.ddc"

set target_library "$PDK_path/NangateOpenCellLibrary.db"
set synthetic_library "$SYN_path/dw_foundation.sldb"
set link_library "* $target_library $synthetic_library"
set mw_reference_library "./milky-45nm-77k"
set mw_design_library "./mw_design_lib_77k"
set technology_file "$PDK_path/rtk-tech-77k.tf"
set hdlin_while_loop_iterations 100000

file delete -force $mw_design_library
create_mw_lib $mw_design_library \
    -technology $technology_file \
    -mw_reference_library $mw_reference_library \
    -open

set enable_phys_lib_during_elab true
analyze ${src_path} -autoread -recursive -format verilog
elaborate ${TOP_MODULE}
link

create_clock -period 0.4 "clk"
set cache_read {}
set_dp_smartgen_options -optimize_for speed

check_library
set_host_options -max_cores 16
compile_ultra -no_autoungroup -spg

write -hierarchy -format ddc -output ${ddc_path}

exit
