
#MULT INSTRUCTION

#1 NEGATIVE A, POSITIVE B: A=0x80000_0000-0xFFFF_0000, B=0x0000_0000-0x0000_7FFF

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xC000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0xC000
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xE000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0003
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0xA000
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xF000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0007
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x9000
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xF800
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x000F
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8800
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFC00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x001F
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8400
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFE00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x003F
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8200
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFF00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x007F
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8100
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFF80
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x00FF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8080
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFC0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x01FF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8040
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFE0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x03FF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8020
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFF0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x07FF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8010
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFF8
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0FFF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8008
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFFC
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x1FFF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8004
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFFE
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x3FFF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8002
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFFF
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x7FFF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8001
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#2 POSITIVE A, POSITIVE B: A=0x7FFF_0000-0x7FFF_FFFE, B=0x0000_FFFF-0x7FFF_FFFF

  lui $1 0x7FFF
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x7FFE
  lui $4 0x8001
  ori $4 0x0000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0x8000
  lui $2 0x0001
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x8000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xC000
  lui $2 0x0003
  ori $2 0xFFFF
  lui $3 0x0001
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x4000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xE000
  lui $2 0x0007
  ori $2 0xFFFF
  lui $3 0x0003
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x2000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xF000
  lui $2 0x000F
  ori $2 0xFFFF
  lui $3 0x0007
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x1000
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xF800
  lui $2 0x001F
  ori $2 0xFFFF
  lui $3 0x000F
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0800
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFC00
  lui $2 0x003F
  ori $2 0xFFFF
  lui $3 0x001F
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0400
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFE00
  lui $2 0x007F
  ori $2 0xFFFF
  lui $3 0x003F
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0200
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFF00
  lui $2 0x00FF
  ori $2 0xFFFF
  lui $3 0x007F
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0100
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFF80
  lui $2 0x01FF
  ori $2 0xFFFF
  lui $3 0x00FF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0080
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFC0
  lui $2 0x03FF
  ori $2 0xFFFF
  lui $3 0x01FF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0040
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFE0
  lui $2 0x07FF
  ori $2 0xFFFF
  lui $3 0x03FF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0020
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFF0
  lui $2 0x0FFF
  ori $2 0xFFFF
  lui $3 0x07FF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0010
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFF8
  lui $2 0x1FFF
  ori $2 0xFFFF
  lui $3 0x0FFF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0008
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFFC
  lui $2 0x3FFF
  ori $2 0xFFFF
  lui $3 0x1FFF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0004
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFFE
  lui $2 0x7FFF
  ori $2 0xFFFF
  lui $3 0x3FFF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0002
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#3 POSITIVE A, NEGATIVE B

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0x8000
  ori $4 0x0001
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#4 NEGATIVE A, NEGATIVE B

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0001
  mult $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail
  sll $0 $0 0
