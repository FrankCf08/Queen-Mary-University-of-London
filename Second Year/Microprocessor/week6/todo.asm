ORG 8000h
LJMP start

ORG 100h

KCODE0: DB 3Fh,06h,5Bh,4Fh  ; 0, 1, 2, 3
KCODE1: DB 66h,6Dh,7Dh,07h  ; 4, 5, 6, 7
KCODE2: DB 7Fh,67h,77H,7Ch  ; 8, 9, a, b
KCODE3: DB 58h,5Eh,79h,71h  ; c, d, e, f

ORG 200h

start:
MOV P3, #0
MOV P2, #0Fh
MOV P2, #0
ACALL delay

;------- Start Keypad Loop ---------

KLoop:   ;Test to see if keypad pressed

MOV P0, #0Fh
MOV A, P0
CJNE A, #0Fh, pressed
SJMP cont

;Establish which key has been pressed
pressed:
;0 = high and 1 = low
	MOV DPTR,#KCODE0;move to data pointer KCODE0
	JNB P0.0, column1;jump if P0.1 is not set: P0.0 = 0, jump to column
	MOV DPTR,#KCODE1
	JNB P0.1,column1
	MOV DPTR,#KCODE2
	JNB P0.2,column1
	MOV DPTR,#KCODE3
	JNB P0.3,column1

column1:
	MOV P0,#01Fh ; find column
	MOV A,P0
	ANL A,#0Fh
	CJNE A,#0FH,column2
	MOV R5,#0
	SJMP load_data
column2:
	MOV P0,#02Fh
	MOV A,P0
	ANL A,#0FH			;When column is found, it will make all rows become low(red)=1
	CJNE A,#0FH,column3
	MOV R5,#1
	SJMP load_data

column3:
	MOV P0,#04FH
	MOV A,P0
	ANL A,#0FH
	CJNE A,#0FH,column4
	MOV R5,#2
	SJMP load_data
column4:
	MOV R5,#3
	SJMP load_data
load_data:
	MOV A,R5
	MOVC A,@A+DPTR
	;MOV R3,2
	;MOV R2,1
	;MOV R1,0
	MOV R0,A
	
cont:
;Refresh the display
ACALL display
ACALL delay

LJMP KLoop ;return to start of loop

;------- End Keypad Loop ---------

display:
    MOV   A,R0  ; load acc with first character
    MOV   P3,A
    MOV   A,#00000001b
    MOV   P2,A
    MOV   P2, #0

    MOV   A,R1  ; load acc with second character
    MOV   P3,A
    MOV   A,#00000010b
    MOV   P2,A
    MOV   P2, #0


    MOV   A,R2  ; load acc with third character
    MOV   P3,A
    MOV   A,#00000100b
    MOV   P2,A
    MOV   P2, #0

    MOV   A,R3  ; load acc with fourth character
    MOV   P3,A
    MOV   A,#00001000b
    MOV   P2,A
    MOV   P2, #0

    RET

delay:
    MOV   A, #2   ; delay a bit for...
dly:
    DJNZ  A, dly   ; ...for debouncing
    RET

end