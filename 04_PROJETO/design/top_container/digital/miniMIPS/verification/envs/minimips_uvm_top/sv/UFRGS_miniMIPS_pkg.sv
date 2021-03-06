// IVB checksum: 389756263
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_pkg.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

// Macros that provide the UVM automation
`include "uvm_macros.svh"

package UFRGS_miniMIPS_pkg;

// UVM class library compiled in a package
import uvm_pkg::*;

`include "UFRGS_miniMIPS_types.sv"
`include "UFRGS_miniMIPS_instruction_transaction.sv"

`include "UFRGS_miniMIPS_Instruction_Memory_monitor.sv"
`include "UFRGS_miniMIPS_Instruction_Memory_sequencer.sv"
`include "UFRGS_miniMIPS_Instruction_Memory_driver.sv"
`include "UFRGS_miniMIPS_Instruction_Memory_agent.sv"

`include "UFRGS_miniMIPS_Data_Memory_monitor.sv"
`include "UFRGS_miniMIPS_Data_Memory_sequencer.sv"
`include "UFRGS_miniMIPS_Data_Memory_driver.sv"
`include "UFRGS_miniMIPS_Data_Memory_agent.sv"

`include "UFRGS_miniMIPS_bus_monitor.sv"

`include "UFRGS_miniMIPS_env.sv"

// sequences and sequence-libraries
`include "UFRGS_miniMIPS_Instruction_Memory_seq_lib.sv"
`include "UFRGS_miniMIPS_Data_Memory_seq_lib.sv"
`include "UFRGS_miniMIPS_seq_lib.sv"

endpackage
