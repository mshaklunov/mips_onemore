/*------------------------------------------------------------------------------

Purpose

  Wishbone wrrapper for synchronous RAM.

------------------------------------------------------------------------------*/

`include "tenv_ssram.v"

module tenv_4ssram_wishbone #(parameter                 WADDR=10,
                                                        WDATA=8)
                            (
                            input[31:0]                 access_time,

                            input                       clk_i,
                            input                       rst_i,
                            input                       cyc_i,
                            input                       stb_i,
                            input                       we_i,
                            input[3:0]                  sel_i,
                            input[(WDATA*4)-1:0]        dat_i,
                            input[WADDR-1:0]            adr_i,
                            output                      stall_o,
                            output reg                  ack_o,
                            output[(WDATA*4)-1:0]   dat_o
                            );




  reg[31:0]  counter;
  wire[31:0] dat_owire;




  assign stall_o= access_time>1 & !ack_o ? stb_i : 1'b0;
  assign dat_o= ack_o ? dat_owire : 32'dx;

  always @(posedge clk_i)
  begin
  if(rst_i)
    begin
    ack_o<= 1'b0;
    counter<= 1;
    end
  else
    begin
    counter<= !stb_i | ack_o ? 1 :
              stb_i ? counter+1'b1 : counter;
    ack_o<= (access_time<2 |
            (!ack_o & (counter+1)==access_time)) & stb_i ? 1'b1 : 1'b0;
    end
  end

  tenv_ssram       #(.WADDR(WADDR), .WDATA(WDATA))
          i0
                    (
                    .clk(clk_i),
                    .wr(we_i & sel_i[0]),
                    .addr(adr_i),
                    .datain(dat_i[(WDATA*1)-1:WDATA*0]),
                    .dataout(dat_owire[(WDATA*1)-1:WDATA*0])
                    );

  tenv_ssram       #(.WADDR(WADDR), .WDATA(WDATA))
          i1
                    (
                    .clk(clk_i),
                    .wr(we_i & sel_i[1]),
                    .addr(adr_i),
                    .datain(dat_i[(WDATA*2)-1:WDATA*1]),
                    .dataout(dat_owire[(WDATA*2)-1:WDATA*1])
                    );

  tenv_ssram       #(.WADDR(WADDR), .WDATA(WDATA))
          i2
                    (
                    .clk(clk_i),
                    .wr(we_i & sel_i[2]),
                    .addr(adr_i),
                    .datain(dat_i[(WDATA*3)-1:WDATA*2]),
                    .dataout(dat_owire[(WDATA*3)-1:WDATA*2])
                    );

  tenv_ssram       #(.WADDR(WADDR), .WDATA(WDATA))
          i3
                    (
                    .clk(clk_i),
                    .wr(we_i & sel_i[3]),
                    .addr(adr_i),
                    .datain(dat_i[(WDATA*4)-1:WDATA*3]),
                    .dataout(dat_owire[(WDATA*4)-1:WDATA*3])
                    );

endmodule
