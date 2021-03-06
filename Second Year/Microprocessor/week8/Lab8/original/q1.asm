ORG 8000h     ; origin at 0000 hex

; **************
; initialisation
; **************

MOV     A, #0ffh
MOV     P3, A    ; configure P3 for input
MOV     A, #00h
MOV     P1, A    ; clear P1 pins (P1 will be used for output)

; *************
; main program
; *************

start:
  SETB     P1.0
  LCALL    delay
  CLR      P1.0
  LCALL    delay
  LJMP     start

; *******************
; end of main program
; *******************

; ********************
; delay loop routines
; ********************

delay:
     MOV      r7, #30h
delay1:
     MOV      r6, #0FFh; When you increased the flasg goes faster
delay2:
     DJNZ     r6, delay2
     DJNZ     r7, delay1
     RET

; *******************
; end of delay loop
; *******************
