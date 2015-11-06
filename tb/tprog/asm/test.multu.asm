
#MULTU INSTRUCTION

#1 A=0x80000_0000-0xFFFF_0000, B=0x0000_0000-0x0000_7FFF

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0000
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x0000
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x4000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x4000
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x2000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0003
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x6000
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0007
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7000
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0800
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x000F
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7800
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0400
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x001F
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7C00
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0200
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x003F
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7E00
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0100
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x007F
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7F00
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0080
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x00FF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7F80
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0040
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x01FF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FC0
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0020
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x03FF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FE0
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0010
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x07FF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FF0
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0008
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0FFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FF8
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0004
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x1FFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FFC
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0002
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x3FFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FFE
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0001
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x7FFF
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x7FFF
  ori $4 0x0000
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#2 A=0x7FFF_0000-0x7FFF_FFFE, B=0x0000_FFFF-0x7FFF_FFFF

  lui $1 0x7FFF
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0xFFFF
  lui $3 0x0000
  ori $3 0x7FFE
  lui $4 0x8001
  ori $4 0x0000
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
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
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#3 A=7FFF_FFFF, B=0xFFFF_FFFF

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0x7FFF
  ori $3 0xFFFE
  lui $4 0x8000
  ori $4 0x0001
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#4 A=0xFFFF_FFFF, B=0xFFFF_FFFF

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFFF
  lui $3 0xFFFF
  ori $3 0xFFFE
  lui $4 0x0000
  ori $4 0x0001
  multu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail
  sll $0 $0 0
