
module tenv_ssram    #(parameter              WADDR=10,
                                              WDATA=8)
                      (input                  clk,
                       input                  wr,
                       input[WADDR-1:0]       addr,
                       input[WDATA-1:0]       datain,
                       output reg[WDATA-1:0]  dataout);




  reg[WDATA-1:0] mem[(2**WADDR)-1:0];




  always @(posedge clk)
  begin
  if(wr) mem[addr]<= datain;
  else   dataout<= mem[addr];
  end




endmodule
