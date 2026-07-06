import enum_pkg::*;
interface alsu_if(clk);
parameter INPUT_PRIORITY="A";
parameter FULL_ADDER="ON";
input bit clk;
bit  rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction;
bit [2:0] A, B;
bit [15:0] leds;
bit [5:0] out;

alsu_op opcode;

modport DUT(input clk, rst,cin,serial_in,red_op_A,red_op_B,
bypass_A,bypass_B,direction,A ,B ,opcode,output leds, out);

/*modport MONITOR(input clk, count_out,rst_n, load_n, up_down, ce,
data_load, max_count, zero);

modport sva(input clk, count_out,rst_n, load_n, up_down, ce,
data_load,max_count,zero);*/
endinterface