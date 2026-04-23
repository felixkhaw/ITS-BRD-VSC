	EXTERN initITSboard
	EXPORT main 

zahl_1	DCB	4

main	
    BL initITSboard
	LDR		R0,=zahl_1
	END

	