/*------------------------------------------------------------------------------

Purpose

  Multicycle division.

------------------------------------------------------------------------------*/
module mips_div (
                input         acompl,
                input         bcompl,
                input         div_ready,

                input[31:0]   a,
                input[31:0]   b,
                input[31:0]   remainder_in,

                output[31:0]  quotient,
                output[31:0]  remainder
                );




  wire[31:0] a_mux;
  wire[31:0] r_mux;
  wire[31:0] q;
  wire[31:0] r;




  assign quotient= div_ready & (acompl^bcompl) ? ~q+32'd1 : q;
  assign remainder= div_ready & acompl ? ~r+32'd1 : r;

  mips_div_stage #(.WIDTH(32),.STAGE(2))
         i_stage
                  (
                  .a(a),
                  .b(b),
                  .remainder_in(remainder_in),

                  .quotient_out(q),
                  .remainder_out(r)
                  );




endmodule
