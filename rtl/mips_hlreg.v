/*------------------------------------------------------------------------------

Purpose

  HI and LO registers which store results of the multiplication and division.

------------------------------------------------------------------------------*/
module mips_hlreg   (
                    input clk,
                    input rst,

                    output[31:0]  rd_hdata,
                    output[31:0]  rd_ldata,

                    input[1:0]    wr_en,
                    input[31:0]   wr_hdata,
                    input[31:0]   wr_ldata
                    );




  reg[63:0] hlreg;




  assign rd_hdata= hlreg[63:32];
  assign rd_ldata= hlreg[31:0];

  always @(posedge clk)
  if(rst)
    hlreg<= 64'd0;
  else
    case(wr_en)
    2'b00: hlreg<= hlreg;
    2'b01: hlreg[31:0]<= wr_ldata;
    2'b10: hlreg[63:32]<= wr_hdata;
    2'b11: hlreg<= {wr_hdata,wr_ldata};
    endcase

endmodule
