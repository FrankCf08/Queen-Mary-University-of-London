; easy-to-use port names
RDpin equ 0xB3
WRpin equ 0xB2
A0pin equ 0xB5
A1pin equ 0xB4

ORG 8000h; it is set up to be more than 8000h in orden to interface it using the hyperterm

LJMP start;Long jump to start label

ORG 8100h
;Data base
KCODE0: DB 06h,5Bh,4Fh,71h  ; 1, 2, 3, f 
KCODE1: DB 66h,6Dh,7Dh,79h  ; 4, 5, 6, e
KCODE2: DB 07h,7Fh,67h,5Eh  ; 7, 8, 9, d
KCODE3: DB 77H,3Fh,7Ch,58h  ; a, 0, b, c

ORG 8200h
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
SETB A0pin
CLR  A1pin
; send write pulse to 8255
LCALL write

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
MOV R7,#00h
MOV R6,#00h
MOV R5,#00h

;------- Start Keypad Loop ---------

; for testing purposes
Kloop:
	;LCALL delay1
	MOV P1, #0xF0
	LCALL write_c
	LCALL read
	CJNE A, #0xF0, pressed
	LJMP cont
;Establish which key has been pressed
pressed:;Finding the right COLUMN
	MOV R5, #0 ; row with offset 1
	JB A.0,row1

	MOV R5, #1 ; row with offset 1
	JB A.1,row1

	MOV R5, #2 ; row with offset 1
	JB A.2,row1
	
	MOV R5, #3 ; row with offset 1
	JB A.3,row1
row1:
	MOV P1, #0x1F; find column
	LCALL write_c
	LCALL read
	MOV DPTR,#KCODE0
	CJNE A, #0x10, load_data
	SJMP row2
row2:
	MOV P1,#0x2F; find column
	LCALL write_c
	LCALL read
	MOV DPTR,#KCODE1
	CJNE A,#0x20,load_data
	SJMP row3
row3:
	MOV P1,#0x4F ; find column
	LCALL write_c
	LCALL read
	MOV DPTR,#KCODE2
	CJNE A,#0x40, load_data
	SJMP row4

row4:
	MOV DPTR,#KCODE3
	SJMP load_data

load_data:

	MOV A, R5
	MOVC A,@A+DPTR
	MOV R3,2
	MOV R2,1
	MOV R1,0
	MOV R0, A
	
	LCALL display
	LCALL delay1; calling the long delay
	LJMP KLoop ;return to start of loop
;------- End Keypad Loop ---------
write:
	CLR WRpin ; writing is active−low
	NOP ; wait for the write to complete
	SETB WRpin ; writing done
	NOP ; let it settle
	RET
write_c:
; set the port to C
	CLR A0pin
	SETB A1pin
	NOP ; wait for the 8255 to settle
	ACALL write ; execute the write

	RET
read:
	MOV P1, #0FFH ; configure P1 as input
; we always read from port C
	CLR A0pin
	SETB A1pin
	NOP ; wait for the 8255 to settle
	CLR RDpin ; reading is active−low
	NOP ; wait for the 8255 to transmit the data
	MOV A,P1 ; read the data from P1 into the accumulator
	SETB RDpin ; reading done
	NOP ; wait for the 8255 to settle
	RET
cont:
;Refresh the display
	ACALL display
	ACALL delay
	LJMP KLoop ;return to start of loop
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
delay1:	; creating a long delay using loop1 and loop2
	MOV R6,#0xDF
	MOV R7,#0xDF
loop1: 	DJNZ R6,loop1
loop2: 	DJNZ R7,loop1
	RET
delay:
    MOV   A, #0xFF   ; delay a bit for...
dly:
    DJNZ  acc, dly   ; ...for debouncing
    RET
END


