

module rough_tb( );

reg clk,rst,strans;
reg miso;
wire mosi,mclk,cs;

reg enable;
reg read_write_;
reg [7:0] data;
reg [2:0] madd;
wire [7:0] out;

rough uut(.clk(clk), .rst(rst), .strans(strans), .miso(miso), .mosi(mosi), .mclk(mclk), .cs(cs), .enable(enable), .read_write_(read_write_), .data(data), .madd(madd), .out(out) );

always #5 clk = ~clk;

initial begin
clk = 1; rst =1; read_write_=0; strans = 0; enable=1;#10
rst=0;   madd= 3'h0; data = 8'h12; #10
         madd= 3'h1; data = 8'h34; #10
         madd= 3'h2; data = 8'h56; #10
         madd= 3'h3; data = 8'h78; #10
         madd= 3'h4; data = 8'h9a; #10
         madd= 3'h5; data = 8'hbc; #10
         madd= 3'h6; data = 8'hde; #10
         madd= 3'h7; data = 8'hf0; #10
read_write_ = 1;     madd= 3'h0;  #10
                     madd= 3'h1;  #10
                     madd= 3'h2;  #10
                     madd= 3'h3;  #10
                     madd= 3'h4;  #10
                     madd= 3'h5;  #10
                     madd= 3'h6; #10
                     madd= 3'h7; #10
 strans = 1;enable=0; #660 $finish;

end

endmodule
