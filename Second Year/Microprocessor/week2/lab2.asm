ORG 0H
START: 
	MOV A,#0H; declaring A starts values 0 (A=0h)

	MOV R4,P0;
	MOV R5,P1
	MOV R6, P2
	MOV R7, P3

	CLR A; clearing A

	MOV A,P0
	ADD A,P2
	MOV R0,A

	CLR A

	MOV A,P1
	ADDC A,P3
	MOV R1, A

	CLR A
	ADDC A,#0H
	MOV R2,A

	SJMP START ; keep doing this for ever