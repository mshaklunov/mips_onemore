
#DIVU INSTRUCTION

#1 A=0x80000_0000-0xFFFF_0000, B=0x0000_0001-0x0000_7FFF

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x8000
  ori $4 0x0000
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x4000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0003
  lui $3 0x0000
  ori $3 0x0001
  lui $4 0x1555
  ori $4 0x5555
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x2000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0007
  lui $3 0x0000
  ori $3 0x0004
  lui $4 0x0492
  ori $4 0x4924
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x1000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x000F
  lui $3 0x0000
  ori $3 0x0001
  lui $4 0x0111
  ori $4 0x1111
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0800
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x001F
  lui $3 0x0000
  ori $3 0x0004
  lui $4 0x0042
  ori $4 0x1084
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0400
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x003F
  lui $3 0x0000
  ori $3 0x0004
  lui $4 0x0010
  ori $4 0x4104
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0200
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x007F
  lui $3 0x0000
  ori $3 0x0010
  lui $4 0x0004
  ori $4 0x0810
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0100
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x00FF
  lui $3 0x0000
  ori $3 0x0001
  lui $4 0x0001
  ori $4 0x0101
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0080
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x01FF
  lui $3 0x0000
  ori $3 0x0020
  lui $4 0x0000
  ori $4 0x4020
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0040
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x03FF
  lui $3 0x0000
  ori $3 0x0004
  lui $4 0x0000
  ori $4 0x1004
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0020
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x07FF
  lui $3 0x0000
  ori $3 0x0400
  lui $4 0x0000
  ori $4 0x0400
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0010
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0FFF
  lui $3 0x0000
  ori $3 0x0100
  lui $4 0x0000
  ori $4 0x0100
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0008
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x1FFF
  lui $3 0x0000
  ori $3 0x0040
  lui $4 0x0000
  ori $4 0x0040
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0004
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x3FFF
  lui $3 0x0000
  ori $3 0x0010
  lui $4 0x0000
  ori $4 0x0010
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x0002
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x7FFF
  lui $3 0x0000
  ori $3 0x0004
  lui $4 0x0000
  ori $4 0x0004
  divu $1 $2
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
  ori $3 0x7FFF
  lui $4 0x0000
  ori $4 0x7FFF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0x8000
  lui $2 0x0001
  ori $2 0xFFFF
  lui $3 0x0001
  ori $3 0xBFFF
  lui $4 0x0000
  ori $4 0x3FFF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xC000
  lui $2 0x0003
  ori $2 0xFFFF
  lui $3 0x0003
  ori $3 0xDFFF
  lui $4 0x0000
  ori $4 0x1FFF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xE000
  lui $2 0x0007
  ori $2 0xFFFF
  lui $3 0x0007
  ori $3 0xEFFF
  lui $4 0x0000
  ori $4 0x0FFF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xF000
  lui $2 0x000F
  ori $2 0xFFFF
  lui $3 0x000F
  ori $3 0xF7FF
  lui $4 0x0000
  ori $4 0x07FF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xF800
  lui $2 0x001F
  ori $2 0xFFFF
  lui $3 0x001F
  ori $3 0xFBFF
  lui $4 0x0000
  ori $4 0x03FF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFC00
  lui $2 0x003F
  ori $2 0xFFFF
  lui $3 0x003F
  ori $3 0xFDFF
  lui $4 0x0000
  ori $4 0x01FF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFE00
  lui $2 0x007F
  ori $2 0xFFFF
  lui $3 0x007F
  ori $3 0xFEFF
  lui $4 0x0000
  ori $4 0x00FF
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFF00
  lui $2 0x00FF
  ori $2 0xFFFF
  lui $3 0x00FF
  ori $3 0xFF7F
  lui $4 0x0000
  ori $4 0x007F
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFF80
  lui $2 0x01FF
  ori $2 0xFFFF
  lui $3 0x01FF
  ori $3 0xFFBF
  lui $4 0x0000
  ori $4 0x003F
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFC0
  lui $2 0x03FF
  ori $2 0xFFFF
  lui $3 0x03FF
  ori $3 0xFFDF
  lui $4 0x0000
  ori $4 0x001F
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFE0
  lui $2 0x07FF
  ori $2 0xFFFF
  lui $3 0x07FF
  ori $3 0xFFEF
  lui $4 0x0000
  ori $4 0x000F
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFF0
  lui $2 0x0FFF
  ori $2 0xFFFF
  lui $3 0x0FFF
  ori $3 0xFFF7
  lui $4 0x0000
  ori $4 0x0007
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFF8
  lui $2 0x1FFF
  ori $2 0xFFFF
  lui $3 0x1FFF
  ori $3 0xFFFB
  lui $4 0x0000
  ori $4 0x0003
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFFC
  lui $2 0x3FFF
  ori $2 0xFFFF
  lui $3 0x3FFF
  ori $3 0xFFFD
  lui $4 0x0000
  ori $4 0x0001
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0x7FFF
  ori $1 0xFFFE
  lui $2 0x7FFF
  ori $2 0xFFFF
  lui $3 0x7FFF
  ori $3 0xFFFE
  lui $4 0x0000
  ori $4 0x0000
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#3 A MSB=0, B MSB=1

  lui $1 0x7FFF
  ori $1 0x0FFF
  lui $2 0x80FF
  ori $2 0xFFFF
  lui $3 0x7FFF
  ori $3 0x0FFF
  lui $4 0x0000
  ori $4 0x0000
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#4 A MSB=1, B MSB=1

  lui $1 0xFFFF
  ori $1 0xF0FF
  lui $2 0x80FF
  ori $2 0xFFFF
  lui $3 0x7EFF
  ori $3 0xF100
  lui $4 0x0000
  ori $4 0x0001
  divu $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail
  sll $0 $0 0
