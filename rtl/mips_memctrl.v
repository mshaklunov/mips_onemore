/*------------------------------------------------------------------------------

Purpose

  Control Wishbone interface to memory.

------------------------------------------------------------------------------*/
module mips_memctrl #(parameter ADDR_RESET=32'hBFC0_0000)
                    (
                    input             clk,
                    input             rst,

                    input             pl_pcpause,
                    input             pcreg_wen,
                    input[31:2]       pcreg_wdata,
                    output reg[31:2]  pcreg_crntcmd,
                    output reg[31:2]  pcreg_nextcmd,

                    input             exception,

                    input             pmem_stall_i,
                    input             pmem_ack_i,
                    input[31:0]       pmem_dat_i,
                    output[31:2]      pmem_adr_o,
                    output reg        pmem_stb_o,
                    output reg        pmem_cyc_o,
                    output            pmem_branch_ended,

                    output            fifocmd_empty,
                    output[31:0]      fifocmd_rdata,

                    input             dmem_wen,
                    input[31:2]       dmem_waddr,
                    input[31:0]       dmem_wdata,
                    input[3:0]        dmem_wbytesel,
                    input             dmem_wrw,
                    input[5:0]        dmem_wloadinstr,
                    input[4:0]        dmem_wgregbusy,
                    input[1:0]        dmem_wbytesel_int,
                    output reg[1:0]   dmem_rreq,
                    output reg[1:0]   dmem_rmemdir,
                    output reg[4:0]   dmem_rgregbusy_queued,
                    output reg[4:0]   dmem_rgregbusy,
                    output reg[5:0]   dmem_rloadinstr,
                    output reg[1:0]   dmem_rbytesel,

                    input             dmem_stall_i,
                    input             dmem_ack_i,
                    output reg[31:2]  dmem_adr_o,
                    output reg[31:0]  dmem_dat_o,
                    output reg        dmem_cyc_o,
                    output reg        dmem_stb_o,
                    output reg        dmem_we_o,
                    output reg[3:0]   dmem_sel_o
                    );




  reg[1:0]    pmem_rreq;
  wire        pmem_maxwaitreq;
  reg[31:2]   pcreg;
  wire        pcreg_pause;
  reg         pcreg_wen_hold;
  reg[31:2]   pcreg_wdata_hold;
  reg[31:2]   pcreg_before_branch;

  wire        fifocmd_wr;
  wire        fifocmd_rd;

  wire        fifopc_wr;
  wire        fifopc_rd;
  wire[31:2]  fifopc_rdata;

  reg[5:0]    dmem_rloadinstr_queued;
  reg[1:0]    dmem_rbytesel_queued;




