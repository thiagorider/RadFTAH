// IVB checksum: 1377731035
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_if.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:01 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

/******************************************************************************

  FILE : UFRGS_miniMIPS_bus_monitor_if.sv

 ******************************************************************************/

interface UFRGS_miniMIPS_if (input sig_clock, input sig_reset);

  // Import the UVM package
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Control flags
  bit has_checks = 1;
  bit has_coverage = 1;

  /***************************************************************************
   IVB-NOTE : REQUIRED : UVC signals definitions : signals definitions
   -------------------------------------------------------------------------
   Adjust the signal names as required and add necessary signals.
   Notice that if you change a signal name, you should change it through all 
   the UVC files.
   ***************************************************************************/

  // Actual Signals
  logic [0:0] sig_request;
  logic [0:0] sig_grant;
  logic [31:0] sig_addr;
  logic [1:0] sig_size;
  logic sig_read;
  logic sig_write;
  logic sig_start;
  logic sig_bip;
  wire logic   [31:0] sig_data;
  logic [31:0] sig_data_out;
  logic sig_wait;
  logic sig_error;

  logic rw;

  // Coverage and assertions to be implemented here.
  /***************************************************************************
   IVB-NOTE : REQUIRED : Assertion checks : Interface
   -------------------------------------------------------------------------
   Add assertion checks as required. See assertion examples below.
   ***************************************************************************/
   
  // SVA default clocking
  wire uvm_assert_clk = sig_clock && has_checks;
  default clocking master_clk @(negedge uvm_assert_clk);
  endclocking

  // SVA Default reset
  default disable iff (sig_reset);

  // Address must not be X or Z during Address Phase
  assertAddrUnknown:assert property (
    ($onehot(sig_grant) |-> !$isunknown(sig_addr)))
  else
    `uvm_error("ERR_ADDR_XZ", "Address went to X or Z during Address Phase")

  // Read must not be X or Z during Address Phase
  assertReadUnknown:assert property ( 
    ($onehot(sig_grant) |-> !$isunknown(sig_read)))
  else
    `uvm_error("ERR_READ_XZ", "READ went to X or Z during Address Phase")
 
  // Write must not be X or Z during Address Phase
  assertWriteUnknown:assert property ( 
    ($onehot(sig_grant) |-> !$isunknown(sig_write)))
  else
    `uvm_error("ERR_WRITE_XZ", "WRITE went to X or Z during Address Phase")

  // Size must not be X or Z during Address Phase
  assertSizeUnknown:assert property ( 
    ($onehot(sig_grant) |-> !$isunknown(sig_size)))
  else
    `uvm_error("ERR_SIZE_XZ", "SIZE went to X or Z during Address Phase")

  // Wait must not be X or Z during Data Phase
  assertWaitUnknown:assert property ( 
    ($onehot(sig_grant) |=> !$isunknown(sig_wait)))
  else
    `uvm_error("ERR_WAIT_XZ", "WAIT went to X or Z during Data Phase")

  // Error must not be X or Z during Data Phase
  assertErrorUnknown:assert property ( 
    ($onehot(sig_grant) |=> !$isunknown(sig_error)))
  else
    `uvm_error("ERR_ERROR_XZ", "ERROR went to X or Z during Data Phase")

  //Reset must be asserted for at least 3 clocks each time it is asserted
  assertResetFor3Clocks: assert property (
    ($rose(sig_reset) |=> sig_reset[*2]))
  else 
    `uvm_error("ERR_SHORT_RESET_DURING_TEST", 
      "Reset was asserted for less than 3 clock cycles")
 
  // Read and write never true at the same time
  assertReadOrWrite: assert property (
    ($onehot(sig_grant) |-> !(sig_read && sig_write)))
  else
    `uvm_error("ERR_READ_OR_WRITE", "Read and Write true at the same time")

endinterface : UFRGS_miniMIPS_if

