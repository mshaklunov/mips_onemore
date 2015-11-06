.macro macro_print
  lui $1 PRINTPORT_HIGH
  ori $1 PRINTPORT_LOW
  sw GREG_CNT 0($1)
.end_macro