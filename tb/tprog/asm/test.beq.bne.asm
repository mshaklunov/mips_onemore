
#BEQ BNE INSTRUCTIONS

#EACH INPUT BIT GETS 1 AND 0

#1

  lui $1 0x0000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000

  bne $1 $2 fail
  sll $0 $0 0
  beq $1 $2 ben_jump1
  sll $0 $0 0
  j fail
ben_jump1:

#2

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF

  bne $1 $2 fail
  sll $0 $0 0
  beq $1 $2 ben_jump2
  sll $0 $0 0
  j fail
ben_jump2:

#3

  lui $1 0xAAAA
  ori $1 0x5555
  lui $2 0xAAAA
  ori $2 0x5556

  beq $1 $2 fail
  sll $0 $0 0
  bne $1 $2 ben_jump3
  sll $0 $0 0
  j fail
ben_jump3:

#4

  lui $1 0x5555
  ori $1 0xAAAA
  lui $2 0x5655
  ori $2 0xAAAA

  beq $1 $2 fail
  sll $0 $0 0
  bne $1 $2 ben_jump4
  sll $0 $0 0
  j fail
ben_jump4:
  sll $0 $0 0
