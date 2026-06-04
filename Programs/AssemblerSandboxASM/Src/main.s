    AREA MyData, DATA, align = 3

; GPIO_F_PIN      EQU     0x40000000 ; noch nicht der richtige Adressbereich
; data            DCW     10, 0xFF, 2		
bmask           EQU		0x1             ;0b0001
                    

    AREA |.text|, CODE, READONLY, ALIGN = 3

                EXPORT main
                EXTERN initITSboard

; Testen ob eine Zahl gerade oder ungerade ist

main            PROC
                bl    initITSboard ; HW Initialisieren
                MOV	    r0, #0x5 
                MOV     r1, #bmask
                AND	    r2, r0, r1

forever         b   forever
                ENDP
                END