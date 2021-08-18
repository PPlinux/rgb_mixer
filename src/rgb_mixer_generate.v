`default_nettype none
`timescale 1ns/1ns
module rgb_mixer (
    input clk,
    input reset,
    input enc_a_0, enc_a_1, enc_a_2,
    input enc_b_0, enc_b_1, enc_b_2,
    output pwm_out_0, pwm_out_1, pwm_out_2
);
   parameter n=3;
   genvar i;
   wire enc_a_db_[n-1:0];
   wire enc_b_db_[n-1:0];
   wire [7:0] enc_[n-1:0];
 
    generate
    for (i=0; i<n; i=i+1) begin  

    // generate debouncers, 2 for each encoder
      debounce #(.HIST_LEN(8)) debounce_a_[i](.clk(clk), .reset(reset), .button(enc_a_[i]), .debounced(enc_a_db_[i]));
      debounce #(.HIST_LEN(8)) debounce_b_[i](.clk(clk), .reset(reset), .button(enc_b_[i]), .debounced(enc_b_db_[i]));
      
    // geneate encoders
     encoder #(.WIDTH(8)) encoder_[i](.clk(clk), .reset(reset), .a(enc_a_db_[i]), .b(enc_b_db_[i]), .value(enc_[i]));
 
    // generate pwm modules
     pwm #(.WIDTH(8)) pwm_[i](.clk(clk), .reset(reset), .out(pwm_out_[i]), .level(enc_[i]));

     end
     endgenerate   
endmodule
