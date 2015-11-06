
#1 BRANCH STALL

#1.1 F-(ADD) E-(BRANCH)

  lui $1 0x0000
  ori $1 0x0003
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0003

pl_loop:
  addi $1 $1 -1
  bne $1 $0 pl_loop
  addi $2 $2 1
  bne $3 $2 fail
  sll $0 $0 0

#1.2 F-(DIV) E-(BRANCH)

  lui $1 0x0000
  ori $1 0x0004
  lui $2 0x0000
  ori $2 36
  lui $3 0x0000
  ori $3 0x0006
  lui $4 0x0000
  ori $4 1
  mtlo $2

pl_loop2:
  mflo $2
  addi $1 $1 -1
  bne $1 $4 pl_loop2
  div $2 $1
  mflo $2
  bne $3 $2 fail
  sll $0 $0 0

#1.3 F-(LW) E-(BRANCH)

  lui $1 0x1000
  ori $1 0x0008
  lui $2 0x0000
  ori $2 0x1234
  lui $3 0x0000
  ori $3 0x5678
  sw $2 -8($1)
  sw $3 -4($1)

  lui $4 0x0000
  ori $4 0x0002
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0000

pl_loop3:
  or $5 $5 $6
  addi $4 $4 -1
  addi $1 $1 -4
  bne $4 $0 pl_loop3
  lw $6 0($1)

  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $2 fail
  sll $0 $0 0


#2 MEM STALL

#2.1 F-(LW+2)(SAME REG AS LW) E-(LW+1) RW-LW

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x1000
  ori $2 0x0008
  lui $3 0x0000
  ori $3 0x0002
  lui $4 0x0000
  ori $4 0x0003
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0000
  lui $7 0x0000
  ori $7 0x0000

  sw $2 0($1)
  sw $3 4($1)
  sw $4 8($1)
  lw $5 0($1)
  lw $6 4($1)
  lw $7 0($5)
  bne $5 $2 fail
  sll $0 $0 0
  bne $6 $3 fail
  sll $0 $0 0
  bne $7 $4 fail
  sll $0 $0 0

#2.2 F-(LW+2)(SAME REG LW) E-(LW+1) RW-LW

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x1000
  ori $2 0x0008
  lui $3 0x0000
  ori $3 0x0002
  lui $4 0x0000
  ori $4 0x0003
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0000
  lui $7 0x0000
  ori $7 0x0000

  sw $2 0($1)
  sw $3 4($1)
  sw $4 8($1)
  lw $5 0($1)
  lw $6 4($1)
  lw $7 0($5)
  bne $5 $2 fail
  sll $0 $0 0
  bne $6 $3 fail
  sll $0 $0 0
  bne $7 $4 fail
  sll $0 $0 0

#2.3 F-(ADD)(SAME REG LW+1) E-(LW+1) RW-LW

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0007
  lui $3 0x0000
  ori $3 0x0002
  lui $4 0x0000
  ori $4 0x0003
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0000

  sw $3 4($1)
  sw $4 8($1)
  lw $5 4($1)
  lw $6 8($1)
  addi $6 $6 4
  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $2 fail
  sll $0 $0 0

#2.4 F-(ADD)(SAME REG LW) E-(LW+1) RW-LW (CPU_STATE=STALL_M)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0006
  lui $3 0x0000
  ori $3 0x0002
  lui $4 0x0000
  ori $4 0x0003
  lui $5 0x0000
  ori $5 0x0000
  lui $6 0x0000
  ori $6 0x0000

  sw $3 4($1)
  sw $4 8($1)
  lw $5 4($1)
  lw $6 8($1)
  addi $5 $5 4
  bne $5 $2 fail
  sll $0 $0 0
  bne $6 $4 fail
  sll $0 $0 0

