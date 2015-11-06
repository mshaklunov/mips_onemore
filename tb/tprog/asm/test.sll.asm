
#SLL INSTRUCTION

#RUN ALL SHIFTING MODES (0-31)
#EACH RESULT'S BIT GO THROUGH 0 AND 1

  lui $1 0xFFFF
  ori $1 0xFFFF

  lui $2 0x8000
  ori $2 0x0000
  sll $3 $1 31
  bne $3 $2 fail

  lui $2 0xC000
  ori $2 0x0000
  sll $3 $1 30
  bne $3 $2 fail

  lui $2 0xE000
  ori $2 0x0000
  sll $3 $1 29
  bne $3 $2 fail

  lui $2 0xF000
  ori $2 0x0000
  sll $3 $1 28
  bne $3 $2 fail

  lui $2 0xF800
  ori $2 0x0000
  sll $3 $1 27
  bne $3 $2 fail

  lui $2 0xFC00
  ori $2 0x0000
  sll $3 $1 26
  bne $3 $2 fail

  lui $2 0xFE00
  ori $2 0x0000
  sll $3 $1 25
  bne $3 $2 fail

  lui $2 0xFF00
  ori $2 0x0000
  sll $3 $1 24
  bne $3 $2 fail

  lui $2 0xFF80
  ori $2 0x0000
  sll $3 $1 23
  bne $3 $2 fail

  lui $2 0xFFC0
  ori $2 0x0000
  sll $3 $1 22
  bne $3 $2 fail

  lui $2 0xFFE0
  ori $2 0x0000
  sll $3 $1 21
  bne $3 $2 fail

  lui $2 0xFFF0
  ori $2 0x0000
  sll $3 $1 20
  bne $3 $2 fail

  lui $2 0xFFF8
  ori $2 0x0000
  sll $3 $1 19
  bne $3 $2 fail

  lui $2 0xFFFC
  ori $2 0x0000
  sll $3 $1 18
  bne $3 $2 fail

  lui $2 0xFFFE
  ori $2 0x0000
  sll $3 $1 17
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0x0000
  sll $3 $1 16
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0x8000
  sll $3 $1 15
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xC000
  sll $3 $1 14
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xE000
  sll $3 $1 13
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xF000
  sll $3 $1 12
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xF800
  sll $3 $1 11
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFC00
  sll $3 $1 10
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFE00
  sll $3 $1 9
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFF00
  sll $3 $1 8
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFF80
  sll $3 $1 7
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFC0
  sll $3 $1 6
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFE0
  sll $3 $1 5
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFF0
  sll $3 $1 4
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFF8
  sll $3 $1 3
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFC
  sll $3 $1 2
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFE
  sll $3 $1 1
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFF
  sll $3 $1 0
  bne $3 $2 fail

  lui $1 0xFFFF
  ori $1 0xFFFE
  sll $3 $1 31
  bne $3 $0 fail

  sll $0 $0 0
