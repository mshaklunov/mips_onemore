
#PREPARE CP0 STATUS
#ENABLE INTERRUPT, CLEAR EXL

  lui $1 0x0000
  ori $1 0xFC01
  mtc0 $1 $12

#INIT

  lui $1 INTPORT_HIGH
  ori $1 INTPORT_LOW
  lui $4 0x0000
  ori $4 0x000A
  lui $5 0x0000
  ori $5 0x0400
  lui $6 0x0000
  ori $6 0x0001
  lui $7 0x0000
  ori $7 0x0006
  lui $8 0x0000
  ori $8 0xFC00
  lui $9 0x0000
  ori $9 0x0400
  
#GENERATE INTERRUPT

int_loop0:
  and GREG_INT GREG_INT $0
  or GREG_INT GREG_INT $6
  sw GREG_INT 0($1)
int_loop1:
  bne $4 $0 int_loop1
  addiu $4 $4 -1

#CHECK CAUSE

  mfc0 $2 $13
  sll $2 $2 1 #EXCLUDE BD BIT
  srl $2 $2 1 #EXCLUDE BD BIT
  bne $5 $2 fail
  sll $0 $0 0

#CHECK MASK BIT

  lui $10 0x0000
  ori $10 0x0001 #FLAG "NO EXCEPTION" WILL BE SET IF NO INT, NO EXCEPTION
  subu $8 $8 $9
  addiu $8 $8 1
  mtc0 $8 $12
  
#CLEAR INT

  lui $1 INTPORT_HIGH
  ori $1 INTPORT_LOW
  lui GREG_INT 0x0000
  ori GREG_INT 0x0000
  sw GREG_INT 0($1)
int_wait:
  mfc0 $2 $13
  sll $2 $2 1 #EXCLUDE BD BIT
  srl $2 $2 1 #EXCLUDE BD BIT
  bne $2 $0 int_wait

  lui $1 0x0000
  ori $1 0xFC01
  mtc0 $1 $12

#ITERATE
  beq $10 $0 fail
  lui $1 INTPORT_HIGH
  ori $1 INTPORT_LOW
  lui $4 0x0000
  ori $4 0x000A
  sll $5 $5 1
  sll $6 $6 1
  sll $9 $9 1
  addiu $7 $7 -1
  bne $7 $0 int_loop0
  sll $0 $0 0
