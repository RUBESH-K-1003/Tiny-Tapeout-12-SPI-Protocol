module rough_tb( );

reg clk,rst,strans;
reg miso;
wire mosi,mclk,cs;

reg enable;
reg write;
reg read;
reg [7:0] data;
wire [7:0] out;

rough uut(.clk(clk), .rst(rst), .strans(strans), .miso(miso), .mosi(mosi), .mclk(mclk), .cs(cs), .enable(enable), .write(write), .read(read), .data(data), .out(out) );

always #5 clk = ~clk;




initial begin
clk = 1; rst =1; write=0;read=0; strans = 0; enable=1;#10
rst=0; data = 8'h02; write =1; #2 write=0; #8;
       data = 8'h04; write =1; #2 write=0; #8;
       data = 8'h08; write =1; #2 write=0; #8;
       data = 8'h16; write =1; #2 write=0; #8;
       data = 8'h32; write =1; #2 write=0; #8;
       data = 8'h64; write =1; #2 write=0; #8;
       data = 8'h6f; write =1; #2 write=0; #8;
       data = 8'hff; write =1; #2 write=0; #8;
        read = 1; #80;
 strans = 1;enable=0;

end



///////////////////////////////////////////////MEMORY /////////////////////////////////////////////////////////////////////
      

endmodule
