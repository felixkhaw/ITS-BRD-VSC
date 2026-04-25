	EXTERN initITSboard
	EXPORT main 

	AREA DATA, DATA, align=2 
zahl_1	DCB	4

	AREA |.text|, CODE, READONLY, align=3
	
main	
    BL initITSboard
	LDR		R0,=zahl_1
	END
	