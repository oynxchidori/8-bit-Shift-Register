// SW[7:0], KEY[3:0] data input
// LEDR[7:0] data output

module Shifter(SW, KEY, LEDR);
    input [9:0]SW; //initialize input
	 input [3:0]KEY;
	 output [7:0]LEDR; //output display
	 wire d1;
	 
	 mux2to1 mm(
              .x(1'b0),
				  .y(SW[7]),
				  .s(KEY[3]),
				  .m(d1)
				  );
				  
	 ShifterBit s1(
              .in(d1),
				  .local_val(SW[7]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[7])
				  );
		  
	 ShifterBit s2(
              .in(LEDR[7]),
				  .local_val(SW[6]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[6])
				  );

	 ShifterBit s3(
              .in(LEDR[6]),
				  .local_val(SW[5]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[5])
				  );

	 ShifterBit s4(
              .in(LEDR[5]),
				  .local_val(SW[4]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[4])
				  );
		  
	 ShifterBit s5(
              .in(LEDR[4]),
				  .local_val(SW[3]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[3])
				  );
			  
	 ShifterBit s6(
              .in(LEDR[3]),
				  .local_val(SW[2]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[2])
				  );
			  
	 ShifterBit s7(
              .in(LEDR[2]),
				  .local_val(SW[1]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[1])
				  );
			  
	 ShifterBit s8(
              .in(LEDR[1]),
				  .local_val(SW[0]),
				  .shift(KEY[2]),
				  .load_n(KEY[1]),
				  .clk(KEY[0]),
				  .reset(SW[9]),
				  .out(LEDR[0])
				  );
endmodule



module ShifterBit(in, local_val, shift, load_n, clk, reset, out);
    input in, local_val, shift, load_n, clk, reset;
	 output out;
	 wire dfom, dtdff;
	 
	 mux2to1 m1(
              .x(out),
				  .y(in),
				  .s(shift),
				  .m(dfom)
				  );
	 mux2to1 m2(
				  .x(local_val),
				  .y(dfom),
				  .s(load_n),
				  .m(dtdff)
				  );
	 flipflop f1(
				  .clock(clk),
				  .reset_n(reset),
				  .d(dtdff),
				  .q(out)
				  );
endmodule

module flipflop(clock, reset_n, d, q);
	 input clock;
	 input reset_n;
	 input d;
	 output q;
	 reg q;
	 
	 always @(posedge clock)
	 
	 begin
	     if (reset_n == 1'b0)
				q <= 0;
		  else
				q <= d;
	 end
endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule
