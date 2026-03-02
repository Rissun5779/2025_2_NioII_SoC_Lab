module SEG7_avalon(
    input        clk,
    input        reset,
    input        write,
    input [31:0] writedata,
    output [6:0] oSEG0,
    output [6:0] oSEG1,
    output [6:0] oSEG2,
    output [6:0] oSEG3,
    output [6:0] oSEG4,
    output [6:0] oSEG5
  );

  reg [23:0] iDIG;

  always @(posedge clk)
  begin
    if(reset)
      iDIG <= 24'h0;
    else if(write)
      iDIG <= writedata[23:0];
  end

  SEG7_LUT_6 u0(
               .oSEG0(oSEG0),
               .oSEG1(oSEG1),
               .oSEG2(oSEG2),
               .oSEG3(oSEG3),
               .oSEG4(oSEG4),
               .oSEG5(oSEG5),
               .iDIG(iDIG)
             );

endmodule
