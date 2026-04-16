;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Felix Knupper
;* Version            : V1.0
;* Date               : 16.04.2026
;* Description        : first steps on assembler
;*******************************************************************************

	AREA MYCODE, CODE, READONLY
	EXPORT main
main
	LDR		R1,=Ten
	LDR		R2,=Five
	ADD		[R1], R3
	ADD		[R2], R3
	END


Ten		DCD 10
Five 	DCD	5