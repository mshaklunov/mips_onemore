
#SRA INSTRUCTION

#RUN ALL SHIFTING MODES (0-31) WITH DIFFERENT SIGNED BIT OF THE SHIFTED NUMBER
#EACH RESULT'S BIT GO THROUGH 0 AND 1

#1 SIGNED BIT IS ZERO

  lui $1 0x7FFF
  ori $1 0xFFFF

  lui $2 0x7FFF
  ori $2 0xFFFF
  sra $3 $1 0
  bne $3 $2 fail

  lui $2 0x3FFF
  ori $2 0xFFFF
  sra $3 $1 1
  bne $3 $2 fail

  lui $2 0x1FFF
  ori $2 0xFFFF
  sra $3 $1 2
  bne $3 $2 fail

  lui $2 0x0FFF
  ori $2 0xFFFF
  sra $3 $1 3
  bne $3 $2 fail

  lui $2 0x07FF
  ori $2 0xFFFF
  sra $3 $1 4
  bne $3 $2 fail

  lui $2 0x03FF
  ori $2 0xFFFF
  sra $3 $1 5
  bne $3 $2 fail

  lui $2 0x01FF
  ori $2 0xFFFF
  sra $3 $1 6
  bne $3 $2 fail

  lui $2 0x00FF
  ori $2 0xFFFF
  sra $3 $1 7
  bne $3 $2 fail

  lui $2 0x007F
  ori $2 0xFFFF
  sra $3 $1 8
  bne $3 $2 fail

  lui $2 0x003F
  ori $2 0xFFFF
  sra $3 $1 9
  bne $3 $2 fail

  lui $2 0x001F
  ori $2 0xFFFF
  sra $3 $1 10
  bne $3 $2 fail

  lui $2 0x000F
  ori $2 0xFFFF
  sra $3 $1 11
  bne $3 $2 fail

  lui $2 0x0007
  ori $2 0xFFFF
  sra $3 $1 12
  bne $3 $2 fail

  lui $2 0x0003
  ori $2 0xFFFF
  sra $3 $1 13
  bne $3 $2 fail

  lui $2 0x0001
  ori $2 0xFFFF
  sra $3 $1 14
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0xFFFF
  sra $3 $1 15
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x7FFF
  sra $3 $1 16
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x3FFF
  sra $3 $1 17
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x1FFF
  sra $3 $1 18
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0FFF
  sra $3 $1 19
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x07FF
  sra $3 $1 20
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x03FF
  sra $3 $1 21
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x01FF
  sra $3 $1 22
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x00FF
  sra $3 $1 23
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x007F
  sra $3 $1 24
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x003F
  sra $3 $1 25
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x001F
  sra $3 $1 26
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x000F
  sra $3 $1 27
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0007
  sra $3 $1 28
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0003
  sra $3 $1 29
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0001
  sra $3 $1 30
  bne $3 $2 fail

  lui $2 0x0000
  ori $2 0x0000
  sra $3 $1 31
  bne $3 $2 fail

#2 SIGNED BIT IS ONE

  lui $1 0x8000
  ori $1 0x0000

  lui $2 0x8000
  ori $2 0x0000
  sra $3 $1 0
  bne $3 $2 fail

  lui $2 0xC000
  ori $2 0x0000
  sra $3 $1 1
  bne $3 $2 fail

  lui $2 0xE000
  ori $2 0x0000
  sra $3 $1 2
  bne $3 $2 fail

  lui $2 0xF000
  ori $2 0x0000
  sra $3 $1 3
  bne $3 $2 fail

  lui $2 0xF800
  ori $2 0x0000
  sra $3 $1 4
  bne $3 $2 fail

  lui $2 0xFC00
  ori $2 0x0000
  sra $3 $1 5
  bne $3 $2 fail

  lui $2 0xFE00
  ori $2 0x0000
  sra $3 $1 6
  bne $3 $2 fail

  lui $2 0xFF00
  ori $2 0x0000
  sra $3 $1 7
  bne $3 $2 fail

  lui $2 0xFF80
  ori $2 0x0000
  sra $3 $1 8
  bne $3 $2 fail

  lui $2 0xFFC0
  ori $2 0x0000
  sra $3 $1 9
  bne $3 $2 fail

  lui $2 0xFFE0
  ori $2 0x0000
  sra $3 $1 10
  bne $3 $2 fail

  lui $2 0xFFF0
  ori $2 0x0000
  sra $3 $1 11
  bne $3 $2 fail

  lui $2 0xFFF8
  ori $2 0x0000
  sra $3 $1 12
  bne $3 $2 fail

  lui $2 0xFFFC
  ori $2 0x0000
  sra $3 $1 13
  bne $3 $2 fail

  lui $2 0xFFFE
  ori $2 0x0000
  sra $3 $1 14
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0x0000
  sra $3 $1 15
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0x8000
  sra $3 $1 16
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xC000
  sra $3 $1 17
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xE000
  sra $3 $1 18
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xF000
  sra $3 $1 19
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xF800
  sra $3 $1 20
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFC00
  sra $3 $1 21
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFE00
  sra $3 $1 22
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFF00
  sra $3 $1 23
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFF80
  sra $3 $1 24
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFC0
  sra $3 $1 25
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFE0
  sra $3 $1 26
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFF0
  sra $3 $1 27
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFF8
  sra $3 $1 28
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFC
  sra $3 $1 29
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFE
  sra $3 $1 30
  bne $3 $2 fail

  lui $2 0xFFFF
  ori $2 0xFFFF
  sra $3 $1 31
  bne $3 $2 fail

  sll $0 $0 0
