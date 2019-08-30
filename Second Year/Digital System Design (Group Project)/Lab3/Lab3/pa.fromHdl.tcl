
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Lab3 -dir "C:/Users/projpc1/Desktop/Lab3/planAhead_run_5" -part xc3s500eft256-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "four_bit_linear_feedback_shiftreg.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {D_flipflop.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {nbit_reg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {two_input_xor.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {nbit_shiftreg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {four_bit_linear_feedback_shiftreg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top four_bit_linear_feedback_shiftreg $srcset
add_files [list {four_bit_linear_feedback_shiftreg.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s500eft256-4
