`include "define.v"

module mux_param #(
    parameter NUM_INPUT = 2, 
    parameter DATA_WIDTH = 4
)(
    data_in, 
    sel,
    data_out
);

localparam SEL_WIDTH = `log2(NUM_INPUT);

input [DATA_WIDTH*NUM_INPUT-1:0] data_in;
input [SEL_WIDTH-1:0] sel;
output [DATA_WIDTH-1:0] data_out;

assign data_out = data_in[sel*DATA_WIDTH +: DATA_WIDTH];

endmodule
