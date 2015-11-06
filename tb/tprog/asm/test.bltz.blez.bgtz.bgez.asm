
#BLTZ BLEZ BGTZ BGEZ INSTRUCTIONS

#1 A=0

  lui $1 0x0000
  ori $1 0x0000

  bltz $1 fail
  sll $0 $0 0
  blez $1 blg_jump1
  sll $0 $0 0
  j fail
  sll $0 $0 0
blg_ret1:
  bgtz $1 fail
  sll $0 $0 0
  bgez $1 blg_jump2
  sll $0 $0 0
  j fail

#2 A<0

blg_ret2:
  lui $1 0xFFFF
  ori $1 0xFFFF

  bltz $1 blg_jump3
  sll $0 $0 0
  j fail
  sll $0 $0 0
blg_ret3:
  blez $1 blg_jump4
  sll $0 $0 0
  j fail
blg_ret4:
  bgtz $1 fail
  sll $0 $0 0
  bgez $1 fail

#3 A>0

  lui $1 0x7FFF
  ori $1 0xFFFF

  bltz $1 fail
  sll $0 $0 0
  blez $1 fail
  sll $0 $0 0
  bgtz $1 blg_jump5
  sll $0 $0 0
  j fail
  sll $0 $0 0
blg_ret5:
  bgez $1 blg_jump6
  sll $0 $0 0
  j fail
  sll $0 $0 0

#--- blg_jump SECTION ---- BEGIN

blg_jump1: j blg_ret1
  sll $0 $0 0
blg_jump2: j blg_ret2
  sll $0 $0 0
blg_jump3: j blg_ret3
  sll $0 $0 0
blg_jump4: j blg_ret4
  sll $0 $0 0
blg_jump5: j blg_ret5
  sll $0 $0 0
blg_jump6: j blg_ret6
  sll $0 $0 0

#--- blg_jump SECTION ---- END

blg_ret6:
  sll $0 $0 0
