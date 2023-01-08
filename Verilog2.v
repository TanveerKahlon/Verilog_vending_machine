
module vm_tb();
reg D, Q,N, clk, reset;
reg Dispense_exp, Ret_Nickel_exp, Ret_Dime_exp, Ret_2Dime_exp;
wire [2:0] PS, NS;
wire Dispense,Ret_Nickel,Ret_Dime,Ret_2Dime;
reg [31:0] vectornum, errors;
reg [6:0] testvectors[10000:0];

cmpe125_lab6_tanveerkahlon test (.PS(PS) , .N(N), .D(D), .Q(Q) , .clk(clk), .reset(reset) , .NS(NS),
.W(Dispense), .X(Ret_Nickel), .Y(Ret_Dime), .Z(Ret_2Dime));
always
begin
clk = 1; #5; clk = 0; #5;
end

initial
begin
$readmemb ("test_vector.tv", testvectors);
vectornum = 0; errors = 0;
reset = 1; #10; reset = 0;
end

always @(posedge clk)

begin
{N,D, Q, Dispense_exp, Ret_Nickel_exp, Ret_Dime_exp, Ret_2Dime_exp} =
testvectors[vectornum];
end

always @ (negedge clk)
if (~reset)
begin //skip cycles during reset
if(Dispense!== Dispense_exp) begin //check result
$display("Error:inputs Nickel,Dime, and Quarter = %b with current state %b", {N, D,
Q}, PS);
$display("output Dispense = %b (%b expected)", Dispense, Dispense_exp);
errors = errors + 1;
end

if (Ret_Nickel !== Ret_Nickel_exp) begin // checx result
$display("Error: inputs Nickel, Dime, and Ouarter = %b with current state %b", {N, D,
Q}, PS) ;
$display(" output Return Nickel = %b (%b expected)", Ret_Nickel, Ret_Nickel_exp);
errors = errors + 1;
end
if(Ret_Dime !== Ret_Dime_exp) begin //checx result
$display("Error: inputs Nickel, Dime and Quarter = %b with current state %b", {N, D,
Q}, PS) ;
$display(" output Return Dime = %b (%b expected)", Ret_Dime, Ret_Dime_exp);

errors = errors + 1;
end

if
(Ret_2Dime !== Ret_2Dime_exp) begin // check result
$display("Error: inputs Nickel, Dime, and Quarter = %b with current state %b", {N, D,
Q}, PS) ;
$display(" output Return two Dimes = %b (%b expected) ", Ret_2Dime,
Ret_2Dime_exp);
errors = errors + 1;
end
vectornum = vectornum + 1;
if (testvectors [vectornum] === 7'bx) begin
$display("%d tests completed with %d error", vectornum, errors);
$finish;
end
end
endmodule