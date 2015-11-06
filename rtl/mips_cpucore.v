/*------------------------------------------------------------------------------

Purpose

  Top module of MIPS CPU.

------------------------------------------------------------------------------*/
module mips_cpucore   (
                      input             sys_clk,
                      input             sys_rst,
                      input[5:0]        sys_int,
                      
                      input             pmem_stall_i,
                      input             pmem_ack_i,
                      input[31:0]       pmem_dat_i,
                      output[31:2]      pmem_adr_o,
                      output            pmem_cyc_o,
                      output            pmem_stb_o,

                      input             dmem_stall_i,
                      input             dmem_ack_i,
                      input[31:0]       dmem_dat_i,
                      output[31:2]      dmem_adr_o,
                      output[31:0]      dmem_dat_o,
                      output            dmem_cyc_o,
                      output            dmem_stb_o,
                      output            dmem_we_o,
                      output[3:0]       dmem_sel_o
                      );




  localparam  ADDR_RESET= 32'hBFC0_0000;
  localparam  ADDR_EXCEPT= 32'h8000_0000;

  wire[5:0]   ifield_fstage_opcode;
  wire[4:0]   ifield_fstage_d;
  wire[4:0]   ifield_fstage_t;
  wire[4:0]   ifield_fstage_s;
  wire[4:0]   ifield_fstage_shift;
  wire[5:0]   ifield_fstage_func;

  wire        alu_multdiv_ready;
  wire[31:0]  alu_quotient;
  wire[31:0]  alu_remainder;
  wire[63:0]  alu_product;
  wire[2:0]   alu_mode;
  wire        alu_mode_acompl;
  wire        alu_mode_bcompl;
  wire        alu_mode_rinv_l;
  wire        alu_mode_div;
  wire        alu_mode_mult;
  wire[31:0]  alu_a;
  wire[31:0]  alu_b;
  wire[31:0]  alu_result;

  wire[31:0]  greg_rdata_s;
  wire[31:0]  greg_rdata_t;
  wire[31:0]  greg_wdata_dt;
  wire[4:0]   greg_waddr_dt;
  wire        greg_wen_dt;

  wire[1:0]   hlreg_wen;
  wire[31:0]  hlreg_wdata_h;
  wire[31:0]  hlreg_wdata_l;
  wire[31:0]  hlreg_rdata_h;
  wire[31:0]  hlreg_rdata_l;

  wire        pcreg_wen;
  wire[31:2]  pcreg_wdata;
  wire[31:2]  pcreg_crntcmd;
  wire[31:2]  pcreg_nextcmd;

  wire        pmem_branch_ended;
  wire        fifocmd_empty;
  wire[31:0]  fifocmd_rdata;

  wire[1:0]   dmem_rreq;
  wire[1:0]   dmem_rmemdir;
  wire[4:0]   dmem_rgregbusy_queued;
  wire[4:0]   dmem_rgregbusy;
  wire[5:0]   dmem_rloadinstr;
  wire[1:0]   dmem_rbytesel;
  wire        dmem_wen;
  wire[31:2]  dmem_waddr;
  wire[31:0]  dmem_wdata;
  wire[3:0]   dmem_wbytesel;
  wire        dmem_wrw;

  wire        pl_stall_mem;
  wire        pl_stall_branch;
  wire        pl_stall_multdiv;
  wire        pl_stall_eret;
  wire        pl_cause_bd;
  wire        pl_pcpause;

  wire[31:0]  cop0_epc;
  wire        cop0_exl_set;
  wire        cop0_exl_reset;
  wire[31:0]  cop0_rdata;
  wire[4:0]   cop0_waddr;
  wire        cop0_wen;
  wire[31:0]  cop0_wdata;
  wire[3:0]   cop0_cause_excode;
  wire        cop0_cause_wen;
  wire        cop0_badvaddr_wren;
  wire        cop0_int;
  wire        cop0_exl;

  wire        exception;




  mips_pipeline
     i_pipeline       (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .pl_stall_mem(pl_stall_mem),
                      .pl_stall_branch(pl_stall_branch),
                      .pl_stall_multdiv(pl_stall_multdiv),
                      .pl_stall_eret(pl_stall_eret),
                      .exception(exception),

                      .ifield_fstage_opcode(ifield_fstage_opcode),
                      .ifield_fstage_d(ifield_fstage_d),
                      .ifield_fstage_t(ifield_fstage_t),
                      .ifield_fstage_s(ifield_fstage_s),
                      .ifield_fstage_shift(ifield_fstage_shift),
                      .ifield_fstage_func(ifield_fstage_func),

                      .pmem_cmdok(!fifocmd_empty | pmem_ack_i),
                      .pmem_cmd(fifocmd_empty ? pmem_dat_i : fifocmd_rdata),
                      .pmem_branch_ended(pmem_branch_ended),

                      .alu_multdiv_ready(alu_multdiv_ready),

                      .pl_cause_bd(pl_cause_bd),
                      .pl_pcpause(pl_pcpause)
                      );

  mips_instr_decoder  #(.ADDR_EXCEPT(ADDR_EXCEPT))
     i_instr_decoder  (
                      .pl_cause_bd(pl_cause_bd),
                      .pl_stall_mem(pl_stall_mem),
                      .pl_stall_branch(pl_stall_branch),
                      .pl_stall_multdiv(pl_stall_multdiv),
                      .pl_stall_eret(pl_stall_eret),

                      .ifield_fstage_opcode(ifield_fstage_opcode),
                      .ifield_fstage_d(ifield_fstage_d),
                      .ifield_fstage_t(ifield_fstage_t),
                      .ifield_fstage_s(ifield_fstage_s),
                      .ifield_fstage_shift(ifield_fstage_shift),
                      .ifield_fstage_func(ifield_fstage_func),

                      .alu_multdiv_ready(alu_multdiv_ready),
                      .alu_quotient(alu_quotient),
                      .alu_remainder(alu_remainder),
                      .alu_product(alu_product),
                      .alu_result(alu_result),
                      .alu_mode(alu_mode),
                      .alu_mode_acompl(alu_mode_acompl),
                      .alu_mode_bcompl(alu_mode_bcompl),
                      .alu_mode_rinv_l(alu_mode_rinv_l),
                      .alu_mode_div(alu_mode_div),
                      .alu_mode_mult(alu_mode_mult),
                      .alu_a(alu_a),
                      .alu_b(alu_b),

                      .greg_rdata_s(greg_rdata_s),
                      .greg_rdata_t(greg_rdata_t),
                      .greg_wdata_dt(greg_wdata_dt),
                      .greg_waddr_dt(greg_waddr_dt),
                      .greg_wen_dt(greg_wen_dt),

                      .hlreg_rdata_h(hlreg_rdata_h),
                      .hlreg_rdata_l(hlreg_rdata_l),
                      .hlreg_wen(hlreg_wen),
                      .hlreg_wdata_h(hlreg_wdata_h),
                      .hlreg_wdata_l(hlreg_wdata_l),

                      .pcreg_crntcmd(pcreg_crntcmd),
                      .pcreg_nextcmd(pcreg_nextcmd),
                      .pcreg_wen(pcreg_wen),
                      .pcreg_wdata(pcreg_wdata),

                      .dmem_stall_i(dmem_stall_i),
                      .dmem_ack_i(dmem_ack_i),
                      .dmem_rreq_1(dmem_rreq[1]),
                      .dmem_rmemdir_0(dmem_rmemdir[0]),
                      .dmem_rgregbusy_queued(dmem_rgregbusy_queued),
                      .dmem_rgregbusy(dmem_rgregbusy),
                      .dmem_rloadinstr(dmem_rloadinstr),
                      .dmem_rbytesel(dmem_rbytesel),
                      .dmem_rdata(dmem_dat_i),
                      .dmem_wen(dmem_wen),
                      .dmem_waddr(dmem_waddr),
                      .dmem_wdata(dmem_wdata),
                      .dmem_wbytesel(dmem_wbytesel),
                      .dmem_wrw(dmem_wrw),

                      .exception(exception),

                      .cop0_int(cop0_int),
                      .cop0_epc(cop0_epc[31:2]),
                      .cop0_exl(cop0_exl),
                      .cop0_exl_set(cop0_exl_set),
                      .cop0_exl_reset(cop0_exl_reset),
                      .cop0_rdata(cop0_rdata),
                      .cop0_waddr(cop0_waddr),
                      .cop0_wdata(cop0_wdata),
                      .cop0_wen(cop0_wen),
                      .cop0_cause_wen(cop0_cause_wen),
                      .cop0_cause_excode(cop0_cause_excode),
                      .cop0_badvaddr_wren(cop0_badvaddr_wren)
                      );

  mips_alu
     i_alu            (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .mode(alu_mode),
                      .mode_acompl(alu_mode_acompl),
                      .mode_bcompl(alu_mode_bcompl),
                      .mode_rinv_l(alu_mode_rinv_l),
                      .mode_div(alu_mode_div),
                      .mode_mult(alu_mode_mult),

                      .a(alu_a),
                      .b(alu_b),

                      .result(alu_result),
                      .multdiv_ready(alu_multdiv_ready),
                      .quotient(alu_quotient),
                      .remainder(alu_remainder),
                      .product(alu_product)
                      );

  mips_greg
     i_greg           (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .rd_addr_1(ifield_fstage_s),
                      .rd_addr_2(ifield_fstage_t),
                      .rd_data_1(greg_rdata_s),
                      .rd_data_2(greg_rdata_t),

                      .wr_addr(greg_waddr_dt),
                      .wr_en(greg_wen_dt),
                      .wr_data(greg_wdata_dt)
                      );

  mips_hlreg
     i_hlreg          (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .rd_hdata(hlreg_rdata_h),
                      .rd_ldata(hlreg_rdata_l),

                      .wr_en(hlreg_wen),
                      .wr_hdata(hlreg_wdata_h),
                      .wr_ldata(hlreg_wdata_l)
                      );

  mips_memctrl        #(.ADDR_RESET(ADDR_RESET))
     i_memctrl        (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .pl_pcpause(pl_pcpause),
                      .pcreg_wen(pcreg_wen),
                      .pcreg_wdata(pcreg_wdata),
                      .pcreg_crntcmd(pcreg_crntcmd),
                      .pcreg_nextcmd(pcreg_nextcmd),

                      .exception(exception),

                      .pmem_stall_i(pmem_stall_i),
                      .pmem_ack_i(pmem_ack_i),
                      .pmem_dat_i(pmem_dat_i),
                      .pmem_adr_o(pmem_adr_o),
                      .pmem_cyc_o(pmem_cyc_o),
                      .pmem_stb_o(pmem_stb_o),
                      .pmem_branch_ended(pmem_branch_ended),

                      .fifocmd_empty(fifocmd_empty),
                      .fifocmd_rdata(fifocmd_rdata),

                      .dmem_wen(dmem_wen & !dmem_stall_i),
                      .dmem_waddr(dmem_waddr),
                      .dmem_wdata(dmem_wdata),
                      .dmem_wbytesel(dmem_wbytesel),
                      .dmem_wrw(dmem_wrw),
                      .dmem_wloadinstr(ifield_fstage_opcode),
                      .dmem_wgregbusy(ifield_fstage_t),
                      .dmem_wbytesel_int(alu_result[1:0]),
                      .dmem_rreq(dmem_rreq),
                      .dmem_rmemdir(dmem_rmemdir),
                      .dmem_rgregbusy_queued(dmem_rgregbusy_queued),
                      .dmem_rgregbusy(dmem_rgregbusy),
                      .dmem_rloadinstr(dmem_rloadinstr),
                      .dmem_rbytesel(dmem_rbytesel),

                      .dmem_stall_i(dmem_stall_i),
                      .dmem_ack_i(dmem_ack_i),
                      .dmem_adr_o(dmem_adr_o),
                      .dmem_dat_o(dmem_dat_o),
                      .dmem_cyc_o(dmem_cyc_o),
                      .dmem_stb_o(dmem_stb_o),
                      .dmem_we_o(dmem_we_o),
                      .dmem_sel_o(dmem_sel_o)
                      );

  mips_cop0
     i_cop0           (
                      .clk(sys_clk),
                      .rst(sys_rst),

                      .rd_addr(ifield_fstage_d),
                      .rd_data(cop0_rdata),
                      .rd_epc(cop0_epc),
                      .rd_int(cop0_int),
                      .rd_status_exl(cop0_exl),

                      .wr_addr(cop0_waddr),
                      .wr_en(cop0_wen),
                      .wr_data(cop0_wdata),
                      .wr_status_exl_reset(cop0_exl_reset),
                      .wr_status_exl_set(cop0_exl_set),
                      .wr_cause_en(cop0_cause_wen),
                      .wr_cause_bd(pl_cause_bd),
                      .wr_cause_int(sys_int),
                      .wr_cause_excode(cop0_cause_excode),
                      .wr_badvaddr_en(cop0_badvaddr_wren),
                      .wr_badvaddr_data(alu_result)
                      );




endmodule
