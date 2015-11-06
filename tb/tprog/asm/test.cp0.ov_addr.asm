
#PREPARE CP0 STATUS
#ENABLE INTERRUPT, CLEAR EXL

  lui $1 0x0000
  ori $1 0xFC01
  mtc0 $1 $12

#INIT SUBTEST COUNTER

  lui $25 0x0000
  ori $25 0x0000

#1 OVERFLOW EXCEPTION ADD

#1.1 NUMBERS BOTH NEGATIVE

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  add $3 $1 $2
  bne $3 $0 fail

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

#1.2 NUMBERS BOTH POSITIVE

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0x0000
  ori $2 0x000F
  lui $3 0x0000
  ori $3 0x0000
  add $3 $1 $2
  bne $3 $0 fail

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

  addi $25 $25 1 #SUBTEST COUNTER 1

#2 ADDRESS EXCEPTION LH

#2.1 ADDRESS IS WRONG ALIGNED (LSB=1)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $2 0($1)
  lh $3 1($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0001
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

#2.2 ADDRESS IS WRONG ALIGNED (LSB=3)

  lui $1 0x1000
  ori $1 0x0000
  lh $3 3($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR
  lui $4 0x1000
  ori $4 0x0003
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

  addi $25 $25 1 #SUBTEST COUNTER 2

#3 OVERFLOW EXCEPTION ADDI

#3.1 NUMBERS BOTH NEGATIVE

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  addi $3 $1 -1
  bne $3 $0 fail

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

#3.2 NUMBERS BOTH POSITIVE

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0x0000
  ori $3 0x0000
  addi $3 $1 0x000F
  bne $3 $0 fail

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

  addi $25 $25 1 #SUBTEST COUNTER 3

#4 ADDRESS EXCEPTION LW

#4.1 ADDRESS IS WRONG ALIGNED (LSB=1)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $2 0($1)
  lw $3 1($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0001
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

#4.2 ADDRESS IS WRONG ALIGNED (LSB=2)

  lui $1 0x1000
  ori $1 0x0000
  lw $3 2($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR
  lui $4 0x1000
  ori $4 0x0002
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

#4.3 ADDRESS IS WRONG ALIGNED (LSB=3)

  lui $1 0x1000
  ori $1 0x0000
  lw $3 3($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0003
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

  addi $25 $25 1 #SUBTEST COUNTER 4

#5 OVERFLOW EXCEPTION SUB

#5.1 EQUAL TO ADDITION WITH BOTH NEGATIVE NUMBERS

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0x0000
  ori $3 0x0000
  sub $3 $1 $2
  bne $3 $0 fail

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

#5.2 EQUAL TO ADDITION WITH BOTH POSITIVE NUMBERS

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0xF000
  ori $2 0x000F
  lui $3 0x0000
  ori $3 0x0000
  sub $3 $1 $2
  bne $3 $0 fail

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

  addi $25 $25 1 #SUBTEST COUNTER 5

#6 ADDRESS EXCEPTION SH

#6.1 ADDRESS IS WRONG ALIGNED (LSB=1)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $3 0($1)
  sh $2 1($1)

#CHECK THAT MEM WAS NOT WRITED BY WRONG INSTR

  lui $1 0x1000
  ori $1 0x0000
  lw $3 0($1)
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0001
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0014
  mfc0 $2 $13
  bne $1 $2 fail

#6.2 ADDRESS IS WRONG ALIGNED (LSB=3)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $3 0($1)
  sh $2 3($1)

#CHECK THAT MEM WAS NOT WRITED BY WRONG INSTR

  lui $1 0x1000
  ori $1 0x0000
  lw $3 0($1)
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0003
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0014
  mfc0 $2 $13
  bne $1 $2 fail

  addi $25 $25 1 #SUBTEST COUNTER 6

#7 ADDRESS EXCEPTION LHU

#7.1 ADDRESS IS WRONG ALIGNED (LSB=1)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $2 0($1)
  lhu $3 1($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0001
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

#7.2 ADDRESS IS WRONG ALIGNED (LSB=3)

  lui $1 0x1000
  ori $1 0x0000
  lhu $3 3($1)
  sll $0 $0 0
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0003
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0010
  mfc0 $2 $13
  bne $1 $2 fail

  addi $25 $25 1 #SUBTEST COUNTER 7

#8 ADDRESS EXCEPTION SW

#8.1 ADDRESS IS WRONG ALIGNED (LSB=1)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $3 0($1)
  sw $2 1($1)
  lui $1 0x1000
  ori $1 0x0000
  lw $3 0($1)
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0001
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0014
  mfc0 $2 $13
  bne $1 $2 fail

#8.2 ADDRESS IS WRONG ALIGNED (LSB=2)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $3 0($1)
  sw $2 2($1)

#CHECK THAT MEM WAS NOT WRITED BY WRONG INSTR

  lui $1 0x1000
  ori $1 0x0000
  lw $3 0($1)
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0002
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0014
  mfc0 $2 $13
  bne $1 $2 fail

#8.3 ADDRESS IS WRONG ALIGNED (LSB=3)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  sw $3 0($1)
  sw $2 3($1)

#CHECK THAT MEM WAS NOT WRITED BY WRONG INSTR

  lui $1 0x1000
  ori $1 0x0000
  lw $3 0($1)
  bne $3 $0 fail

#CHECK BADVADDR

  lui $4 0x1000
  ori $4 0x0003
  mfc0 $5 $8
  bne $4 $5 fail

#CHECK STATUS

  lui $1 0x0000
  ori $1 0xFC01
  mfc0 $2 $12
  bne $1 $2 fail

#CHECK CAUSE

  lui $1 0x0000
  ori $1 0x0014
  mfc0 $2 $13
  bne $1 $2 fail

  addi $25 $25 1 #SUBTEST COUNTER 8

#MEM THEN EXCEPTION

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
  addi $4 $4 1
  addi $4 $4 1
  bne $3 $0 fail
  sll $0 $0 0
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

#MEM THEN EXCEPTION

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
  addi $4 $4 1
  addi $4 $4 1
  bne $3 $0 fail
  sll $0 $0 0
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

#MEM THEN EXCEPTION

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
  addi $4 $4 1
  addi $4 $4 1
  bne $3 $0 fail
  sll $0 $0 0
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
  
  sll $0 $0 0