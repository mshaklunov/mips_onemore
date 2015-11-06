
#MFHI MTHI INSTRUCTIONS

#EACH BIT OF INPUT/OUTPUT GO THROUGH 0 AND 1

  lui $2 0x0000
  ori $2 0x0000

  lui $1 0xAAAA
  ori $1 0x5555
  mthi $1
  mfhi $2
  bne $1 $2 fail

  lui $1 0x5555
  ori $1 0xAAAA
  mthi $1
  mfhi $2
  bne $1 $2 fail
  sll $0 $0 0
