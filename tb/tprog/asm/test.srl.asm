
#SRL INSTRUCTION

#RUN ALL SHIFTING MODES (0-31)
#EACH RESULT'S BIT GO THROUGH 0 AND 1

  lui $1 0xFFFF
  ori $1 0xFFFF

  lui $2 0x0000
  ori $2 0x0001
  srl $3 $1 31
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0003
  srl $3 $1 30
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0007
  srl $3 $1 29
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x000F
  srl $3 $1 28
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x001F
  srl $3 $1 27
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x003F
  srl $3 $1 26
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x007F
  srl $3 $1 25
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x00FF
  srl $3 $1 24
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x01FF
  srl $3 $1 23
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x03FF
  srl $3 $1 22
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x07FF
  srl $3 $1 21
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0FFF
  srl $3 $1 20
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x1FFF
  srl $3 $1 19
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x3FFF
  srl $3 $1 18
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x7FFF
  srl $3 $1 17
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0xFFFF
  srl $3 $1 16
  bne $3 $2 fail

  lui $2 0x0001
  ori $2 0xFFFF
  srl $3 $1 15
  bne $3 $2 fail

  lui $2 0x0003
  ori $2 0xFFFF
  srl $3 $1 14
  bne $3 $2 fail

  lui $2 0x0007
  ori $2 0xFFFF
  srl $3 $1 13
  bne $3 $2 fail

  lui $2 0x000F
  ori $2 0xFFFF
  srl $3 $1 12
  bne $3 $2 fail

  lui $2 0x001F
  ori $2 0xFFFF
  srl $3 $1 11
  bne $3 $2 fail

  lui $2 0x003F
  ori $2 0xFFFF
  srl $3 $1 10
  bne $3 $2 fail

  lui $2 0x007F
  ori $2 0xFFFF
  srl $3 $1 9
  bne $3 $2 fail

  lui $2 0x00FF
  ori $2 0xFFFF
  srl $3 $1 8
  bne $3 $2 fail

  lui $2 0x01FF
  ori $2 0xFFFF
  srl $3 $1 7
  bne $3 $2 fail

  lui $2 0x03FF
  ori $2 0xFFFF
  srl $3 $1 6
  bne $3 $2 fail

  lui $2 0x07FF
  ori $2 0xFFFF
  srl $3 $1 5
  bne $3 $2 fail

  lui $2 0x0FFF
  ori $2 0xFFFF
  srl $3 $1 4
  bne $3 $2 fail

  lui $2 0x1FFF
  ori $2 0xFFFF
  srl $3 $1 3
  bne $3 $2 fail

  lui $2 0x3FFF
  ori $2 0xFFFF
  srl $3 $1 2
  bne $3 $2 fail

  lui $2 0x7FFF
  ori $2 0xFFFF
  srl $3 $1 1
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFF
  srl $3 $1 0
  bne $3 $2 fail

  lui $1 0x7FFF
  ori $1 0xFFFF
  srl $3 $1 31
  bne $3 $0 fail

  sll $0 $0 0
