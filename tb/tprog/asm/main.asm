
.eqv GREG_CNT $30
.eqv GREG_INT $29
.eqv PRINTPORT_HIGH 0x1001
.eqv PRINTPORT_LOW 0x0000
.eqv INTPORT_HIGH 0x1002
.eqv INTPORT_LOW 0x0000
.include "macro_print.asm"




#-------------------------------------------------------------------------------
.text

#INIT TEST COUNTER
  lui GREG_CNT 0x0000
  ori GREG_CNT 0x0000

.include "test.sll.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 1
  macro_print

.include "test.srl.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 2
  macro_print

.include "test.sra.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 3
  macro_print

.include "test.sllv.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 4
  macro_print

.include "test.srlv.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 5
  macro_print

.include "test.srav.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 6
  macro_print

.include "test.mult.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 7
  macro_print

.include "test.multu.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 8
  macro_print

.include "test.div.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 9
  macro_print

.include "test.divu.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 10
  macro_print

.include "test.mfhi.mthi.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 11
  macro_print

.include "test.mflo.mtlo.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 12
  macro_print

.include "test.add.addu.addi.addiu.asm"
  addi GREG_CNT GREG_CNT 1  #TEST COUNTER 13
  macro_print

.include "test.sub.subu.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 14
  macro_print

.include "test.and.or.xor.nor.andi.ori.xori.lui.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 15
  macro_print

.include "test.slt.sltu.slti.sltiu.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 16
  macro_print

.include "test.bltz.blez.bgtz.bgez.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 17
  macro_print

.include "test.beq.bne.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 18
  macro_print

.include "test.sb.sh.sw.lb.lbu.lh.lhu.lw.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 19
  macro_print

.include "test.pl.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 20
  macro_print

.include "test.cp0.ov_addr.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 21
  macro_print

.include "test.cp0.pl_mem.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 22
  macro_print

#NEXT TESTS IS NOT SIMULATED IN MARS
  
.include "test.cp0.int.nomars.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 23
  macro_print

.include "test.cp0.branch.nomars.asm"
  addiu GREG_CNT GREG_CNT 1  #TEST COUNTER 24
  macro_print
  
success:
  lui GREG_CNT 0xFFFF  #TEST SUCCESS END LOOP
  ori GREG_CNT 0xFFFF
  macro_print
  j success
  sll $0 $0 0

fail:
  lui GREG_CNT 0x0000  #TEST FAIL END LOOP
  ori GREG_CNT 0x0000
  macro_print
  j fail
  sll $0 $0 0




#-------------------------------------------------------------------------------
.ktext 0x80000180

.include "exc_handler.asm"
