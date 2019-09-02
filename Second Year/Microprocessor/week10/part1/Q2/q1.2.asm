ORG 0000h     ; origin at 0000 hex
; **************
; initialisation
; **************
MOV     A, #0ffh
MOV     P3, A    ; configure P3 for input
MOV     A, #00h
MOV     P1, A    ; clear P1 pins (P1 will be used for output)

MOV TMOD,#0x50 ; setting up counter 1, mode2,C/T =1
MOV TH1,#0; clearing TH1

SETB P3.5; make T1 input
start:
	MOV TL1,#0x00; setting timer 1 to low byte
	MOV TH1,#0xFF; setting timer 1 to high byte
slave:	SETB TR1; start the counter
	MOV A,TL1; getting a copy of count TL1
	MOV P1,A; displaying it on port 1
	JNB TF1,slave; keeping doing it until Timer flag (TF) = 0
	CLR TR1; stop the counter 1
	CLR TF1; make TF(Timer Flag) = 0
END

