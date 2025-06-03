

module roughOpt(
input clk,rst,
input strans,
input enable,

////////////////////////////////////////////////////////////////MEMORY INPUT /////////////////////////////////////////////////////// 
input read_write_,   //////read or erite bar/////////// 1 read //////0 write//////////
input [7:0] data,
input [2:0] madd,
output reg [7:0] out,

/////////////////////////////////////////////////////////////// Master I/O  /////////////////////////////////////////////////////// 
input miso,
output reg mosi,
output mclk,
output reg cs,

////////////////////////////////////////////////////////////////SLAVE I/O  /////////////////////////////////////////////////////// 
output Miso,            
input Mosi,
input Mclk,
input Cs
    );

 
 ////////////////////////////////////////////////////////////////MEMORY /////////////////////////////////////////////////////// 
reg [7:0] memory[7:0];  

integer i;
reg [5:0]txbuf;
reg mclkbuf;
  
reg [5:0] temp;   

   
always @(posedge clk or posedge rst) begin
     if(rst)begin
            out     <= 8'h00;
            txbuf   <= 6'h00;
            mclkbuf <=0;            
            i       <=0;
            mosi    <= 0;
            cs      <= 1;
            temp    <= 6'h00;

     end     
  
     
////////////////////////////// MEMORY CODE/ ///////////////////////////// MEMORY CODE ////////////////////////////// MEMORY CODE //////////////////////////////         
    
     else if(enable ==1  && strans ==0) begin     //////// MEMORY WORK ONLY [ENABLE IS HIGH  AND STRANS IS LOW] //////////////////////////////
             if(read_write_ ==0) memory[madd] = data;    //// read_write_ IS LOW THEN WRITE OPERATION PERFORM      ////////////////////////////// 
             if(read_write_ ==1) out =  memory[madd];    //// read_write_ IS HIGH THEN READ OPERATION PERFORM      ////////////////////////////// 
     end  


////////////////////////////// MASTER CODE/ ///////////////////////////// MASTER CODE ////////////////////////////// MASTER CODE //////////////////////////////       
  
     else if (enable ==0 &&  strans ==1) begin    /////// TRANSMISSION WILL START ENABLE IS LOW AND STRANS IS HIGH  ///////////////////////////
       if(i < 64) begin                                  //// this will transmit 64bits i.e. 8 byte 
          mosi <= memory[txbuf[5:3]][txbuf[2:0]];        //// txbuf FIRST 3 BIT ADDRES AND NEXT 3 BIT SAYS THE BIT TO TRANSMIT
          txbuf = txbuf+1;                               //// txbuf INCREMENT SO THAT THIS BIT TRANSMIT AT NEXT CLOCK 
          i<=i+1;
          mclkbuf <=1;                                   //// mclkbuf THIS WILL LATCH CLK AND MCLK TILL 64 BITS THIS GIVE TO AND GATE AT LAST
          cs <= 0;  
       end else begin mosi<=0; mclkbuf <=0; cs <= 1; end //// AFTER 64 BIT ""mosi AND mclkbuf"" is zero; mclkbuf =0 then mclk is also zero
     end

////////////////////////////// SLAVE CODE/ ///////////////////////////// SLAVE CODE ////////////////////////////// SLAVE CODE ////////////////////////////////  
     
     else if (enable ==1 && strans ==1) begin   /////// RECEIVER MODE ACTIVATES WHEN ENABLE IS LOW AND STRANS IS HIGH  ///////////////////////////      
       if( Mclk==1 && Cs==0 )begin    
          memory[temp[5:3]][temp[2:0]]=Mosi;             //// Mosi data is stored in the memory               
          temp=temp+1;                                   //// increment temp
       end
     end  
       
end

////////////////////////////// MASTER clk/ ///////////////////////////// MASTER clk ////////////////////////////// MASTER clk ////////////////////////////// 
and(mclk,clk,mclkbuf);
     
    
endmodule

