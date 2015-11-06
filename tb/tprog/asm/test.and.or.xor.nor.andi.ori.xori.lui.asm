
#AND OR XOR NOR ANDI ORI XORI LUI INSTRUCTIONS

#ALL INPUT COMBINATIONS IN EACH BIT(00,01,10,11)

  lui $1 0x0000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0xFFFF
  ori $4 0xFFFF

  and $5 $1 $2
  bne $5 $3 fail
  or $6 $1 $2
  bne $6 $3 fail
  xor $7 $1 $2
  bne $7 $3 fail
  nor $8 $1 $2
  bne $8 $4 fail
  andi $1 0x0000
  bne $1 $3 fail
  ori $1 0x0000
  bne $1 $3 fail
  xori $1 0x0000
  bne $1 $3 fail
  lui $1 0x0000
  bne $1 $3 fail


  lui $1 0x5555
  ori $1 0xAAAA
  lui $2 0xAAAA
  ori $2 0x5555
  lui $9 0x5555
  ori $9 0xAAAA
  lui $10 0x5555
  ori $10 0xAAAA
  lui $11 0x5555
  ori $11 0xAAAA
  lui $12 0x5555
  ori $12 0xAAAA
  lui $13 0x5555
  ori $13 0xFFFF
  lui $14 0x5555
  ori $14 0x0000

  and $5 $1 $2
  bne $5 $3 fail
  or $6 $1 $2
  bne $6 $4 fail
  xor $7 $1 $2
  bne $7 $4 fail
  nor $8 $1 $2
  bne $8 $3 fail
  andi $9 0x5555
  bne $9 $3 fail
  ori $10 0x5555
  bne $10 $13 fail
  xori $11 0x5555
  bne $11 $13 fail
  lui $12 0x5555
  bne $12 $14 fail


  lui $1 0xAAAA
  ori $1 0x5555
  lui $2 0x5555
  ori $2 0xAAAA
  lui $9 0xAAAA
  ori $9 0x5555
  lui $10 0xAAAA
  ori $10 0x5555
  lui $11 0xAAAA
  ori $11 0x5555
  lui $12 0xAAAA
  ori $12 0x5555
  lui $13 0xAAAA
  ori $13 0xFFFF
  lui $14 0xAAAA
  ori $14 0x0000

  and $5 $1 $2
  bne $5 $3 fail
  or $6 $1 $2
  bne $6 $4 fail
  xor $7 $1 $2
  bne $7 $4 fail
  nor $8 $1 $2
  bne $8 $3 fail
  andi $9 0xAAAA
  bne $9 $3 fail
  ori $10 0xAAAA
  bne $10 $13 fail
  xori $11 0xAAAA
  bne $11 $13 fail
  lui $12 0xAAAA
  bne $12 $14 fail


  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $11 0xFFFF
  ori $11 0xFFFF
  lui $12 0xFFFF
  ori $12 0xFFFF
  lui $9 0xFFFF
  ori $9 0xFFFF
  lui $13 0x0000
  ori $13 0xFFFF
  lui $14 0xFFFF
  ori $14 0x0000

  and $5 $1 $2
  bne $5 $4 fail
  or $6 $1 $2
  bne $6 $4 fail
  xor $7 $1 $2
  bne $7 $3 fail
  nor $8 $1 $2
  bne $8 $3 fail
  andi $9 0xFFFF
  bne $9 $13 fail
  ori $1 0xFFFF
  bne $1 $4 fail
  xori $11 0xFFFF
  bne $11 $14 fail
  lui $12 0xFFFF
  bne $12 $14 fail
  sll $0 $0 0
