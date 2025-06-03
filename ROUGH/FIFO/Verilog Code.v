
module memory(
input clk,rst,
input enable,
input write,
input read,
input [7:0] data,
output reg [7:0] out
  );
    
reg [7:0]mem[7:0];
reg [3:0]radd;
reg [3:0]wadd;

always @(posedge clk or posedge rst)begin
  if(enable ==1) begin
     if(rst) begin
        out= 8'h00;
        radd = 3'b000;
        wadd = 3'b000;
     end
     else begin
        if(write ==1) begin
            mem[wadd] = data;
            wadd = wadd+1;
        end
        if(read ==1) begin
            out = mem[radd];
            radd = radd+1;
        end    
     end     
  end
end    
endmodule
