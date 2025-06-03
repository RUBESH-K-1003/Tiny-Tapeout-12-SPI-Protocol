

module tb();

reg clk,rst,enable,strans; /// GENERAL I/O ////////

reg read_write_;  /////// MEMORY I/O /////////
reg [7:0] data;
reg [2:0] madd;
wire [7:0] out;

reg miso;   /////// MASTER I/O /////////
wire mosi ,mclk, cs;

wire Miso;  /////// SLAVE I/O /////////
reg Mosi, Mclk, Cs;

roughOpt uut(.clk(clk), .rst(rst), .strans(strans), .enable(enable), 
           .read_write_(read_write_), .data(data), .madd(madd), .out(out),
           .miso(miso), .mosi(mosi), .mclk(mclk), .cs(cs),
           .Miso(Miso), .Mosi(Mosi), .Mclk(Mclk), .Cs(Cs) );

always #5 clk = ~clk;

initial begin
clk = 1; rst =1;  miso=0; #10
rst=0; 
  
  enable=1; strans = 0;              /////////////// MEMORY ACTIVATED ////////////////////////////////////////////////////////////
  read_write_=0;                          
         madd= 3'h0; data = 8'h12; #10
         madd= 3'h1; data = 8'h34; #10
         madd= 3'h2; data = 8'h56; #10
         madd= 3'h3; data = 8'h78; #10
         madd= 3'h4; data = 8'h9a; #10
         madd= 3'h5; data = 8'hbc; #10
         madd= 3'h6; data = 8'hde; #10
         madd= 3'h7; data = 8'h70; #10
 read_write_ = 1; madd= 3'h0;  #10
                  madd= 3'h1;  #10
                  madd= 3'h2;  #10
                  madd= 3'h3;  #10
                  madd= 3'h4;  #10
                  madd= 3'h5;  #10
                  madd= 3'h6;  #10
                  madd= 3'h7;  #10
 
 
rst =1; #10
rst=0;                   
  enable=0; strans = 1; #700       /////////////// MASTER ACTIVATED AND TRANSMISSION STARTED ////////////////////////////////////             


rst =1; Cs=1;#10  
rst=0; 
   enable=1; strans = 1; Cs=0;  /////////////// SLAVE ACTIVATED  /////////////////////////////////////////////////////////
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;        /////////////// DATA RECEIVE SERIAL ///////////
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=0;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=0;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=0;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=0;                       #5; Mclk=0;#5;            //1byte over// 

      Mclk=1;    Mosi=0 ;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=1;                       #5; Mclk=0;#5;
      Mclk=1;    Mosi=0 ;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 0;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi=0 ;                      #5; Mclk=0;#5;            // 2 byte over// 

      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi=1 ;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi= 1;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi=1 ;                      #5; Mclk=0;#5;
      Mclk=1;    Mosi=1 ;                      #5; Mclk=0;#5;            // 3 byte over// 
      Mosi =0; Cs=1; 


rst=1; #10
rst = 0;
    strans = 0; enable=1; read_write_=1;  /////////////// MEMORY ACTIVATED AND IT READS ////////////////////////
  madd = 3'h0; #10
  madd = 3'h1; #10
  madd = 3'h2; #10;

end

endmodule
