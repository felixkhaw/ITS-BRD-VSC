	AREA MyData, DATA, align = 2

	

	AREA |.text|, CODE, READONLY, ALIGN = 2
		EXPORT main [CODE]


; Param: R0=Bitmuster(8 Bits)
; Return: R0=Anzahl '1' in Bitmuster
bitCount	PROC
	PUSH	{R4-R6,LR}
	MOV	    R4, R0	; Kopiere Bitmuster
	MOV	    R3, #0	; Initialisiere Counter
	MOV	    R5, #8	; Initialisiere Schleifenvariable
	MOV	    R6, #1	; Bitmuster zum zählen 
while_01
	CMP		R5, #0
	BEQ		endwhile_01
do_01
	AND		R1, R4, R6
if_01
	CMP	    R1, #1
	BNE		endif_01 
then_01
	ADD	    R3, R3, #01 
endif_01
	LSR	    R4, R4, #1 
	SUB	    R5, R5, #1 
	B	    while_01
endwhile_01
	MOV	    R0, R3 
	POP		{R4-R6, LR}
	BX		LR
	ENDP
main	PROC
	MOV	    R0, #0xEE	; Binär -> '11101110'
	BL	    bitCount
forever	b	forever		
	ENDP
	ALIGN
	END