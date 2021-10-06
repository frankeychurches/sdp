module full_adder_v1(a,b,cin,sum,cout);

	input a,b,cin;
	output sum,cout;
	// No es necesario instanciar el a*b+axorb*cin, se encarga 
	// de derivar el acarreo el propio verilog.
	assign {cout,sum} = a + b + cin; 

endmodule

	