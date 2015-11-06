#CHECK STATUS

  lui $16 0x0000
  ori $16 0xFC03
  mfc0 $17 $12
  bne $16 $17 exc_fail

#CHECK INTERRUPT
  mfc0 $16 $13
  andi $16 $16 0x007C
  beq $16 $0 exc_int

  mfc0 $16 $13
  andi $16 $16 0x007C
  beq $16 $0 exc_int

#CHECK EXCEPTION IN BRANCH DELAY SLOT

  lui $16 0x8000
  ori $16 0x0000
  mfc0 $17 $13
  and $17 $17 $16
  beq $16 $17 exc_bd
  
#RETURN (EXCEPTION INSTR + 1)

  mfc0 $16 $14
  addi $16 $16 4
  mtc0 $16 $14
  eret

#RETURN (EXCEPTION INSTR + 2)

exc_bd:
  mfc0 $16 $14
  addi $16 $16 8
  mtc0 $16 $14
  eret  

#RETURN (EXCEPTION INSTR + 0)

exc_int:
  lui $16 0x0000
  ori $16 0xFC02
  mtc0 $16 $12
  eret

exc_fail:
  j exc_fail
  sll $0 $0 0
