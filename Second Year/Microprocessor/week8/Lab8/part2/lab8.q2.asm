; easy-to-use port names
RDpin equ 0xB3
WRpin equ 0xB2
A0pin equ 0xB5
A1pin equ 0xB4

ORG 8000h

start:

; set WRpin'and RDpin' high (off)
SETB RDpin ; read signal
SETB WRpin ; write signal

; set address to control register
SETB A0pin
SETB A1pin
; set control word
MOV  A,#81h
MOV  P1,A
; send write pulse to 8255
LCALL write

; set word to 0
MOV  A,#00h
MOV  P1,A

; set port to write to (A)
CLR  A0pin
CLR  A1pin
; send write pulse to 8255
LCALL write

; set port to B
;SETB A0pin
;CLR  A1pin
; send write pulse to 8255
;LCALL write

; set port to C
CLR  A0pin
SETB A1pin
; send write pulse to 8255
LCALL write

; clear registers (just to be on safe side)
MOV R0,#00h
MOV R1,#00h
MOV R2,#00h
MOV R3,#00h


;------- Start Keypad Loop ---------

; for testing purposes
MOV R0, #2

KLoop:

	MOV R0,#0X67
	MOV R1,#0X77
	MOV R2,#0X4F
	MOV R3,#0X79

ACALL Display

LJMP KLoop ;return to start of loop

;------- End Keypad Loop ---------

write:
	CLR WRpin;writing is active-low
	NOP; wait for the write to complete
	SETB WRpin; WRITING done
	NOP; let it settle
	RET

write_C:
	;set PORT C
	CLR A0pin
	SETB A1pin
	NOP; wait for the 8255 to settle
	ACALL write
	RET
read:
	MOV P1,#0FFH
	CLR A0pin
	SETB A1pin
	NOP
	CLR RDpin ;readin is active-low
	NOP
	MOV A,P1
	SETB RDpin
	NOP
	RET
	
; TODO

display:
    MOV   A,R0  ; load acc with first character
    MOV   P1,A
    CLR   A0pin
    CLR   A1pin ; select Port A
    ACALL write ; write character from acc to P1

    MOV   A,#00000001b
    MOV   P1,A
    CLR   A1pin
    SETB  A0pin ; select Port B
    ACALL write ; enable first display module
    LCALL delay

    MOV   A,#00h
    MOV   P1,A
    ACALL write ; clear displayed character before moving on



    MOV   A,R1  ; load acc with second character
    MOV   P1,A
    CLR   A0pin
    CLR   A1pin ; select Port A
    ACALL write ; write character from acc to P1

    MOV   A,#00000010b
    MOV   P1,A
    CLR   A1pin
    SETB  A0pin ; select Port B
    ACALL write ; enable second display module
    LCALL delay

    MOV   A,#00h
    MOV   P1,A
    ACALL write ; clear displayed character before moving on



    MOV   A,R2  ; load acc with third character
    MOV   P1,A
    CLR   A0pin
    CLR   A1pin ; select Port A
    ACALL write ; write character from acc to P1

    MOV   A,#00000100b
    MOV   P1,A
    CLR   A1pin
    SETB  A0pin ; select Port B
    ACALL write ; enable third display module
    LCALL delay

    MOV   A,#00h
    MOV   P1,A
    ACALL write ; clear displayed character before moving on



    MOV   A,R3  ; load acc with fourth character
    MOV   P1,A
    CLR   A0pin
    CLR   A1pin ; select Port A
    ACALL write ; write character from acc to P1

    MOV   A,#00001000b
    MOV   P1,A
    CLR   A1pin
    SETB  A0pin ; select Port B
    ACALL write ; enable fourth display module
    LCALL delay

    MOV   A,#00h
    MOV   P1,A
    ACALL write ; clear displayed character before moving on

    RET

delay:
    MOV   A, #0ffh   ; delay a bit for...
dly:
    DJNZ  acc, dly   ; ...for debouncing
    RET

END


