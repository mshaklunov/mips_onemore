
#SLLV INSTRUCTION

#RUN ALL SHIFTING MODES (0-31)
#EACH RESULT'S BIT GO THROUGH 0 AND 1

  lui $1 0xFFFF
  ori $1 0xFFFF
  lui $2 0x8000
  ori $2 0x0000
  lui $4 0x0000
  ori $4 31

sllv_loop:
  sllv $3 $1 $4
  bne $3 $2 fail
  sll $0 $0 0
  beq $4 $0 sllv_end
  addiu $4 $4 -1
  sra $2 $2 1
  j sllv_loop
  sll $0 $0 0
sllv_end:
  lui $1 0xFFFF
  ori $1 0xFFFE
  lui $4 0x0000
  ori $4 31
  sllv $3 $1 $4
  bne $3 $0 fail

  sll $0 $0 0