/*-----------------------------------------------------------------------------
  PROGRAM MEMORY
------------------------------------------------------------------------------*/
  assign pcreg_pause= !pmem_cyc_o |                    //INITIAL
                      pmem_stall_i |                   //WISHBONE STALL
                      pmem_maxwaitreq |                //MAX WAITING REQ
                      pl_pcpause;                      //PIPELINE WAIT

  assign pmem_adr_o= pcreg;
  assign pmem_maxwaitreq= pmem_rreq[1] & !pmem_ack_i & fifocmd_empty;
  assign pmem_branch_ended= pcreg_before_branch==pcreg_crntcmd;

  assign fifocmd_wr= (pl_pcpause | !pmem_stb_o) & pmem_ack_i;
  assign fifocmd_rd= !fifocmd_empty & !pl_pcpause;

  assign fifopc_wr= !pcreg_pause | !pmem_cyc_o;
  assign fifopc_rd= ~(pmem_stall_i | pl_pcpause |(!pmem_ack_i & fifocmd_empty));

  always @(posedge clk)
  if(rst)
    begin
    pcreg<= ADDR_RESET[31:2];
    pcreg_crntcmd<= ADDR_RESET[31:2];
    pcreg_nextcmd<= ADDR_RESET[31:2];
    pmem_stb_o<= 1'b0;
    pmem_cyc_o<= 1'b0;
    pmem_rreq<= 2'd0;
    pcreg_wen_hold<= 1'b0;
    pcreg_wdata_hold<= 30'd0;
    pcreg_before_branch<= 30'd0;
    end
  else
    begin
    pmem_cyc_o<= 1'b1;
    pmem_stb_o<= (pmem_maxwaitreq) |
                 (!pmem_stall_i & pl_pcpause) ? 1'b0 : 1'b1;
    pmem_rreq<= !(pmem_stall_i | pmem_maxwaitreq | pl_pcpause) &
                !pmem_ack_i & fifocmd_empty ? {pmem_rreq[0],1'b1} :
                !pl_pcpause & (pmem_stall_i | pmem_maxwaitreq) &
                (pmem_ack_i | !fifocmd_empty) ? {1'b0,pmem_rreq[1]} :
                pmem_rreq;

    if(pcreg_pause)
      begin
      pcreg_wen_hold<= pcreg_wen ? 1'b1 : pcreg_wen_hold;
      pcreg<= pcreg;
      end
    else if(pcreg_wen_hold)
      begin
      pcreg_wen_hold<= 1'b0;
      pcreg<= pcreg_wdata_hold;
      end
    else if(pcreg_wen)
      begin
      pcreg_wen_hold<= 1'b0;
      pcreg<= pcreg_wdata;
      end
    else
      begin
      pcreg_wen_hold<= 1'b0;
      pcreg<= pcreg+1'b1;
      end

    pcreg_wdata_hold<=  pcreg_wen ? pcreg_wdata :
                        pcreg_wdata_hold;
    pcreg_before_branch<= pcreg_wen ? pcreg : pcreg_before_branch;

    if(!pmem_cyc_o & pmem_stall_i | pl_pcpause | (!pmem_ack_i & fifocmd_empty))
      begin
      pcreg_crntcmd<= pcreg_crntcmd;
      pcreg_nextcmd<= pcreg_nextcmd;
      end
    else
      begin
      pcreg_crntcmd<= fifopc_rdata;
      pcreg_nextcmd<= fifopc_rdata+1'b1;
      end
    end

  mips_fifosync     #(.S_WORD(30), .SPOWER2_MEM(1))
      i_fifopc      (
                    .clk(clk),
                    .rst(rst),

                    .wr_en(fifopc_wr),
                    .wr_data(pcreg_wen_hold ? pcreg_wdata_hold :
                             pcreg_wen ? pcreg_wdata :
                             pmem_cyc_o ? pcreg+1'b1 : 30'd0),

                    .rd_en(fifopc_rd),
                    .rd_data(fifopc_rdata),

                    .fifo_full(),
                    .fifo_empty()
                    );

  mips_fifosync     #(.S_WORD(32), .SPOWER2_MEM(1))
      i_fifocmd     (
                    .clk(clk),
                    .rst(rst),

                    .wr_en(fifocmd_wr),
                    .wr_data(pmem_dat_i),

                    .rd_en(fifocmd_rd),
                    .rd_data(fifocmd_rdata),

                    .fifo_full(),
                    .fifo_empty(fifocmd_empty)
                    );


/*------------------------------------------------------------------------------
  DATA MEMORY
------------------------------------------------------------------------------*/
  always @(posedge clk)
  if(rst)
    begin
    dmem_rmemdir<= 2'd0;
    dmem_rreq<= 2'd0;

    dmem_rgregbusy_queued<= 5'd0;
    dmem_rloadinstr_queued<= 6'd0;
    dmem_rbytesel_queued<= 2'd0;
    dmem_rgregbusy<= 5'd0;
    dmem_rloadinstr<= 6'd0;
    dmem_rbytesel<= 2'd0;

    dmem_cyc_o<= 1'b0;
    dmem_stb_o<= 1'b0;
    dmem_adr_o<= 30'd0;
    dmem_dat_o<= 32'd0;
    dmem_sel_o<= 4'd0;
    dmem_we_o<= 1'b0;
    end
  else
    begin

    if(!(dmem_rreq[1] & !dmem_ack_i))//ACTIVE STATE
      begin

      //EXTERNAL SIGNALS
      dmem_stb_o<= !dmem_stall_i ? dmem_wen : dmem_stb_o;
      if(dmem_wen)
        begin
        dmem_cyc_o<= 1'b1;
        dmem_adr_o<= dmem_waddr;
        dmem_dat_o<= dmem_wdata;
        dmem_sel_o<= dmem_wbytesel;
        dmem_we_o<= dmem_wrw;
        end
      else if(!dmem_rreq[1] & dmem_rreq[0] & dmem_ack_i) dmem_cyc_o<= 1'b0;

      //INTERNAL CONTROL
      if(dmem_wen & !dmem_rreq[0])//ZERO REQUEST
        begin
        dmem_rmemdir[0]<= dmem_wrw;
        dmem_rreq[0]<= 1'b1;
        if(!dmem_wrw)
          begin
          dmem_rgregbusy<= dmem_wgregbusy;
          dmem_rloadinstr<= dmem_wloadinstr;
          dmem_rbytesel<= dmem_wbytesel_int;
          end
        end
      else if(dmem_wen & !dmem_rreq[1] & !dmem_ack_i)//ONE REQUEST
        begin
        dmem_rmemdir[1]<= dmem_wrw;
        dmem_rreq[1]<= 1'b1;

        if(!dmem_wrw)
          begin
          if(dmem_rloadinstr==0)//QUEUE HAS NO READ REQUEST
            begin
            dmem_rgregbusy<= dmem_wgregbusy;
            dmem_rloadinstr<= dmem_wloadinstr;
            dmem_rbytesel<= dmem_wbytesel_int;
            end
          else//QUEUE HAS ONE READ REQUEST
            begin
            dmem_rgregbusy_queued<= dmem_wgregbusy;
            dmem_rloadinstr_queued<= dmem_wloadinstr;
            dmem_rbytesel_queued<= dmem_wbytesel_int;
            end
          end

        end
      else if(dmem_wen & !dmem_rreq[1] & dmem_ack_i)//ONE REQUEST
        begin
        dmem_rmemdir[0]<= dmem_wrw;
        dmem_rreq[0]<= 1'b1;

        if(!dmem_wrw)
          begin
          dmem_rgregbusy<= dmem_wgregbusy;
          dmem_rloadinstr<= dmem_wloadinstr;
          dmem_rbytesel<= dmem_wbytesel_int;
          end
        end
      else if(dmem_wen & dmem_rreq[1] & dmem_ack_i)//TWO REQUESTS
        begin
        dmem_rmemdir[1]<= dmem_wrw;
        dmem_rmemdir[0]<= dmem_rmemdir[1];
        dmem_rreq[1]<= 1'b1;

        if(!dmem_wrw)
          begin
          if(dmem_rloadinstr==0 | //QUEUE HAS NO READ REQUEST OR
            dmem_rmemdir[1])      //QUEUE HAS ONE READ REQUEST
                                  //WHICH IS ACKING
            begin
            dmem_rgregbusy<= dmem_wgregbusy;
            dmem_rloadinstr<= dmem_wloadinstr;
            dmem_rbytesel<= dmem_wbytesel_int;
            end
          else if(dmem_rmemdir[0])//QUEUE HAS ONE READ REQUEST
                                  //AND WRITE REQUEST IS ACKING
            begin
            dmem_rgregbusy_queued<= dmem_wgregbusy;
            dmem_rloadinstr_queued<= dmem_wloadinstr;
            dmem_rbytesel_queued<= dmem_wbytesel_int;
            end
          else//QUEUE HAS TWO READ REQUEST FIRST IS ACKING
            begin
            dmem_rgregbusy_queued<= dmem_wgregbusy;
            dmem_rloadinstr_queued<= dmem_wloadinstr;
            dmem_rbytesel_queued<= dmem_wbytesel_int;
            dmem_rgregbusy<= dmem_rgregbusy_queued;
            dmem_rloadinstr<= dmem_rloadinstr_queued;
            dmem_rbytesel<= dmem_rbytesel_queued;
            end
          end
        end
      else if(!dmem_wen & dmem_ack_i)
        begin
        dmem_rmemdir[1]<= 1'b0;
        dmem_rmemdir[0]<= dmem_rmemdir[1];
        dmem_rreq[1]<= 1'b0;
        dmem_rreq[0]<= dmem_rreq[1];

        if(!dmem_rmemdir[0])
          begin
          dmem_rgregbusy_queued<= 0;
          dmem_rloadinstr_queued<= 0;
          dmem_rbytesel_queued<= 0;
          dmem_rgregbusy<= dmem_rgregbusy_queued;
          dmem_rloadinstr<= dmem_rloadinstr_queued;
          dmem_rbytesel<= dmem_rbytesel_queued;
          end
        end
      //ELSE - ALL IS HOLDING
      end
    else if(dmem_rreq[1] & !dmem_ack_i & !dmem_stall_i)//WAIT STATE
                                                       //WITH !DMEM_ACK_I
      dmem_stb_o<= 1'b0;
    //ELSE WAIT STATE WITH !DMEM_STALL_I - ALL IS HOLDING
    end




endmodule
