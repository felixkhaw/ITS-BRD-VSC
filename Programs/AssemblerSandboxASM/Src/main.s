;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

data	DCW		10, 0xFF, 2		
bmask	EQU		0x2	; 0b0010
                    
;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard

main            PROC
                bl    initITSboard ; HW Initialisieren

				MOV	    r0, #bmask		

forever         b   forever
                ENDP
                END