
module cmpe125_lab6_tanveerkahlon (PS, N, D, Q, clk, reset, NS, W, X, Y, Z);
input N, D, Q, reset, clk;
output reg [2:0] PS, NS;
output reg W,X,Y,Z;
always @ (*)
begin
NS[2] = (~PS[2] & PS[1] & ~PS[0] & D) | (~PS[2] & PS[1] & PS[0] & N);
NS[1] = (~PS[2] & ~PS[1] & D) | (~PS[2] & N & (PS[1] ^ PS[0]));
NS[0] = (~PS[2] & ~PS[0] & N) | (~PS[2] & PS[1] & PS[0] & D);
end

always @ (posedge clk, posedge reset)
begin
if (reset)
PS <= 3'b000;
else
PS <= NS;
end

//outputs
always @(*)
begin
W = ((~PS[2])&(~PS[1])&(~PS[0])&Q) | ((~PS[2]) &(~PS[1])&(PS[0])&Q) | ((~PS[2])
& (PS[1])& (~PS[0])&Q) | ((~PS[2]) &(PS[1])&(PS[0])&(Q|D)) | ((PS[2])
&(~PS[1])&(~PS[0])&(N|D|Q));
X = (~PS[2] & PS[0] & Q) | (PS[2] & ~PS[1] & ~PS[0] & Q);
Y = ~PS[2] & PS[1] & Q;
Z = PS[2] & ~PS[1] & ~PS[0] & Q;
end
endmodule