RDpin equ 0xB3
WRpin equ 0xB2
A0pin equ 0xB5
A1pin equ 0xB4

ORG 8000h

; set WRpin'and RDpin' high (off)
SETB RDpin ; read signal
SETB WRpin ; write signal

; set address to control register
SETB A0pin
SETB A1pin
; set control word
MOV  P1,#81H
LCALL write

; set port to C
CLR  A0pin
SETB A1pin

repeat:
    MOV P1,#0F0H
    LCALL write
    LCALL read
    LCALL delay
    SJMP repeat

write:
    CLR  WRpin
    NOP
    SETB WRpin
    NOP
    RET

read:
    MOV P1, #0FFh
    CLR RDpin
    NOP
    MOV A, P1
    SETB RDpin
    RET

delay:
    MOV   A, #0ffh
dly:
    DJNZ  A, dly
    RET

END
