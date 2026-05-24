; Pseudocode: https://github.com/felixkhaw/Primzahlen

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 4 Byte Arrays mit Werten
zahlen              FILL    1000, 0x01
                    DCB     0x00 // Terminierungsvariable

; dem Programm verfügbar machen
                    EXPORT zahlen


;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard

; Start der main Schleife des Programmes
; r0 -> Zeiger, r1 -> Counter, r2 -> Wert, r3 -> Primzahl
main            PROC
                bl    initITSboard                 ; HW Initialisieren
                ldrb  r0,=zahlen    ; Start Adresse von Zahlen
                ldrb  r2, [r0]
                mov   r1, 0x00      ; Initialisieren des Counters

for-zahlen      mov   r0, 0x00      
until-zahlen    cpm   r2, 0x00   
do-zahlen       
                // If Struktur aufrufen 
step-zahlen     add r1,r1, #1
enddo-zahlen


forever         b   forever
                ENDP
                END