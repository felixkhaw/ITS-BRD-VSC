	AREA MyData, DATA, align = 2

bits	DCW	0x00, 0x00

muster 	EQU 2_11101110111011100011001100110011
maske 	EQU 2_00000000000000001111111111111111

	AREA |.text|, CODE, READONLY, ALIGN = 2
		EXPORT main [CODE]


; Param: R0=Bitmuster(32 Bitmuster), R1=Speicheradresse fuer Ergebnis
bitShift	PROC
	PUSH	{R4-R11,LR}
	MOV	    R4, R0
	MOV		R5, R1
	LDR	    R6, =maske
	AND	    R4, R4, R6
	STRH    R4, [R5]
	MOV	    R4, R0
	LSR	    R4, #16
	STRH    R4, [R5, #2]!
	POP		{R4-R11, LR}
	BX		LR
	ENDP
main	PROC
	LDR		R0, =muster
	LDR		R1, =bits 
	BL	    bitShift
forever	b	forever		
	ENDP
	ALIGN
	END