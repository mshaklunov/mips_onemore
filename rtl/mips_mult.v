/*------------------------------------------------------------------------------

Purpose

  One stage of multicycle multiplication.

------------------------------------------------------------------------------*/
module mips_mult  (
                  input         acompl,
                  input         bcompl,

                  input[15:0]   a,
                  input[31:0]   b,
                  input[47:0]   partprod_h,
                  input[47:0]   partprod_l,

                  output[47:0]  partproduct,
                  output[63:0]  product
                  );




  wire[47:0] partprod_hl;




  assign partproduct= a*b;
  assign partprod_hl= partprod_h+partprod_l[47:16];
  assign product= (acompl^bcompl) ? ~{partprod_hl,partprod_l[15:0]}+64'd1 :
                  {partprod_hl,partprod_l[15:0]};




endmodule
