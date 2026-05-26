; Pseudocode: https://github.com/felixkhaw/Primzahlen

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 4 Byte Arrays mit Werten
zahlen              FILL    1000, 0x01
                    DCB     0xFF    ; Terminierungsvariable

primzahlen          FILL    500, 0
                    DCB     0xFF

; dem Programm verfügbar machen
                    EXPORT zahlen


;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard

;   r0 -> Zeiger auf aktuelle Zahl in zahlen
;   r1 -> Wert bzw. Boolean an [r0]
;   r2 -> Startadresse zahlen
;   r3 -> aktuelle Zahl / Schrittweise
;   r4 -> aktuelles Vielfaches als Zahl
;   r5 -> Zeiger auf aktuelles Vielfaches
;   r6 -> Zeiger primzahl

main            PROC
                bl    initITSboard ; HW Initialisieren
                ldr  r0,=zahlen    ; Start Adresse von Zahlen
                add  r0,r0, #1     ; Start von 2 also zweiter Speicherblock
                ldr  r6,=primzahl
for_zahlen
until_zahlen    
                ldrb  r1, [r0]      ; Lade Wert aus Adresse r0
                cmp   r1, #0xFF     ; Prüfe ob Terminator erreicht ist
                beq   enddo_zahlen  ; Springe wenn Terminator erreicht ist -> r2=0
do_zahlen   
if_gestrichen
                cmp r1, #1
                bne endif_gestrichen
then_gestrichen 
                ldr r2, =zahlen
                b for_vielfaches
for_vielfaches
                sub r3, r0, r2 ; Index
                add r3, r3, #1 ; Für Zahl -> Index + 1
                add r4,r3,r3   ; In r4 steht aktuelle Vielfaches
until_vielfaches
                cmp r4, #1000
                bgt enddo_vielfaches
do_vielfaches
                add r5, r2, r4
                sub r5, r5, #1
                mov r1, #0
                strb r1, [r5]
step_vielfaches     
                add r3, r3, r4
                b until_vielfaches
enddo_vielfaches
endif_gestrichen
step_zahlen     
                add r0,r0, #1
                b until_zahlen
enddo_zahlen    
                ldr  r0,=zahlen

; Ausgabe der Primzahlen in primzahl Array
; for_primzahl
; until_primzahl
; do_primzahl  
; if_primzahl         
; then_primzahl 
; endif_primzahl        
; step_primzahl     
; enddo_primzahl

forever         b   forever
                ENDP
                END