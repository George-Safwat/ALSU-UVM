package driver_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import enum_pkg::*;
import cfg_pkg::*;

class alsu_driver extends uvm_driver;
`uvm_component_utils(alsu_driver)

virtual alsu_if alsu_driver_vif;
alsu_config_obj alsu_driver_cfg;

function new(string name="alsu_driver", uvm_component parent=null);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(alsu_config_obj)::get(this,"","CFG",alsu_driver_cfg)) 
    `uvm_fatal("build_phase","Unable to get configuration object from config DB");

endfunction
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  alsu_driver_vif=alsu_driver_cfg.alsu_config_vif;

endfunction :connect_phase
task run_phase (uvm_phase phase);
  super.run_phase(phase);
  phase.raise_objection(this);
  alsu_driver_vif.rst=1;
  @(negedge alsu_driver_vif.clk);
  alsu_driver_vif.rst=0;
  for (int i=0;i<100;i++) begin
    alsu_driver_vif.A=$random;
    alsu_driver_vif.B=$random;
    alsu_driver_vif.opcode=alsu_op'($random);
    alsu_driver_vif.red_op_A=$random;
    alsu_driver_vif.red_op_B=$random;
    alsu_driver_vif.bypass_A=$random;
    alsu_driver_vif.bypass_B=$random;
    alsu_driver_vif.direction=$random;
    alsu_driver_vif.serial_in=$random;
    alsu_driver_vif.cin=$random;
    @(negedge alsu_driver_vif.clk);
  end
  phase.drop_objection(this);
endtask
endclass

endpackage