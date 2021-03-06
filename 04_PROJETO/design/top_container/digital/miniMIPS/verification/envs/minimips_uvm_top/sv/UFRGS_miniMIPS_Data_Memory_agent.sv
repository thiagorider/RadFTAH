// IVB checksum: 973615848
/*-----------------------------------------------------------------
File name     : UFRGS_miniMIPS_Data_Memory_agent.sv
Developers    : traugusto
Created       : Sun Mar  8 01:06:00 2015
Description   :
Notes         :
-------------------------------------------------------------------
Copyright 2015 (c) Universidade Federal do Rio Grande do Sul
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// CLASS: UFRGS_miniMIPS_Data_Memory_agent
//
//------------------------------------------------------------------------------

class UFRGS_miniMIPS_Data_Memory_agent extends uvm_agent;
  UFRGS_miniMIPS_Data_Memory_driver driver;
  UFRGS_miniMIPS_Data_Memory_sequencer sequencer;
  UFRGS_miniMIPS_Data_Memory_monitor monitor;
 
  /***************************************************************************
   IVB-NOTE : OPTIONAL : Data_Memory Agent : Agents
   -------------------------------------------------------------------------
   Add Data_Memory fields, events and methods.
   For each field you add:
     o Update the build method.
     o Update the `uvm_component_utils_begin macro to get various UVM utilities
       for this attribute. 
   ***************************************************************************/

  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils_begin(UFRGS_miniMIPS_Data_Memory_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_component_utils_end

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Additional class methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : UFRGS_miniMIPS_Data_Memory_agent

// UVM build phase
function void UFRGS_miniMIPS_Data_Memory_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  monitor = UFRGS_miniMIPS_Data_Memory_monitor::type_id::create("monitor", this);
  if(is_active == UVM_ACTIVE) begin
    driver = UFRGS_miniMIPS_Data_Memory_driver::type_id::create("driver", this);
    sequencer = UFRGS_miniMIPS_Data_Memory_sequencer::type_id::create("sequencer", this);
  end
endfunction 
 
// UVM connect phase
function void UFRGS_miniMIPS_Data_Memory_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(is_active == UVM_ACTIVE) begin
    // Binds the driver to the sequencer using consumer-producer interface
    driver.seq_item_port.connect(sequencer.seq_item_export);
    // Enable the sequencer to peek the address phase from the monitor
    sequencer.addr_ph_port.connect(monitor.addr_ph_imp);
   end
endfunction 
