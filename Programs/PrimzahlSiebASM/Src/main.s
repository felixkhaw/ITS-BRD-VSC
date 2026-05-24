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
;   r0 -> Zeiger zahlen
;   r1 -> Counter zahlen
;   r2 -> Wert zahlen
;   r3 -> Primzahl
;   r4 -> Zeiger vielfaches
;   r5 -> Counter vielfaches
;   r6 -> Wert vielfaches
main            PROC
                bl    initITSboard                 ; HW Initialisieren
                ldrb  r0,=zahlen    ; Start Adresse von Zahlen
                ldrb  r4,=zahlen    ; Start Adresse von Zahlen
                ldrb  r2, [r0]
                mov   r1, 0x00      ; Initialisieren des Counters

for-zahlen      mov   r0, 0x00      
until-zahlen    cpm   r2, 0x00   
do-zahlen       
                // If Struktur aufrufen 
step-zahlen     add r1,r1, #1
enddo-zahlen

for-vielfaches      mov   r5, 0x00      
until-vielfaches    cpm   r4, 0x00  
do-vielfaches       
                // Setzte bei Adresse x in Zahlen Wert auf 0x00
step-vielfaches     add r4,r4, #1
enddo-vielfaches


forever         b   forever
                ENDP
                END