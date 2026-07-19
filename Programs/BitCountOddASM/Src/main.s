	AREA MyData, DATA, align = 2

werte		DCB		5, 8, 3, 12, 7, 0
ergebnis	DCD		0

	AREA |.text|, CODE, READONLY, ALIGN = 2
		EXPORT main [CODE]


; Param: R0 -> Werte(Adresse), R1 -> Eregnis(Adresse)
; Return: R0 -> Anzahl der ungeraden Zahlen
coutOdd	PROC
	PUSH	{R4-R7,LR}		; Callee saved registers
for_01
	MOV		R4, #5
	MOV		R7, #0		; Zähler für ungerade Zahlen
until_01
	CMP		R4, #0
	BEQ		enddo_01
do_01
	LDRB	R5, [R0], #1	; Wert laden und R0 inkrementieren
	ANDS	R6, R5, #1		; Prüfen ob ungerade
	BEQ		step_01
	ADD		R7, R7, #1		; Zähler erhöhen
step_01
	SUB		R4, R4, #1	; Zähler runterzählen
	B    	until_01
enddo_01
	MOV		R0, R7			; Ergebnis in R0 speichern
	STR		R0, [R1]		; Ergebnis in Speicher schreiben
	POP		{R4-R7, LR}
	BX		LR
	ENDP
main	PROC
	LDR		R0, =werte
	LDR		R1, =ergebnis
	BL	    coutOdd
forever	b	forever		
	ENDP
	ALIGN
	END