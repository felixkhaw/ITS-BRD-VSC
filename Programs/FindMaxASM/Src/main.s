	AREA MyData, DATA, align = 2

anzahl	DCD		5
werte	DCD		-3, 17, 8, -42, 12
max		FILL	4

	AREA |.text|, CODE, READONLY, ALIGN = 2
		EXPORT main [CODE]

findMax	PROC
	PUSH	{R4-R11,LR}

	LDR		R4, =werte
	LDR		R5, =anzahl
	LDR	    R5, [R5]
	LDR	    R7, [R4]
	LDR	    R8, =max 
while_01
	CMP	    R5, #0
	BEQ		endwhile_01 
do_01
	LDR	    R6, [R4], #4 
	CMP		R6, R7
	MOVGT	R7, R6
	SUB	    R5, #1 
	B 		while_01
endwhile_01
	STR	    R7, [R8] 
	POP		{R4-R11, LR}
	BX		LR
	ENDP
main	PROC
	BL	    findMax
forever	b	forever		
	ENDP
	ALIGN
	END