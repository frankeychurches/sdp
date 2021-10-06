module adder_4b (sum, c_out, a,b,c_in);
	input [3:0] a,b;
	input c_in;
	
	output [3:0] sum;
	output c_out;
	
	wire acarreo0, acarreo1, acarreo2;
	
	full_adder_v1 fa0 (a[0],b[0],c_in,sum[0],acarreo0);
	full_adder_v1 fa1 (a[1],b[1],acarreo0, sum[1], acarreo1);
	full_adder_v1 fa2 (a[2],b[2],acarreo1, sum[2], acarreo2);
	full_adder_v1 fa3 (a[3],b[3],acarreo2, sum[3], c_out);
	
endmodule
	