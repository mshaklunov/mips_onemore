
#DIV INSTRUCTION

#1 NEGATIVE A, POSITIVE B: A=0x80000_0000-0xFFFF_0000, B=0x0000_0001-0x0000_7FFF

  lui $1 0x8000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0001
  lui $3 0x0000
  ori $3 0x0000
  lui $4 0x8000
  ori $4 0x0000
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xC000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0003
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0xEAAA
  ori $4 0xAAAB
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xE000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0007
  lui $3 0xFFFF
  ori $3 0xFFFC
  lui $4 0xFB6D
  ori $4 0xB6DC
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xF000
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x000F
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0xFEEE
  ori $4 0xEEEF
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xF800
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x001F
  lui $3 0xFFFF
  ori $3 0xFFFC
  lui $4 0xFFBD
  ori $4 0xEF7C
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFC00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x003F
  lui $3 0xFFFF
  ori $3 0xFFFC
  lui $4 0xFFEF
  ori $4 0xBEFC
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFE00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x007F
  lui $3 0xFFFF
  ori $3 0xFFF0
  lui $4 0xFFFB
  ori $4 0xF7F0
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFF00
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x00FF
  lui $3 0xFFFF
  ori $3 0xFFFF
  lui $4 0xFFFE
  ori $4 0xFEFF
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFF80
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x01FF
  lui $3 0xFFFF
  ori $3 0xFFE0
  lui $4 0xFFFF
  ori $4 0xBFE0
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFC0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x03FF
  lui $3 0xFFFF
  ori $3 0xFFFC
  lui $4 0xFFFF
  ori $4 0xEFFC
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFE0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x07FF
  lui $3 0xFFFF
  ori $3 0xFC00
  lui $4 0xFFFF
  ori $4 0xFC00
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFF0
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x0FFF
  lui $3 0xFFFF
  ori $3 0xFF00
  lui $4 0xFFFF
  ori $4 0xFF00
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFF8
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x1FFF
  lui $3 0xFFFF
  ori $3 0xFFC0
  lui $4 0xFFFF
  ori $4 0xFFC0
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFFC
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x3FFF
  lui $3 0xFFFF
  ori $3 0xFFF0
  lui $4 0xFFFF
  ori $4 0xFFF0
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

  lui $1 0xFFFE
  ori $1 0x0000
  lui $2 0x0000
  ori $2 0x7FFF
  lui $3 0xFFFF
  ori $3 0xFFFC
  lui $4 0xFFFF
  ori $4 0xFFFC
  div $1 $2
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
  ori $3 0x7FFF
  lui $4 0x0000
  ori $4 0x7FFF
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
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
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#3 POSITIVE A, NEGATIVE B

  lui $1 0x7FFF
  ori $1 0xFFFF
  lui $2 0xFFFF
  ori $2 0xFFEB
  lui $3 0x0000
  ori $3 0x0001
  lui $4 0xF9E7
  ori $4 0x9E7A
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail

#4 NEGATIVE A, NEGATIVE B

  lui $1 0xD794
  ori $1 0x78AB
  lui $2 0xFFFE
  ori $2 0x1D51
  lui $3 0xFFFE
  ori $3 0x1D8C
  lui $4 0x0000
  ori $4 0x156F
  div $1 $2
  mfhi $5
  mflo $6
  bne $3 $5 fail
  sll $0 $0 0
  bne $4 $6 fail
  sll $0 $0 0
