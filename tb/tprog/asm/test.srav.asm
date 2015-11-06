
#SRAV INSTRUCTION

#RUN ALL SHIFTING MODES (0-31)
#EACH RESULT'S BIT GO THROUGH 0 AND 1

#1 SIGNED BIT IS ZERO

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0x7FFF
  ori $2 0xFFFF
  lui $4 0x0000
  ori $4 0
  lui $5 0x0000
  ori $5 31
  
srav_loopa:
  srav $3 $1 $4
  bne $3 $2 fail
  sll $0 $0 0
  beq $4 $5 srav_enda
  addi $4 $4 1
  srl $2 $2 1
  j srav_loopa
srav_enda:
  sll $0 $0 0
  
#2 SIGNED BIT IS ONE
  
  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x8000
  ori $2 0x0000
  lui $4 0x0000
  ori $4 0
  lui $5 0x0000
  ori $5 31
  lui $6 0x8000
  ori $6 0x0000
  
srav_loopb: 
  srav $3 $1 $4
  bne $3 $2 fail
  sll $0 $0 0
  beq $4 $5 srav_endb
  addi $4 $4 1
  srl $2 $2 1
  add $2 $2 $6
  j srav_loopb
srav_endb:
  sll $0 $0 0
  