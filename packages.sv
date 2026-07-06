package enum_pkg;
typedef enum bit [2:0] 
{
    OR=3'b000,
    XOR=3'b001,
    ADD=3'b010,
    MULT=3'b011,
    SHIFT=3'b100,
    ROTATE=3'b101,
    INVALID1=3'b110,
    INVALID2=3'b111
    } alsu_op;
endpackage