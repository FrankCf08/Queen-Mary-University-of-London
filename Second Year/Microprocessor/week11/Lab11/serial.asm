ORG 8000H

start:
  JB P3.2, b2
  MOV A, #'Q'
  SJMP out
b2:
  JB P3.3, b3
  MOV A, #'M'
  SJMP out
b3:
  JB P3.4, b4
  MOV A, #'U'
  SJMP out
b4:
  JB P3.5, start
  MOV A, #'L'

out:
  LCALL send
  SJMP start

send:
  MOV P1,A
  RET

