package alsu_test_pkg;
import uvm_pkg::*;
import alsu_env_pkg::*;
`include "uvm_macros.svh"
import cfg_pkg::*;

class alsu_test extends uvm_test;//uvm_test is the base class (parent class)
`uvm_component_utils(alsu_test)//macro to register the class with the factory

alsu_env env;//creating handle of the environment class
alsu_config_obj alsu_config_obj_test;//creating handle of the configuration class
virtual alsu_if alsu_test_vif; // virtual (interface module name) (any name of virtual interface)

function new(string name="alsu_test", uvm_component parent=null);
  super.new(name,parent); //calling the constructor of the parent class
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase); //calling the build_phase of the parent class
  
  env=alsu_env::type_id::create("env",this);

  //creating object of the environment class(build environment)
  //Why not simply write new()? env = new("env", this);
  //because it uses the UVM Factory, which allows you to override classes without changing your code.
  //and put this before create factory.set_type_override_by_type()
  // driver::get_type(),
  // my_driver::get_type() );

  alsu_config_obj_test=alsu_config_obj::type_id::create("alsu_config_obj_test");
  //creating object of the configuration class
  
  //Getting the interface from the config DB and storing it in the configuration class
  //Pass virtual interface to alsu_test_vif
  if(!uvm_config_db#(virtual alsu_if)::get(this,"","alsuif",alsu_config_obj_test.alsu_config_vif)) 
    `uvm_fatal("build_phase","Unable to get virtual interface from config DB");

  uvm_config_db#(alsu_config_obj)::set(this,"*","CFG",alsu_config_obj_test);
  //setting the configuration object in the config DB
 
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);//calling the run_phase of the parent class
    phase.raise_objection(this);//raising objection to prevent the simulation from ending
      #100; `uvm_info("run_phase","Inside the ALSU test",UVM_MEDIUM)//printing the message on the console 
    phase.drop_objection(this);//dropping objection to allow the simulation to end
  endtask
  
endclass
endpackage