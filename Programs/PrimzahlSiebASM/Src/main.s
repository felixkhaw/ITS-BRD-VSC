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
;   r1 -> Wert zahlen
;   r2 -> Primzahl
;   r3 -> Zeiger vielfaches
;   r4 -> Wert vielfaches
main            PROC
                bl    initITSboard ; HW Initialisieren
                ldr  r0,=zahlen    ; Start Adresse von Zahlen
                ldr  r3,=zahlen    ; Start Adresse von Zahlen

; ******************
; FOR Zahlen
; Info -> Counter ist nicht nötig wegen Terminierungsvariable
; ******************
for_zahlen      // Sprungziel 
until_zahlen    
                ldrb  r1, [r0]      ; Lade Wert aus Adress r0
                cmp   r1, #0        ; Prüfe ob Terminator erreicht ist
                beq   enddo_zahlen  ; Springe wenn Terminator erreicht ist -> r2=0
do_zahlen       
                // Code
                // Aufruf von If-Struktur
              
if_gestrichen
                cmp r1, #1
                bne endif_gestrichen
then_gestrichen 
                // starte for-vielfaches
endif_gestrichen

step_zahlen     
                add r0,r0, #1
                b until_zahlen
enddo_zahlen

; ******************
; FOR Vielfaches
; ******************
for_vielfaches      // Sprungziel
until_vielfaches    cpm   r4, 0x00  
do_vielfaches       
                // Setzte bei Adresse x in Zahlen Wert auf 0x00
step_vielfaches     add r4,r4, #1
enddo_vielfaches


forever         b   forever
                ENDP
                END