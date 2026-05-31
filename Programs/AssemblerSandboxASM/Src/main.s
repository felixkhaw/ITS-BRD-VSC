    AREA MyData, DATA, align = 3

GPIO_F_PIN      EQU     0x40000000 ; noch nicht der richtige Adressbereich
data            DCW     10, 0xFF, 2		
bmask           EQU		0x2             ;0b0010
                    

    AREA |.text|, CODE, READONLY, ALIGN = 3

                EXPORT main
                EXTERN initITSboard

main            PROC
                bl    initITSboard ; HW Initialisieren
		        LDR     r0, =GPIO_F_PIN
                MOV     r1, #bmask
                LDR     r1, [r0]  

forever         b   forever
                ENDP
                END