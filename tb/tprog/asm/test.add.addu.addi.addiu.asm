
#ADD ADDU ADDI ADDIU INSTRUCTIONS

#ALL INPUT COMBINATIONS IN EACH BIT(00,01,10,11) EXCLUDE OVERFLOW EXCEPTION

  lui $1 0x0000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000

  add $4 $1 $2
  addu $5 $1 $2
  addi $6 $1 0x0000
  addiu $7 $1 0x0000
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $3 fail
  sll $0 $0 0
  bne $7 $3 fail

  lui $1 0x5555
  ori $1 0xAAAA
  lui $2 0xAAAA
  ori $2 0x5555
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $8 0x5555
  ori $8 0xFFFF

  add $4 $1 $2
  addu $5 $1 $2
  addi $6 $1 0x5555
  addiu $7 $1 0x5555
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $8 fail
  sll $0 $0 0
  bne $7 $8 fail

  lui $1 0xAAAA
  ori $1 0x5555
  lui $2 0x5555
  ori $2 0xAAAA
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $8 0xAAA9
  ori $8 0xFFFF

  add $4 $1 $2
  addu $5 $1 $2
  addi $6 $1 -21846
  addiu $7 $1 -21846
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $8 fail
  sll $0 $0 0
  bne $7 $8 fail

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0xFFFF
  ori $3 0xFFFE

  add $4 $1 $2
  addu $5 $1 $2
  addi $6 $1 -1
  addiu $7 $1 -1
  bne $4 $3 fail
  sll $0 $0 0
  bne $5 $3 fail
  sll $0 $0 0
  bne $6 $3 fail
  sll $0 $0 0
  bne $7 $3 fail