#2.5 F-(ADD)(SAME REG LW) E-(SUB) RW-LW (CPU_STATE=NORMAL)

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0006
  lui $3 0x0000
  ori $3 0x0002
  lui $4 0x0000
  ori $4 0x0009
  lui $5 0x0000
  ori $5 0x0001
  lui $6 0x0000
  ori $6 0x000C

  sw $3 4($1)
  lw $2 4($1)
  subu $4 $4 $5
  addi $4 $4 4
  bne $3 $2 fail
  sll $0 $0 0
  bne $6 $4 fail
  sll $0 $0 0

#2.6 F-(DIVU)(SAME REG LW) E-(LW)

  lui $1 0x1000
  ori $1 0x0008
  lui $2 0xABCD
  ori $2 0xDCBA
  lui $3 0xF000
  ori $3 0x0000
  lui $4 0xF000
  ori $4 0x0000
  sw $2 0($1)
  lw $3 0($1)
  divu $3 $4
  mfhi $4
  bne $4 $2 fail
  sll $0 $0 0

#2.7 F-(DIVU)(SAME REG LW) E-(SLL) RW-LW (CPU_STATE=NORMAL)

  lui $1 0x1000
  ori $1 0x0008
  lui $2 0xABCD
  ori $2 0xDCBA
  lui $3 0xF000
  ori $3 0x0000
  lui $4 0xF000
  ori $4 0x0000
  sw $2 0($1)
  lw $3 0($1)
  sll $6 $0 0
  divu $3 $4
  mfhi $4
  bne $4 $2 fail
  sll $0 $0 0

#2.8 F-(DIVU)(SAME REG LW) E-(LW+1) RW-LW (CPU_STATE=STALL_M)

  lui $1 0x1000
  ori $1 0x0008
  lui $2 0xABCD
  ori $2 0xDCBA
  lui $3 0xF000
  ori $3 0x0000
  lui $4 0xF000
  ori $4 0x0000
  lui $5 0x0000
  ori $5 0x0000
  sw $1 0($1)
  sw $2 4($1)
  lw $3 4($1)
  lw $5 0($1)
  divu $3 $4
  mfhi $4
  bne $5 $1 fail
  sll $0 $0 0
  bne $4 $2 fail
  sll $0 $0 0

#2.9 F-(BRANCH)(SAME REG LW) E-LW

  lui $1 0x1000
  ori $1 0x0004
  lui $2 0x4321
  ori $2 0x1234
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0002
  lui $5 0x0000
  ori $5 0x0000
  sw $2 0($1)
  lw $3 0($1)
  beq $2 $3 pl_jump1
  addi $5 $5 1
  j fail
  addi $5 $5 1
pl_jump1:
  j pl_ret1
  addi $5 $5 1
pl_ret1:
  bne $5 $4 fail
  sll $0 $0 0

#2.10 F-(BRANCH)(SAME REG LW) E-(SLL) RW-LW (CPU_STATE=NORMAL)

  lui $1 0x1000
  ori $1 0x0004
  lui $2 0x4321
  ori $2 0x1234
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0002
  lui $5 0x0000
  ori $5 0x0000
  sw $2 0($1)
  lw $3 0($1)
  sll $6 $0 0
  beq $2 $3 pl_jump2
  addi $5 $5 1
  j fail
  sll $0 $0 0
pl_jump2:
  j pl_ret2
  addi $5 $5 1
pl_ret2:
  bne $5 $4 fail
  sll $0 $0 0

#2.11 F-(BRANCH)(SAME REG LW) E-(LW+1) RW-LW (CPU_STATE=STALL_M)

  lui $1 0x1000
  ori $1 0x0004
  lui $2 0x4321
  ori $2 0x1234
  lui $3 0x0000
  ori $3 0x0000
  lui $3 0x0000
  ori $3 0x0000
  sw $2 0($1)
  sw $1 4($1)
  lw $3 0($1)
  lw $4 4($1)
  beq $2 $3 pl_jump3
  sll $0 $0 0
  j fail
  sll $0 $0 0
pl_jump3:
  bne $1 $4 fail
  j pl_ret3
  sll $0 $0 0
pl_ret3:
  sll $0 $0 0
