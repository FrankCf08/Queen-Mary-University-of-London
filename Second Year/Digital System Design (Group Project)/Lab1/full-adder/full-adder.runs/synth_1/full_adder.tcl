# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/eacm3/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-83648-EL006/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/eacm3/Desktop/project_3/project_3.cache/wt [current_project]
set_property parent.project_path C:/Users/eacm3/Desktop/project_3/project_3.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/eacm3/Desktop/project_3/project_3.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/eacm3/Desktop/project_3/project_3.srcs/sources_1/imports/Lab1 prep. work/half adder/half_adder.vhd}
  {C:/Users/eacm3/Desktop/project_3/project_3.srcs/sources_1/imports/Lab1 prep. work/two-input or/twoInputOR.vhd}
  {C:/Users/eacm3/Desktop/project_3/project_3.srcs/sources_1/imports/Lab1 prep. work/full adder/full_adder.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/eacm3/Desktop/project_3/project_3.srcs/constrs_1/imports/Desktop/DSDB_Master - Copy.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/eacm3/Desktop/project_3/project_3.srcs/constrs_1/imports/Desktop/DSDB_Master - Copy.xdc}}]


synth_design -top full_adder -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef full_adder.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file full_adder_utilization_synth.rpt -pb full_adder_utilization_synth.pb"
