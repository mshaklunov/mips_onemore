/*------------------------------------------------------------------------------

Purpose

  Placement test environment with CPU core.

------------------------------------------------------------------------------*/

`include "tenv_test/tenv_test.v"
`include "tenv_link.v"
`include "tenv_4ssram_wishbone.v"

module testbench;

/*------------------------------------------------------------------------------
  Test environment
------------------------------------------------------------------------------*/
  initial
    begin
    tenv_test.start;
    $finish;
    end

  tenv_test tenv_test();
  tenv_link tenv_link();

  //EXCEPTION HANDLER PROGRAM
  tenv_4ssram_wishbone  #(.WADDR(13), .WDATA(8))
             tenv_pexc  ();

  //MAIN PROGRAM
  tenv_4ssram_wishbone  #(.WADDR(13), .WDATA(8))
            tenv_pmain  ();

  //DATA MEMORY
  tenv_4ssram_wishbone  #(.WADDR(6), .WDATA(8))
             tenv_dmem  ();


/*------------------------------------------------------------------------------
  DUT
------------------------------------------------------------------------------*/
  mips_cpucore
       cpucore();

endmodule
