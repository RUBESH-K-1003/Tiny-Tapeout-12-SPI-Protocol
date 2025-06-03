
module rough(
input clk,rst,
input strans,

input miso,
output reg mosi,
output mclk,
output reg cs,

////////////////////////////////////////////////////////////////MEMORY INPUT /////////////////////////////////////////////////////// 

input enable,
input read_write_,   //////read or erite bar/////////// 1 read //////0 write//////////
input [7:0] data,
input [2:0] madd,
output reg [7:0] out
    );

 
 ////////////////////////////////////////////////////////////////MEMORY /////////////////////////////////////////////////////// 
reg [7:0] memory[7:0];     

always @(posedge clk or posedge rst)begin  
     if(rst) out= 8'h00;
     else if(enable ==1  && strans ==0) begin    //////// FIFO WORK ONLY ENABLE IS HIGH  AND STRANS IS LOW //////////////////////////////
        if(read_write_ ==0) memory[madd] = data;
        if(read_write_ ==1) out =  memory[madd];     
     end     
end
 
  ////////////////////////////////////////////////////////////////MEMORY ///////////////////////////////////////////////////////
 
 ////////////////////////////////////////////////////////////////PROTOCOL ///////////////////////////////////////////////////////
 
 reg [3:0]cc;
 reg [3:0]taddbuf; 
 reg [7:0]tbuf;
  
 integer i;
   
always @(posedge clk or posedge rst) begin
     if(rst)begin
            cc <= 4'h0;
            taddbuf <= 4'h0;
            tbuf <= 8'h0;
            mosi <= 0;
            cs <= 0;
            i<=0;
     end     
     
     else if (strans ==1  &&  enable ==0) begin      /////// STRANS IS ''HIGH'' AND ENABLE IS ''LOW''  -- TRANSMISSION WILL START ///////////////////////////////////////
       if(i < 65) begin  // till (65-1)/8  i.e. upto address 7 it will transmit
          if (cc == 4'h7) cc <= 4'h0;
          else  cc <= cc+1;   
          if (cc == 4'h6)  taddbuf <= taddbuf+1;
          tbuf <= memory[taddbuf]; 
          mosi = tbuf[cc];
          cs <= 1;  
          i<=i+1;
       end else mosi<=0;   
     end
end

assign mclk = clk;
    
 ////////////////////////////////////////////////////////////////PROTOCOL ///////////////////////////////////////////////////////    
    
endmodule
