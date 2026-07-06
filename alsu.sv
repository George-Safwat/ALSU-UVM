import enum_pkg::*;
module alsu(alsu_if alsuif);
always@(posedge alsuif.clk or posedge alsuif.rst) begin
   if (alsuif.rst) begin
      alsuif.leds<=16'b0;
      alsuif.out<=6'b0;
   end
   else if(alsuif.bypass_A && alsuif.bypass_B) begin
        alsuif.leds<=16'b0;
        if(alsuif.INPUT_PRIORITY=="A") begin
            alsuif.out<=alsuif.A;
        end
        else begin
            alsuif.out<=alsuif.B;
        end
    end
    else if(alsuif.bypass_A) begin
        alsuif.leds<=16'b0;
        alsuif.out<=alsuif.A;
    end
    else if(alsuif.bypass_B) begin
        alsuif.leds<=16'b0;
        alsuif.out<=alsuif.B;
    end
    else begin 
    case(alsuif.opcode)
     OR:begin
        if(alsuif.red_op_A && alsuif.red_op_B) begin
            if(alsuif.INPUT_PRIORITY=="A") begin
                alsuif.out<=|alsuif.A;
            end
            else begin
                alsuif.out<=|alsuif.B;
            end
        end
        else if(alsuif. red_op_A) begin
            alsuif.out<=|alsuif.A;
        end
        else if(alsuif.red_op_B) begin
            alsuif.out<=|alsuif.B;
        end
        else begin
            alsuif.out <= alsuif.A | alsuif.B;
        end
        end
     XOR: begin
        if(alsuif.red_op_A && alsuif.red_op_B) begin
            if(alsuif.INPUT_PRIORITY=="A") begin
                alsuif.out<=^alsuif.A;
            end
            else begin
                alsuif.out<=^alsuif.B;
            end
        end
        else if(alsuif.red_op_A) begin
            alsuif.out<=^alsuif.A;
        end
        else if(alsuif.red_op_B) begin
            alsuif.out<=^alsuif.B;
        end
        else begin
            alsuif.out <= alsuif.A ^ alsuif.B;
        end
        end
     ADD: begin
        if (alsuif.FULL_ADDER=="ON") begin
            alsuif.out <= alsuif.A + alsuif.B + alsuif.cin;
        end
        else begin
            alsuif.out <= alsuif.A + alsuif.B;
        end
     end
     MULT: alsuif.out <= alsuif.A * alsuif.B;
     SHIFT: begin
      alsuif.out <= (alsuif.direction) ? {alsuif.out[4:0], alsuif.serial_in} : {alsuif.serial_in, alsuif.out[5:1]};
     end
    ROTATE: alsuif.out <= (alsuif.direction) ? {alsuif.out[4:0], alsuif.out[5]} : {alsuif.out[0], alsuif.out[5:1]};
    INVALID1: alsuif.out <= 6'b0;
    INVALID2: alsuif.out <= 6'b0;
    endcase
    alsuif.leds<= (alsuif.opcode==INVALID1 || alsuif.opcode==INVALID2) ? ~alsuif.leds : 16'b0;
    end



end


endmodule