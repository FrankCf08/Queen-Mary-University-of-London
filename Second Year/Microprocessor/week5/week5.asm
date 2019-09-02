ORG 0
MOV DPTR,#300H ;load look\u2212up table address
MOV A,#0FFH ;A=FF

MOV P1,A ;configure P1 as input port
BACK: MOV A,P1 ;get x from port 1

MOVC A,@A+DPTR ;Which value do you obtain here?

MOV P2,A ;issue it to port 2

SJMP BACK ;keep doing it


ORG 300H
XSQR_TABLE:

DB 0,1,4,9,16,25,36,49,64,81