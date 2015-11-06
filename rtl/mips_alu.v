/*------------------------------------------------------------------------------

Purpose

  Arithmetic and logic unit.

------------------------------------------------------------------------------*/
module mips_alu (
                input             clk,
                input             rst,

                input[2:0]        mode,
                input             mode_acompl,
                input             mode_bcompl,
                input             mode_rinv_l,
                input             mode_div,
                input             mode_mult,

                input[31:0]       a,
                input[31:0]       b,

                output reg[31:0]  result,
                output            multdiv_ready,
                output[31:0]      quotient,
                output[31:0]      remainder,
                output[63:0]      product
                );




  wire[31:0]  a_pos;
  wire[31:0]  b_pos;
  wire[31:0]  acompl;
  wire[31:0]  bcompl;
  reg         calc_isover;

  wire[47:0]  partproduct;
  reg[1:0]    state_multdiv;
  reg[95:0]   data_hold;
  reg[3:0]    counter;
  localparam  IDLE=2'd0,
              DIV=2'd1,
              MULT_L=2'd2,
              MULT_H=2'd3;



/*------------------------------------------------------------------------------
  All calculations without multiplication and division.
------------------------------------------------------------------------------*/
  assign acompl= ~a+32'd1;
  assign bcompl= ~b+32'd1;
  assign a_pos= mode_acompl ? acompl : a;
  assign b_pos= mode_bcompl ? bcompl : b;

  always @*
  begin
  result=32'dx;
  case(mode)
  0:
    begin
    case({mode_acompl,mode_bcompl})
    2'b00: result[31:0]= a+b;
    2'b01: result[31:0]= a+bcompl;
    2'b10: result[31:0]= acompl+b;
    2'b11: result[31:0]= acompl+bcompl;
    endcase
    end
  1:result[31:0]=b<<a[4:0];
  2:result[31:0]=b>>a[4:0];
  3:
    begin
    case(a[4:0])
    5'd0:result[31:0]=b;
    5'd1:result[31:0]={{1{b[31]}},b[31:1]};
    5'd2:result[31:0]={{2{b[31]}},b[31:2]};
    5'd3:result[31:0]={{3{b[31]}},b[31:3]};
    5'd4:result[31:0]={{4{b[31]}},b[31:4]};
    5'd5:result[31:0]={{5{b[31]}},b[31:5]};
    5'd6:result[31:0]={{6{b[31]}},b[31:6]};
    5'd7:result[31:0]={{7{b[31]}},b[31:7]};
    5'd8:result[31:0]={{8{b[31]}},b[31:8]};
    5'd9:result[31:0]={{9{b[31]}},b[31:9]};
    5'd10:result[31:0]={{10{b[31]}},b[31:10]};
    5'd11:result[31:0]={{11{b[31]}},b[31:11]};
    5'd12:result[31:0]={{12{b[31]}},b[31:12]};
    5'd13:result[31:0]={{13{b[31]}},b[31:13]};
    5'd14:result[31:0]={{14{b[31]}},b[31:14]};
    5'd15:result[31:0]={{15{b[31]}},b[31:15]};
    5'd16:result[31:0]={{16{b[31]}},b[31:16]};
    5'd17:result[31:0]={{17{b[31]}},b[31:17]};
    5'd18:result[31:0]={{18{b[31]}},b[31:18]};
    5'd19:result[31:0]={{19{b[31]}},b[31:19]};
    5'd20:result[31:0]={{20{b[31]}},b[31:20]};
    5'd21:result[31:0]={{21{b[31]}},b[31:21]};
    5'd22:result[31:0]={{22{b[31]}},b[31:22]};
    5'd23:result[31:0]={{23{b[31]}},b[31:23]};
    5'd24:result[31:0]={{24{b[31]}},b[31:24]};
    5'd25:result[31:0]={{25{b[31]}},b[31:25]};
    5'd26:result[31:0]={{26{b[31]}},b[31:26]};
    5'd27:result[31:0]={{27{b[31]}},b[31:27]};
    5'd28:result[31:0]={{28{b[31]}},b[31:28]};
    5'd29:result[31:0]={{29{b[31]}},b[31:29]};
    5'd30:result[31:0]={{30{b[31]}},b[31:30]};
    5'd31:result[31:0]={{31{b[31]}},b[31]};
    endcase
    end
  4:result[31:0]=a&b;
  5:result[31:0]=mode_rinv_l ? ~(a|b) : a|b;
  6:result[31:0]=a^b;
  endcase
  end



/*------------------------------------------------------------------------------
  Multiplication and division.
------------------------------------------------------------------------------*/
  assign  multdiv_ready= state_multdiv==IDLE ? ~(mode_div | mode_mult) :
                                               calc_isover;

  always @(posedge clk)
  begin
  if(rst)
    begin
    state_multdiv<= IDLE;
    calc_isover<= 1'b0;
    data_hold<= 96'd0;
    counter<= 4'd0;
    end
  else
    begin
    case(state_multdiv)
    IDLE:
      begin
      counter<= 4'd0;
      data_hold<= {32'd0,a_pos,b_pos};
      calc_isover<= 1'b0;
      state_multdiv<= mode_div ? DIV :
              mode_mult ? MULT_L : IDLE;
      end
    DIV:
      begin
      counter<= counter+1'b1;
      data_hold[95:32]<= {remainder,quotient};
      calc_isover<= counter==4'd14 ? 1'b1 : calc_isover;
      state_multdiv<= calc_isover | !mode_div ? IDLE : DIV;
      end
    MULT_L:
      begin
      data_hold[47:32]<= data_hold[63:48];
      data_hold[95:48]<= partproduct;
      state_multdiv<= MULT_H;
      end
    MULT_H:
      begin
      counter<= counter+1'b1;
      data_hold[47:0]<= partproduct;
      calc_isover<= ~counter[0] ? 1'b1 : calc_isover;
      state_multdiv<= calc_isover | !mode_mult ? IDLE : MULT_H;
      end
    endcase
    end
  end

  mips_div
     i_div   (
             .acompl(mode_acompl),
             .bcompl(mode_bcompl),
             .div_ready(calc_isover),

             .a(data_hold[63:32]),
             .b(data_hold[31:0]),
             .remainder_in(data_hold[95:64]),

             .quotient(quotient),
             .remainder(remainder)
             );

  mips_mult
     i_mult  (
             .acompl(mode_acompl),
             .bcompl(mode_bcompl),

             .a(data_hold[47:32]),
             .b(data_hold[31:0]),
             .partprod_h(data_hold[47:0]),
             .partprod_l(data_hold[95:48]),

             .partproduct(partproduct),
             .product(product)
             );




endmodule
