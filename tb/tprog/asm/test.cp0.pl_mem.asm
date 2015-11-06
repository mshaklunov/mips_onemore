
#PREPARE CP0 STATUS
#ENABLE INTERRUPT, CLEAR EXL

  lui $1 0x0000
  ori $1 0xFC01
  mtc0 $1 $12

#INIT SUBTEST COUNTER

  lui $25 0x0000
  ori $25 0x0000

#1 EXCEPTION WITH PREVIOS LOAD FROM MEMORY INSTRUCTION

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0000
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0002
  lui $7 0x1000
  ori $7 0x0000
  sw $6 0($7)
  lw $5 0($7)
  add $3 $1 $2
  bne $3 $0 fail

#CHECK THAT MEM INSTR WAS EXECUTED  

  addi $4 $4 1
  addi $4 $4 1
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0030
  mfc0 $2 $13
  bne $1 $2 fail

#2 EXCEPTION WITH PREVIOS LOAD FROM MEMORY INSTRUCTION

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0000
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0002
  lui $7 0x1000
  ori $7 0x0000
  sw $6 0($7)
  lw $5 0($7)
  sll $0 $0 0
  add $3 $1 $2
  bne $3 $0 fail
  
#CHECK THAT MEM INSTR WAS EXECUTED    
  
  addi $4 $4 1
  addi $4 $4 1
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0030
  mfc0 $2 $13
  bne $1 $2 fail

#3 EXCEPTION WITH TWO PREVIOS LOAD FROM MEMORY INSTRUCTIONS

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0000
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0002
  lui $7 0x1000
  ori $7 0x0000
  sw $6 0($7)
  lw $5 0($7)
  lw $6 0($7)
  add $3 $1 $2
  bne $3 $0 fail

#CHECK THAT MEM INSTR WAS EXECUTED  
  
  addi $4 $4 1
  addi $4 $4 1
  bne $4 $5 fail
  sll $0 $0 0
  bne $4 $6 fail
  
#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0030
  mfc0 $2 $13
  bne $1 $2 fail
  
  sll $0 $0 0