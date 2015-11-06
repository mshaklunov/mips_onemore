
#SLT SLTU SLTI SLTIU INSTRUCTIONS

#EACH INPUT BIT GETS 1 AND 0

#1 -A=-B

  lui $1 0xFF00
  ori $1 0x0000
  lui $2 0xFF00
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0001
  lui $7 0xFFFF
  ori $7 0x8000

  slt $5 $1 $2
  bne $5 $3 fail
  sltu $6 $1 $2
  bne $6 $3 fail
  slti $8 $7 -32768
  bne $8 $3 fail
  sltiu $9 $7 -32768
  bne $9 $3 fail

#2 -A<-B

  lui $1 0xFF00
  ori $1 0x0000
  lui $2 0xFFF0
  ori $2 0x0000
  lui $7 0xFFFF
  ori $7 0x8000

  slt $5 $1 $2
  bne $5 $4 fail
  sltu $6 $1 $2
  bne $6 $4 fail
  slti $8 $7 -32767
  bne $8 $4 fail
  sltiu $9 $7 -32767
  bne $9 $4 fail

#3 -A>-B

  lui $1 0xFFFF
  ori $1 0x0000
  lui $2 0xFFF0
  ori $2 0x0000
  lui $7 0xFFFF
  ori $7 0x8050

  slt $5 $1 $2
  bne $5 $3 fail
  sltu $6 $1 $2
  bne $6 $3 fail
  slti $8 $7 -32689
  bne $8 $3 fail
  sltiu $9 $7 -32689
  bne $9 $3 fail


#4 -A<B

  lui $1 0xFFFF
  ori $1 0x0000
  lui $2 0x7FFF
  ori $2 0xFFFF
  lui $7 0xFFFF
  ori $7 0x8050

  slt $5 $1 $2
  bne $5 $4 fail
  sltu $6 $1 $2
  bne $6 $3 fail
  slti $8 $7 32689
  bne $8 $4 fail
  sltiu $9 $7 32689
  bne $9 $3 fail

#5 A>-B

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $7 0x7FFF
  ori $7 0xB050

  slt $5 $1 $2
  bne $5 $3 fail
  sltu $6 $1 $2
  bne $6 $4 fail
  slti $8 $7 -1512
  bne $8 $3 fail
  sltiu $9 $7 -1512
  bne $9 $4 fail

#6 A<B

  lui $1 0x703F
  ori $1 0xFFFF
  lui $2 0x708F
  ori $2 0xFFFF
  lui $7 0x0000
  ori $7 0x3FFF

  slt $5 $1 $2
  bne $5 $4 fail
  sltu $6 $1 $2
  bne $6 $4 fail
  slti $8 $7 0x7FFF
  bne $8 $4 fail
  sltiu $9 $7 0x7FFF
  bne $9 $4 fail

#7 A>B

  lui $1 0x7F0F
  ori $1 0xF0BF
  lui $2 0x75FF
  ori $2 0x0FFF
  lui $7 0x0000
  ori $7 0x3FFF

  slt $5 $1 $2
  bne $5 $3 fail
  sltu $6 $1 $2
  bne $6 $3 fail
  slti $8 $7 0x1FFF
  bne $8 $3 fail
  sltiu $9 $7 0x1FFF
  bne $9 $3 fail

#8 A=B

  lui $1 0x0000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $7 0x0000
  ori $7 0x0000

  slt $5 $1 $2
  bne $5 $3 fail
  sltu $6 $1 $2
  bne $6 $3 fail
  slti $8 $7 0x0000
  bne $8 $3 fail
  sltiu $9 $7 0x0000
  bne $9 $3 fail
  sll $0 $0 0
