module Sum7Seg (a,b, cin, segment);
	 
input [3:0] a,b;
input cin;
output [6:0] segment;

wire [3:0] sum;
wire cout;

adder_4b adder0 (sum, cout, a, b, cin);
hex7seg display0 (sum, segment);


endmodule