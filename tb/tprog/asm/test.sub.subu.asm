
#SUB SUBU INSTRUCTIONS

#ALL INPUT COMBINATIONS IN EACH BIT(00,01,10,11) EXCLUDE OVERFLOW EXCEPTION

  lui $1 0x0000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000

  sub $4 $1 $2
  subu $5 $1 $2
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail

  lui $1 0x7FFF
  ori $1 0xFFFE
  lui $2 0x3FFF
  ori $2 0xFFFF
  lui $3 0x3FFF
  ori $3 0xFFFF

  sub $4 $1 $2
  subu $5 $1 $2
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0xFFFF
  ori $3 0xFFFF

  sub $4 $1 $2
  subu $5 $1 $2
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000

  sub $4 $1 $2
  subu $5 $1 $2
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail
  sll $0 $0 0
