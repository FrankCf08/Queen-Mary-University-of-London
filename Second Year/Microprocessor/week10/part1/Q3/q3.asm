	ORG 0000H
	SJMP main; it jumps to main label

	ORG 0013H
	SJMP turnon;Jumps to turnon label

main:
	MOV TMOD,#0x20 ;Time0, mode 2(auto reload)
	MOV TH1,#0xA4;set timer to hihg byte
	SETB IE.2 ; setting EX1 which enables external interrupt1(pin 13)
	MOV IE,#0x10 ; Enabling the interrupt

again:	SJMP again; jump here until external interrupt is detected

turnon:	CPL TR1 ; complementing TR1 by toggling it
	RETI ;return from buzzer or return from interrpt
END