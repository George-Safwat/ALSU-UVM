import alsu_test_pkg::*; //importing the package to use test contents
import uvm_pkg::*; //importing the package to use UVM contents
`include "uvm_macros.svh" //importing the package to use UVM macros

module top();
bit clk;
initial begin
  clk=0; 
  forever #1 clk=~clk;
end
alsu_if alsuif(clk);//interface instance
alsu DUT(alsuif);//DUT instance

initial begin
  //setting the interface in the config DB
  uvm_config_db#(virtual alsu_if)::set(null,"uvm_test_top","alsuif",alsuif);
  run_test("alsu_test");
end
endmodule