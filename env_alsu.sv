package alsu_env_pkg;
import uvm_pkg::*;
import driver_pkg::*;
`include "uvm_macros.svh"

class alsu_env extends uvm_env; //uvm_env is the base class (parent class)
`uvm_component_utils(alsu_env) //macro to register the class with the factory

alsu_driver driver;//creating handle of the driver class

function new(string name="alsu_env", uvm_component parent=null);
  super.new(name,parent);//calling the constructor of the parent class
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//calling the build_phase of the parent class

driver=alsu_driver::type_id::create("driver",this);
//creating object of the driver class

endfunction: build_phase

endclass
endpackage