/*------------------------------------------------------------------------------

Purpose

  Decode instruction.

------------------------------------------------------------------------------*/
module mips_instr_decoder #(parameter ADDR_EXCEPT=32'h8000_0000)
                          (
                          input               pl_cause_bd,
                          output              pl_stall_mem,
                          output              pl_stall_branch,
                          output              pl_stall_multdiv,
                          output              pl_stall_eret,

                          input[5:0]          ifield_fstage_opcode,
                          input[4:0]          ifield_fstage_d,
                          input[4:0]          ifield_fstage_t,
                          input[4:0]          ifield_fstage_s,
                          input[4:0]          ifield_fstage_shift,
                          input[5:0]          ifield_fstage_func,

                          input               alu_multdiv_ready,
                          input[31:0]         alu_quotient,
                          input[31:0]         alu_remainder,
                          input[63:0]         alu_product,
                          input[31:0]         alu_result,
                          output reg[2:0]     alu_mode,
                          output reg          alu_mode_acompl,
                          output reg          alu_mode_bcompl,
                          output reg          alu_mode_rinv_l,
                          output reg          alu_mode_div,
                          output reg          alu_mode_mult,
                          output reg[31:0]    alu_a,
                          output reg[31:0]    alu_b,

                          input signed[31:0]  greg_rdata_s,
                          input[31:0]         greg_rdata_t,
                          output reg[31:0]    greg_wdata_dt,
                          output reg[4:0]     greg_waddr_dt,
                          output reg          greg_wen_dt,

                          input[31:0]         hlreg_rdata_h,
                          input[31:0]         hlreg_rdata_l,
                          output reg[1:0]     hlreg_wen,
                          output reg[31:0]    hlreg_wdata_h,
                          output reg[31:0]    hlreg_wdata_l,

                          input[31:2]         pcreg_crntcmd,
                          input[31:2]         pcreg_nextcmd,
                          output reg          pcreg_wen,
                          output reg[31:2]    pcreg_wdata,

                          input               dmem_stall_i,
                          input               dmem_ack_i,
                          input               dmem_rreq_1,
                          input               dmem_rmemdir_0,
                          input[4:0]          dmem_rgregbusy_queued,
                          input[4:0]          dmem_rgregbusy,
                          input[5:0]          dmem_rloadinstr,
                          input[1:0]          dmem_rbytesel,
                          input[31:0]         dmem_rdata,
                          output reg          dmem_wen,
                          output reg[31:2]    dmem_waddr,
                          output reg[31:0]    dmem_wdata,
                          output reg[3:0]     dmem_wbytesel,
                          output reg          dmem_wrw,

                          output reg          exception,

                          input               cop0_exl,
                          input               cop0_int,
                          input[31:2]         cop0_epc,
                          input[31:0]         cop0_rdata,
                          output reg[4:0]     cop0_waddr,
                          output reg          cop0_wen,
                          output reg[31:0]    cop0_wdata,
                          output reg          cop0_cause_wen,
                          output reg[3:0]     cop0_cause_excode,
                          output reg          cop0_exl_set,
                          output reg          cop0_exl_reset,
                          output reg          cop0_badvaddr_wren
                          );




  localparam  OP_RTYPE=        6'b000000;

  //PC CHANGE
  localparam  OP_BLTZ_BGEZ=    6'b000001;
  localparam  OP_J=            6'b000010;
  localparam  OP_JAL=          6'b000011;
  localparam  OP_BEQ=          6'b000100;
  localparam  OP_BNE=          6'b000101;
  localparam  OP_BLEZ=         6'b000110;
  localparam  OP_BGTZ=         6'b000111;

  localparam  FUNC_JR=         6'b001000;
  localparam  FUNC_JALR=       6'b001001;

  //MEMORY R/W
  localparam  OP_LB=           6'b100000;
  localparam  OP_LH=           6'b100001;
  localparam  OP_LW=           6'b100011;
  localparam  OP_LBU=          6'b100100;
  localparam  OP_LHU=          6'b100101;
  localparam  OP_SB=           6'b101000;
  localparam  OP_SH=           6'b101001;
  localparam  OP_SW=           6'b101011;

  //ALU
  localparam  FUNC_SLL=        6'b000000;
  localparam  FUNC_SRL=        6'b000010;
  localparam  FUNC_SRA=        6'b000011;
  localparam  FUNC_SLLV=       6'b000100;
  localparam  FUNC_SRLV=       6'b000110;
  localparam  FUNC_SRAV=       6'b000111;
  localparam  FUNC_MULT=       6'b011000;
  localparam  FUNC_MULTU=      6'b011001;
  localparam  FUNC_DIV=        6'b011010;
  localparam  FUNC_DIVU=       6'b011011;
  localparam  FUNC_MFHI=       6'b010000;
  localparam  FUNC_MTHI=       6'b010001;
  localparam  FUNC_MFLO=       6'b010010;
  localparam  FUNC_MTLO=       6'b010011;
  localparam  FUNC_ADD=        6'b100000;
  localparam  FUNC_ADDU=       6'b100001;
  localparam  FUNC_SUB=        6'b100010;
  localparam  FUNC_SUBU=       6'b100011;
  localparam  FUNC_AND=        6'b100100;
  localparam  FUNC_OR=         6'b100101;
  localparam  FUNC_XOR=        6'b100110;
  localparam  FUNC_NOR=        6'b100111;
  localparam  FUNC_SLT=        6'b101010;
  localparam  FUNC_SLTU=       6'b101011;

  localparam  OP_ADDI=         6'b001000;
  localparam  OP_ADDIU=        6'b001001;
  localparam  OP_SLTI=         6'b001010;
  localparam  OP_SLTIU=        6'b001011;
  localparam  OP_ANDI=         6'b001100;
  localparam  OP_ORI=          6'b001101;
  localparam  OP_XORI=         6'b001110;
  localparam  OP_LUI=          6'b001111;

  //COP0
  localparam  OP_COP0=         6'b010000;
  localparam  MTC0=            5'b00100;
  localparam  MFC0=            5'b00000;
  localparam  ERET=            {1'b1,19'd0,6'b011000};

  wire[25:0]  ifield_fstage_addr;
  wire[15:0]  ifield_fstage_imm;
  wire[31:0]  sign_imm;
  wire[31:0]  bta_offset;
  wire        instr_en;
  wire        instr_mem;
  wire        instr_nop;

  wire        pl_gregbusy_td;
  wire        pl_gregbusy_st;
  wire        pl_gregbusy_std;
  wire        pl_gregbusy_d;
  wire        pl_gregbusy_s;
  wire        pl_change_memdir;
  wire        pl_dmem_stall;

  localparam  ALUMODE_ADD= 3'd0;
  localparam  ALUMODE_SLL= 3'd1;
  localparam  ALUMODE_SRL= 3'd2;
  localparam  ALUMODE_SRA= 3'd3;
  localparam  ALUMODE_AND= 3'd4;
  localparam  ALUMODE_OR=  3'd5;
  localparam  ALUMODE_XOR= 3'd6;

  localparam  EXCODE_INT=  4'd0;
  localparam  EXCODE_ADEL= 4'd4;
  localparam  EXCODE_ADES= 4'd5;
  localparam  EXCODE_RI=   4'd10;
  localparam  EXCODE_OV=   4'd12;




/*------------------------------------------------------------------------------
  MAIN INSTRUCTION DECODER
------------------------------------------------------------------------------*/
  assign ifield_fstage_addr= {ifield_fstage_s,
                              ifield_fstage_t,
                              ifield_fstage_d,
                              ifield_fstage_shift,
                              ifield_fstage_func};

  assign ifield_fstage_imm=  {ifield_fstage_d,
                              ifield_fstage_shift,
                              ifield_fstage_func};

  assign sign_imm= ifield_fstage_imm[15] ? {16'hFFFF,ifield_fstage_imm} :
                   {16'h0000,ifield_fstage_imm};

  assign bta_offset= sign_imm<<2;

  assign instr_en= !pl_stall_mem & !cop0_int;

  assign instr_mem= (ifield_fstage_opcode==OP_LB |
                    ifield_fstage_opcode==OP_LH |
                    ifield_fstage_opcode==OP_LW |
                    ifield_fstage_opcode==OP_LBU |
                    ifield_fstage_opcode==OP_LHU |
                    ifield_fstage_opcode==OP_SB |
                    ifield_fstage_opcode==OP_SH |
                    ifield_fstage_opcode==OP_SW);

  assign instr_nop= ifield_fstage_opcode==OP_RTYPE &
                    ifield_fstage_func==FUNC_SLL &
                    ifield_fstage_d==5'd0;


  always @*
  begin

  alu_mode= ALUMODE_ADD;
  alu_mode_acompl= 1'b0;
  alu_mode_bcompl= 1'b0;
  alu_mode_rinv_l= 1'b0;
  alu_a= greg_rdata_s;
  alu_b= greg_rdata_t;
  alu_mode_div= 1'b0;
  alu_mode_mult= 1'b0;

  greg_waddr_dt= ifield_fstage_d;
  greg_wen_dt= 1'b0;
  greg_wdata_dt= alu_result[31:0];

  hlreg_wen= 2'b00;
  hlreg_wdata_h= alu_product[63:32];
  hlreg_wdata_l= alu_product[31:0];

  pcreg_wen= 1'b0;
  pcreg_wdata= alu_result[31:2];

  dmem_waddr= 30'd0;
  dmem_wdata= 32'd0;
  dmem_wbytesel= 4'b1111;
  dmem_wrw= 1'b0;
  dmem_wen= 1'b0;

  exception= 1'b0;

  cop0_waddr= ifield_fstage_d;
  cop0_wen= 1'b0;
  cop0_exl_set= 1'b0;
  cop0_exl_reset= 1'b0;
  cop0_wdata= greg_rdata_t;
  cop0_cause_wen= 1'b0;
  cop0_cause_excode= EXCODE_INT;
  cop0_badvaddr_wren= 1'b0;

  if(cop0_int) task_except_int(cop0_exl, pl_cause_bd, pcreg_crntcmd);
  if((!instr_en | instr_mem | instr_nop) &
     dmem_ack_i & !dmem_rmemdir_0) task_load_from_mem (dmem_rloadinstr,
                                                        dmem_rgregbusy,
                                                        dmem_rbytesel,
                                                        dmem_rdata);

  case(ifield_fstage_opcode)
  OP_RTYPE:
    begin
    case(ifield_fstage_func)
    FUNC_SLL:
      begin
      alu_mode= ALUMODE_SLL;
      alu_a[4:0]= ifield_fstage_shift;
      if(instr_en & ifield_fstage_d!=5'd0) greg_wen_dt= 1'b1;
      end
    FUNC_SRL:
      begin
      alu_mode= ALUMODE_SRL;
      alu_a[4:0]= ifield_fstage_shift;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SRA:
      begin
      alu_mode= ALUMODE_SRA;
      alu_a[4:0]= ifield_fstage_shift;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SLLV:
      begin
      alu_mode= ALUMODE_SLL;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SRLV:
      begin
      alu_mode= ALUMODE_SRL;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SRAV:
      begin
      alu_mode= ALUMODE_SRA;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_JR:
      begin
      pcreg_wdata= greg_rdata_s[31:2];
      if(instr_en) pcreg_wen= 1'b1;
      end
    FUNC_JALR:
      begin
      pcreg_wdata= greg_rdata_s[31:2];
      if(instr_en)
        begin
        pcreg_wen= 1'b1;
        greg_wen_dt= 1'b1;
        greg_wdata_dt= {pcreg_crntcmd,2'd0};
        end
      end
    FUNC_MULT:
      begin
      alu_mode_acompl= greg_rdata_s[31];
      alu_mode_bcompl= greg_rdata_t[31];
      if(instr_en)
        begin
        alu_mode_mult= 1'b1;
        if(alu_multdiv_ready) hlreg_wen= 2'b11;
        end
      end
    FUNC_MULTU:
      begin
      if(instr_en)
        begin
        alu_mode_mult= 1'b1;
        if(alu_multdiv_ready) hlreg_wen= 2'b11;
        end
      end
    FUNC_DIV:
      begin
      alu_mode_acompl= greg_rdata_s[31];
      alu_mode_bcompl= greg_rdata_t[31];
      hlreg_wdata_h= alu_remainder;
      hlreg_wdata_l= alu_quotient;
      if(instr_en)
        begin
        alu_mode_div= 1'b1;
        if(alu_multdiv_ready) hlreg_wen= 2'b11;
        end
      end
    FUNC_DIVU:
      begin
      hlreg_wdata_h= alu_remainder;
      hlreg_wdata_l= alu_quotient;
      if(instr_en)
        begin
        alu_mode_div= 1'b1;
        if(alu_multdiv_ready) hlreg_wen= 2'b11;
        end
      end
    FUNC_MFHI:
      begin
      if(instr_en)
        begin
        greg_wdata_dt= hlreg_rdata_h;
        greg_wen_dt= 1'b1;
        end
      end
    FUNC_MTHI:
      begin
      hlreg_wdata_h= greg_rdata_s;
      if(instr_en) hlreg_wen= 2'b10;
      end
    FUNC_MFLO:
      begin
      if(instr_en)
        begin
        greg_wdata_dt= hlreg_rdata_l;
        greg_wen_dt= 1'b1;
        end
      end
    FUNC_MTLO:
      begin
      hlreg_wdata_l= greg_rdata_s;
      if(instr_en) hlreg_wen= 2'b01;
      end
    FUNC_ADD:
      begin
      if(instr_en)
        begin
        if(greg_rdata_s[31]==greg_rdata_t[31] &
           alu_result[31]!=greg_rdata_s[31]) task_except_ov(cop0_exl,
                                                            pl_cause_bd,
                                                            pcreg_crntcmd);
        else greg_wen_dt= 1'b1;
        end
      end
    FUNC_ADDU:
      begin
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SUB:
      begin
      alu_mode_bcompl= 1'b1;
      if(instr_en)
        begin
        if(greg_rdata_s[31]==(~greg_rdata_t[31]) &
           alu_result[31]!=greg_rdata_s[31]) task_except_ov(cop0_exl,
                                                            pl_cause_bd,
                                                            pcreg_crntcmd);
        else greg_wen_dt= 1'b1;
        end
      end
    FUNC_SUBU:
      begin
      alu_mode_bcompl= 1'b1;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_AND:
      begin
      alu_mode= ALUMODE_AND;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_OR:
      begin
      alu_mode= ALUMODE_OR;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_XOR:
      begin
      alu_mode=ALUMODE_XOR;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_NOR:
      begin
      alu_mode=ALUMODE_OR;
      alu_mode_rinv_l= 1'b1;
      if(instr_en) greg_wen_dt= 1'b1;
      end
    FUNC_SLT:
      begin
      alu_mode_acompl= greg_rdata_s[31];
      alu_mode_bcompl= ~greg_rdata_t[31];
      if(instr_en)
        begin
        greg_wdata_dt= (greg_rdata_s[31] & !greg_rdata_t[31]) |

                       (greg_rdata_s[31] & greg_rdata_t[31] &
                       !alu_result[31] & alu_result[31:0]!=0) |

                       (!greg_rdata_s[31] & !greg_rdata_t[31] &
                       alu_result[31]) ? 32'd1 : 32'd0;
        greg_wen_dt= 1'b1;
        end
      end
    FUNC_SLTU:
      begin
      alu_mode_acompl= greg_rdata_s[31];
      alu_mode_bcompl= ~greg_rdata_t[31];
      if(instr_en)
        begin
        greg_wdata_dt= (!greg_rdata_s[31] & greg_rdata_t[31]) |

                       (greg_rdata_s[31] & greg_rdata_t[31] &
                       !alu_result[31] & alu_result[31:0]!=0) |

                       (!greg_rdata_s[31] & !greg_rdata_t[31] &
                       alu_result[31]) ? 32'd1 : 32'd0;
        greg_wen_dt= 1'b1;
        end
      end
    default: if(instr_en) task_except_ri(cop0_exl, pl_cause_bd, pcreg_crntcmd);
    endcase
    end
  OP_BLTZ_BGEZ:
    begin
    alu_a= {pcreg_nextcmd,2'd0};
    alu_b= bta_offset;
    if(instr_en &
      ((ifield_fstage_t==5'd0 & greg_rdata_s<32'sd0) |
      (ifield_fstage_t==5'd1 & greg_rdata_s>=32'sd0)))
      pcreg_wen= 1'b1;
    end
  OP_J:
    begin
    pcreg_wdata= {pcreg_crntcmd[31:28], ifield_fstage_addr};
    if(instr_en) pcreg_wen= 1'b1;
    end
  OP_JAL:
    begin
    pcreg_wdata= {pcreg_crntcmd[31:28], ifield_fstage_addr};
    if(instr_en)
      begin
      pcreg_wen= 1'b1;
      greg_waddr_dt= 5'd31;
      greg_wdata_dt= {pcreg_crntcmd,2'd0};
      greg_wen_dt= 1'b1;
      end
    end
  OP_BEQ:
    begin
    alu_a= {pcreg_nextcmd,2'd0};
    alu_b= bta_offset;
    if(instr_en & greg_rdata_s==greg_rdata_t) pcreg_wen= 1'b1;
    end
  OP_BNE:
    begin
    alu_a= {pcreg_nextcmd,2'd0};
    alu_b= bta_offset;
    if(instr_en & greg_rdata_s!=greg_rdata_t) pcreg_wen= 1'b1;
    end
  OP_BLEZ:
    begin
    alu_a= {pcreg_nextcmd,2'd0};
    alu_b= bta_offset;
    if(instr_en & greg_rdata_s<=32'sd0) pcreg_wen= 1'b1;
    end
  OP_BGTZ:
    begin
    alu_a= {pcreg_nextcmd,2'd0};
    alu_b= bta_offset;
    if(instr_en & greg_rdata_s>32'sd0) pcreg_wen= 1'b1;
    end
  OP_ADDI:
    begin
    alu_b= sign_imm;
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      if(greg_rdata_s[31]==sign_imm[31] &
         alu_result[31]!=greg_rdata_s[31]) task_except_ov(cop0_exl,
                                                          pl_cause_bd,
                                                          pcreg_crntcmd);
      else greg_wen_dt= 1'b1;
      end
    end
  OP_ADDIU:
    begin
    alu_b= sign_imm;
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wen_dt= 1'b1;
      end
    end
  OP_SLTI:
    begin
    alu_b= sign_imm;
    alu_mode_acompl= greg_rdata_s[31];
    alu_mode_bcompl= ~sign_imm[31];
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wdata_dt= (greg_rdata_s[31] & !sign_imm[31]) |

                     (greg_rdata_s[31] & sign_imm[31] &
                     !alu_result[31] & alu_result[31:0]!=32'd0) |

                     (!greg_rdata_s[31] & !sign_imm[31] &
                     alu_result[31]) ? 32'd1 : 32'd0;
      greg_wen_dt= 1'b1;
      end
    end
  OP_SLTIU:
    begin
    alu_b= sign_imm;
    alu_mode_acompl= greg_rdata_s[31];
    alu_mode_bcompl= ~sign_imm[31];
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wdata_dt= (!greg_rdata_s[31] & sign_imm[31]) |

                     (greg_rdata_s[31] & sign_imm[31] &
                     !alu_result[31] & alu_result[31:0]!=32'd0) |

                     (!greg_rdata_s[31] & !sign_imm[31] &
                     alu_result[31]) ? 32'd1 : 32'd0;
      greg_wen_dt= 1'b1;
      end
    end
  OP_ANDI:
    begin
    alu_mode= ALUMODE_AND;
    alu_b= {16'd0,ifield_fstage_imm};
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wen_dt= 1'b1;
      end
    end
  OP_ORI:
    begin
    alu_mode= ALUMODE_OR;
    alu_b= {16'd0,ifield_fstage_imm};
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wen_dt= 1'b1;
      end
    end
  OP_XORI:
    begin
    alu_mode= ALUMODE_XOR;
    alu_b= {16'd0,ifield_fstage_imm};
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wen_dt= 1'b1;
      end
    end
  OP_LUI:
    begin
    if(instr_en)
      begin
      greg_waddr_dt= ifield_fstage_t;
      greg_wdata_dt= {ifield_fstage_imm,16'd0};
      greg_wen_dt= 1'b1;
      end
    end
  OP_COP0:
    begin
    if(instr_en)
      begin
      if(ifield_fstage_addr==ERET)
        begin
        pcreg_wen= 1'b1;
        pcreg_wdata= cop0_epc[31:2];
        cop0_exl_reset= 1'b1;
        end
      else case(ifield_fstage_s)
           MTC0: cop0_wen= 1'b1;
           MFC0:
             begin
             greg_waddr_dt= ifield_fstage_t;
             greg_wen_dt= 1'b1;
             greg_wdata_dt= cop0_rdata;
             end
           default: task_except_ri(cop0_exl, pl_cause_bd, pcreg_crntcmd);
           endcase
      end
    end
  OP_LB:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    if(instr_en) dmem_wen= 1'b1;
    end
  OP_LH:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    if(instr_en)
      begin
      if(alu_result[0]) task_except_adel(cop0_exl, pl_cause_bd, pcreg_crntcmd);
      else dmem_wen= 1'b1;
      end
    end
  OP_LW:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    if(instr_en)
      begin
      if(alu_result[1:0]!=2'b00) task_except_adel(cop0_exl,
                                                  pl_cause_bd,
                                                  pcreg_crntcmd);
      else dmem_wen= 1'b1;
      end
    end
  OP_LBU:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    if(instr_en) dmem_wen= 1'b1;
    end
  OP_LHU:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    if(instr_en)
      begin
      if(alu_result[0]) task_except_adel(cop0_exl, pl_cause_bd, pcreg_crntcmd);
      else dmem_wen= 1'b1;
      end
    end
  OP_SB:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    dmem_wrw= 1'b1;
    if(instr_en)
      begin
      dmem_wen= 1'b1;
      case(alu_result[1:0])
      2'b00:
        begin
        dmem_wbytesel=4'b0001;
        dmem_wdata[7:0]=greg_rdata_t[7:0];
        end
      2'b01:
        begin
        dmem_wbytesel=4'b0010;
        dmem_wdata[15:8]=greg_rdata_t[7:0];
        end
      2'b10:
        begin
        dmem_wbytesel=4'b0100;
        dmem_wdata[23:16]=greg_rdata_t[7:0];
        end
      2'b11:
        begin
        dmem_wbytesel=4'b1000;
        dmem_wdata[31:24]=greg_rdata_t[7:0];
        end
      endcase
      end
    end
  OP_SH:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    dmem_wrw= 1'b1;
    if(instr_en)
      begin
      if(!alu_result[0])
        begin
        dmem_wen= 1'b1;
        case(alu_result[1])
        2'b0:
          begin
          dmem_wbytesel= 4'b0011;
          dmem_wdata[15:0]= greg_rdata_t[15:0];
          end
        2'b1:
          begin
          dmem_wbytesel= 4'b1100;
          dmem_wdata[31:16]= greg_rdata_t[15:0];
          end
        endcase
        end
      else task_except_ades(cop0_exl, pl_cause_bd, pcreg_crntcmd);
      end
    end
  OP_SW:
    begin
    alu_b= sign_imm;
    dmem_waddr= alu_result[31:2];
    dmem_wrw= 1'b1;
    if(instr_en)
      begin
      if(alu_result[1:0]==2'b00)
        begin
        dmem_wen= 1'b1;
        dmem_wbytesel= 4'b1111;
        dmem_wdata= greg_rdata_t;
        end
      else task_except_ades(cop0_exl, pl_cause_bd, pcreg_crntcmd);
      end
    end
  default: if(instr_en) task_except_ri(cop0_exl, pl_cause_bd, pcreg_crntcmd);
  endcase
  end


  task task_except_int(input       cop0_exl,
                       input       pl_cause_bd,
                       input[31:0] pcreg_crntcmd);
  begin
  if(!cop0_exl)
    begin
    cop0_cause_wen= 1'b1;
    cop0_waddr= 5'd14;
    cop0_wen= 1'b1;
    cop0_exl_set= 1'b1;
    if(!pl_cause_bd) cop0_wdata= {pcreg_crntcmd,2'd0};
    else cop0_wdata= {pcreg_crntcmd-30'd1,2'd0};
    end
  exception= 1'b1;
  pcreg_wen= 1'b1;
  pcreg_wdata= ADDR_EXCEPT[31:2];
  end
  endtask


  task task_except_ov(input       cop0_exl,
                      input       pl_cause_bd,
                      input[31:0] pcreg_crntcmd);
  begin
  if(!cop0_exl)
    begin
    cop0_cause_wen= 1'b1;
    cop0_cause_excode= EXCODE_OV;
    cop0_waddr= 5'd14;
    cop0_wen= 1'b1;
    cop0_exl_set= 1'b1;
    if(!pl_cause_bd) cop0_wdata= {pcreg_crntcmd,2'd0};
    else cop0_wdata= {pcreg_crntcmd-30'd1,2'd0};
    end
  exception= 1'b1;
  pcreg_wen= 1'b1;
  pcreg_wdata= ADDR_EXCEPT[31:2];
  end
  endtask


  task task_except_ri(input       cop0_exl,
                      input       pl_cause_bd,
                      input[31:0] pcreg_crntcmd);
  begin
  if(!cop0_exl)
    begin
    cop0_cause_wen= 1'b1;
    cop0_cause_excode= EXCODE_RI;
    cop0_waddr= 5'd14;
    cop0_wen= 1'b1;
    cop0_exl_set= 1'b1;
    if(!pl_cause_bd) cop0_wdata= {pcreg_crntcmd,2'd0};
    else cop0_wdata= {pcreg_crntcmd-30'd1,2'd0};
    end
  exception= 1'b1;
  pcreg_wen= 1'b1;
  pcreg_wdata= ADDR_EXCEPT[31:2];
  end
  endtask


  task task_except_adel(input       cop0_exl,
                        input       pl_cause_bd,
                        input[31:0] pcreg_crntcmd);
  begin
  if(!cop0_exl)
    begin
    cop0_cause_wen= 1'b1;
    cop0_cause_excode= EXCODE_ADEL;
    cop0_waddr= 5'd14;
    cop0_wen= 1'b1;
    cop0_exl_set= 1'b1;
    if(!pl_cause_bd) cop0_wdata= {pcreg_crntcmd,2'd0};
    else cop0_wdata= {pcreg_crntcmd-30'd1,2'd0};
    cop0_badvaddr_wren= 1'b1;
    end
  exception= 1'b1;
  pcreg_wen= 1'b1;
  pcreg_wdata= ADDR_EXCEPT[31:2];
  end
  endtask


  task task_except_ades(input       cop0_exl,
                        input       pl_cause_bd,
                        input[31:0] pcreg_crntcmd);
  begin
  if(!cop0_exl)
    begin
    cop0_cause_wen= 1'b1;
    cop0_cause_excode= EXCODE_ADES;
    cop0_waddr= 5'd14;
    cop0_wen= 1'b1;
    cop0_exl_set= 1'b1;
    if(!pl_cause_bd) cop0_wdata= {pcreg_crntcmd,2'd0};
    else cop0_wdata= {pcreg_crntcmd-30'd1,2'd0};
    cop0_badvaddr_wren= 1'b1;
    end
  exception= 1'b1;
  pcreg_wen= 1'b1;
  pcreg_wdata= ADDR_EXCEPT[31:2];
  end
  endtask


  task task_load_from_mem(input[5:0]  dmem_rloadinstr,
                          input[4:0]  dmem_rgregbusy,
                          input[1:0]  dmem_rbytesel,
                          input[31:0] dmem_rdata);
  begin
  case(dmem_rloadinstr)
  OP_LB:
    begin
    greg_waddr_dt=dmem_rgregbusy;
    greg_wen_dt=1'b1;
    case(dmem_rbytesel)
    2'b00:greg_wdata_dt={{24{dmem_rdata[7]}},dmem_rdata[7:0]};
    2'b01:greg_wdata_dt={{24{dmem_rdata[15]}},dmem_rdata[15:8]};
    2'b10:greg_wdata_dt={{24{dmem_rdata[23]}},dmem_rdata[23:16]};
    2'b11:greg_wdata_dt={{24{dmem_rdata[31]}},dmem_rdata[31:24]};
    endcase
    end
  OP_LH:
    begin
    greg_waddr_dt=dmem_rgregbusy;
    greg_wen_dt=1'b1;
    case(dmem_rbytesel[1])
    2'b0:greg_wdata_dt={{16{dmem_rdata[15]}},dmem_rdata[15:0]};
    2'b1:greg_wdata_dt={{24{dmem_rdata[31]}},dmem_rdata[31:16]};
    endcase
    end
  OP_LW:
    begin
    greg_waddr_dt=dmem_rgregbusy;
    greg_wen_dt=1'b1;
    greg_wdata_dt=dmem_rdata;
    end
  OP_LBU:
    begin
    greg_waddr_dt=dmem_rgregbusy;
    greg_wen_dt=1'b1;
    case(dmem_rbytesel)
    2'b00:greg_wdata_dt={{24{1'b0}},dmem_rdata[7:0]};
    2'b01:greg_wdata_dt={{24{1'b0}},dmem_rdata[15:8]};
    2'b10:greg_wdata_dt={{24{1'b0}},dmem_rdata[23:16]};
    2'b11:greg_wdata_dt={{24{1'b0}},dmem_rdata[31:24]};
    endcase
    end
  OP_LHU:
    begin
    greg_waddr_dt=dmem_rgregbusy;
    greg_wen_dt=1'b1;
    case(dmem_rbytesel[1])
    2'b0:greg_wdata_dt={{16{1'b0}},dmem_rdata[15:0]};
    2'b1:greg_wdata_dt={{24{1'b0}},dmem_rdata[31:16]};
    endcase
    end
  endcase
  end
  endtask


/*------------------------------------------------------------------------------
  PIPELINE STALL LOGIC
------------------------------------------------------------------------------*/
  assign pl_gregbusy_td=  ((dmem_rgregbusy!=5'd0 &
                          (dmem_rgregbusy==ifield_fstage_t |
                          dmem_rgregbusy==ifield_fstage_d)) |

                          (dmem_rgregbusy_queued!=5'd0 &
                          (dmem_rgregbusy_queued==ifield_fstage_t |
                          dmem_rgregbusy_queued==ifield_fstage_d))) &

                          ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_SLL |
                           ifield_fstage_func==FUNC_SRL |
                           ifield_fstage_func==FUNC_SRA);

  assign pl_gregbusy_std= ((dmem_rgregbusy!=5'd0 &
                          (dmem_rgregbusy==ifield_fstage_t |
                          dmem_rgregbusy==ifield_fstage_s |
                          dmem_rgregbusy==ifield_fstage_d)) |

                          (dmem_rgregbusy_queued!=5'd0 &
                          (dmem_rgregbusy_queued==ifield_fstage_t |
                          dmem_rgregbusy_queued==ifield_fstage_s |
                          dmem_rgregbusy_queued==ifield_fstage_d))) &

                          ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_SLLV |
                           ifield_fstage_func==FUNC_SRLV |
                           ifield_fstage_func==FUNC_SRAV |
                           ifield_fstage_func==FUNC_ADD |
                           ifield_fstage_func==FUNC_ADDU |
                           ifield_fstage_func==FUNC_SUB |
                           ifield_fstage_func==FUNC_SUBU |
                           ifield_fstage_func==FUNC_AND |
                           ifield_fstage_func==FUNC_OR |
                           ifield_fstage_func==FUNC_XOR |
                           ifield_fstage_func==FUNC_NOR |
                           ifield_fstage_func==FUNC_SLT |
                           ifield_fstage_func==FUNC_SLTU);

  assign pl_gregbusy_st=  ((dmem_rgregbusy!=5'd0 &
                          (dmem_rgregbusy==ifield_fstage_t |
                          dmem_rgregbusy==ifield_fstage_s)) |

                          (dmem_rgregbusy_queued!=5'd0 &
                          (dmem_rgregbusy_queued==ifield_fstage_t |
                          dmem_rgregbusy_queued==ifield_fstage_s))) &

                          ((ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_MULT |
                          ifield_fstage_func==FUNC_MULTU |
                          ifield_fstage_func==FUNC_DIV |
                          ifield_fstage_func==FUNC_DIVU)) |
                          ifield_fstage_opcode==OP_ADDI |
                          ifield_fstage_opcode==OP_ADDIU |
                          ifield_fstage_opcode==OP_SLTI |
                          ifield_fstage_opcode==OP_SLTIU |
                          ifield_fstage_opcode==OP_ANDI |
                          ifield_fstage_opcode==OP_ORI |
                          ifield_fstage_opcode==OP_XORI |
                          ifield_fstage_opcode==OP_LUI |
                          ifield_fstage_opcode==OP_BEQ |
                          ifield_fstage_opcode==OP_BNE);

  assign pl_gregbusy_d=   ((dmem_rgregbusy!=5'd0 &
                          dmem_rgregbusy==ifield_fstage_d) |

                          (dmem_rgregbusy_queued!=5'd0 &
                          dmem_rgregbusy_queued==ifield_fstage_d)) &

                          ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_MFHI |
                          ifield_fstage_func==FUNC_MFLO);

  assign pl_gregbusy_s=   ((dmem_rgregbusy!=5'd0 &
                          dmem_rgregbusy==ifield_fstage_s) |

                          (dmem_rgregbusy_queued!=5'd0 &
                          dmem_rgregbusy_queued==ifield_fstage_s)) &

                          ((ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_MTHI |
                          ifield_fstage_func==FUNC_MTLO)) |
                          ifield_fstage_opcode==OP_LB |
                          ifield_fstage_opcode==OP_LH |
                          ifield_fstage_opcode==OP_LW |
                          ifield_fstage_opcode==OP_LBU |
                          ifield_fstage_opcode==OP_LHU |
                          ifield_fstage_opcode==OP_BLTZ_BGEZ |
                          ifield_fstage_opcode==OP_BLEZ |
                          ifield_fstage_opcode==OP_BGTZ);

  assign pl_dmem_stall= instr_mem & ((dmem_stall_i) |
                        (dmem_rreq_1 & !dmem_ack_i));

  assign pl_stall_mem=  (dmem_ack_i & !instr_mem & !instr_nop &
                        (dmem_rloadinstr==OP_LB |
                        dmem_rloadinstr==OP_LH |
                        dmem_rloadinstr==OP_LW |
                        dmem_rloadinstr==OP_LBU |
                        dmem_rloadinstr==OP_LHU)) |

                        pl_gregbusy_td |
                        pl_gregbusy_std |
                        pl_gregbusy_st |
                        pl_gregbusy_d |
                        pl_gregbusy_s |
                        pl_dmem_stall;

  assign pl_stall_branch= (ifield_fstage_opcode==OP_RTYPE &
                          (ifield_fstage_func==FUNC_JR |
                          ifield_fstage_func==FUNC_JALR)) |

                          (ifield_fstage_opcode==OP_BLTZ_BGEZ &
                          ((ifield_fstage_t==5'd0 & greg_rdata_s<32'sd0) |
                          (ifield_fstage_t==5'd1 & greg_rdata_s>=32'sd0)))|

                          ifield_fstage_opcode==OP_J |
                          ifield_fstage_opcode==OP_JAL |

                          (ifield_fstage_opcode==OP_BEQ &
                          greg_rdata_s==greg_rdata_t) |
                          (ifield_fstage_opcode==OP_BNE &
                          greg_rdata_s!=greg_rdata_t) |

                          (ifield_fstage_opcode==OP_BLEZ &
                          greg_rdata_s<=32'sd0)|
                          (ifield_fstage_opcode==OP_BGTZ &
                          greg_rdata_s>32'sd0);

  assign pl_stall_eret= ifield_fstage_opcode==OP_COP0 &
                        ifield_fstage_addr==ERET;

  assign pl_stall_multdiv= ifield_fstage_opcode==OP_RTYPE &
                           (ifield_fstage_func==FUNC_MULT |
                           ifield_fstage_func==FUNC_MULTU |
                           ifield_fstage_func==FUNC_DIV |
                           ifield_fstage_func==FUNC_DIVU);




endmodule
