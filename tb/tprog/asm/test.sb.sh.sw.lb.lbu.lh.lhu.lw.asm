
#SB SH SW LB LBU LH LHU LW INSTRUCTIONS

#EACH INPUT DATA BIT GETS 1 AND 0

#1 SB LB LBU

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0055
  lui $3 0x0000
  ori $3 0x00AA
  lui $4 0x0000
  ori $4 0x0045
  lui $5 0x0000
  ori $5 0x0089
  lui $6 0xFFFF
  ori $6 0xFFAA
  lui $7 0xFFFF
  ori $7 0xFF89

  sb $2 0($1)
  sb $3 1($1)
  sb $4 2($1)
  sb $5 3($1)
  lb $8 0($1)
  lb $9 1($1)
  lb $10 2($1)
  lb $11 3($1)
  bne $8 $2 fail
  sll $0 $0 0
  bne $9 $6 fail
  sll $0 $0 0
  bne $10 $4 fail
  sll $0 $0 0
  bne $11 $7 fail
  sll $0 $0 0
  lbu $11 0($1)
  bne $11 $2 fail
  lbu $10 1($1)
  bne $10 $3 fail
  lbu $9 2($1)
  bne $9 $4 fail
  lbu $8 3($1)
  bne $8 $5 fail

#2 SH LH LHU

  lui $2 0x0000
  ori $2 0x5555
  lui $3 0x0000
  ori $3 0xAAAA
  lui $4 0xFFFF
  ori $4 0xAAAA

  sh $2 0($1)
  sh $3 2($1)
  lh $5 0($1)
  bne $5 $2 fail
  lhu $6 0($1)
  bne $6 $2 fail
  lh $7 2($1)
  bne $7 $4 fail
  lhu $8 2($1)
  bne $8 $3 fail

#3 SW LW

  lui $2 0xAAAA
  ori $2 0x5555
  lui $3 0x5555
  ori $3 0xAAAA

  sw $2 0($1)
  sw $3 4($1)
  lw $5 0($1)
  bne $5 $2 fail
  lw $6 4($1)
  bne $6 $3 fail
  sll $0 $0 0
