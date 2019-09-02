ORG 0000h     ; origin at 0000 hex
; **************
; initialisation
; **************
MOV TMOD,#01; Setting up time 0, mode 1 (16- bit timer or counter)
MOV P1,#0x00; clearing the pin port PORT1 ( P1 = 00h)
; *************
; main program
; *************
start:	;128 machine cycles = 0080h (in hexadecimal)
	;FFFF - 80 = FF7F counting from 7F(TL0) to FF(TH0)
	MOV TL0,#0x7F;loading 7Fh to lowe byte
	MOV TH0,#0xFF;loading 14h to high byte
	CPL P1.0; complementing bit 0 Port1 (toggling it)
	ACALL delay; calling subroutine delay: time delay: 138.88 us
	SJMP start; short jumpt to start again
; *******************
; end of main program
; *******************

; ********************
; delay loop routines
; ********************
delay:
	SETB TR0; setting timer 0
	
again:	JNB TF0,again; monitor when Timer rolls over or reaches again 00
	CLR TR0; stoping timer 0
	CLR TF0;clearing timer 0  flag
	RET
