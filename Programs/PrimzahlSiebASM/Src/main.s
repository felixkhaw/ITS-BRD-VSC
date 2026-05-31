; Pseudocode: https://github.com/felixkhaw/Primzahlen

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 4 Byte Arrays mit Werten

zahlen              FILL    1001, 0x01, 1
primzahlen          FILL    500, 0, 2
; dem Programm verfügbar machen
                    EXPORT zahlen
                    
;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard

;   r0 -> Startadresse zahlen
;   r1 -> Wert bzw. Boolean an [r0]
;   r2 -> Counter for zahlen
;   r3 -> Boolean von Zahl
;   r4 -> Aktuelles Vielfaches
;   r5 -> Counter primzahlen
;   r6 -> Startadresse primzahlen

main            PROC
                bl    initITSboard ; HW Initialisieren
for_zahlen
                ldr  r0,=zahlen    ; Start Adresse von Zahlen
                mov r1, #0x00
                strb r1, [r0]
                strb r1, [r0, #1]
                mov  r2, #2
until_zahlen    
                cmp   r2, #1000   ; Prüfe ob Terminator erreicht ist
                bgt   enddo_zahlen  ; Springe wenn Terminator erreicht ist
do_zahlen   
                ldrb r3, [r0, r2]
if_gestrichen
                cmp r3, #1
                bne endif_gestrichen
then_gestrichen 
for_vielfaches
                mul r4,r2,r2
until_vielfaches
                cmp r4, #1000
                bgt enddo_vielfaches
do_vielfaches
                
                strb r1, [r0, r4]
step_vielfaches     
                add r4, r4, r2
                b until_vielfaches
enddo_vielfaches
endif_gestrichen
step_zahlen     
                add r2,r2, #1
                b until_zahlen
enddo_zahlen

; Ausgabe der Primzahlen in primzahl Array
for_primzahl
                mov r2, #0  ; Counter zurücksetzen
                mov r5, #0
                ldr r6, =primzahlen
until_primzahl
                cmp r2, #1000
                bgt enddo_primzahl
do_primzahl
if_primzahl   
                ldrb r3, [r0, r2]
                cmp r3, #1
                bne endif_primzahl    
then_primzahl
                strh r2, [r6]
                add  r6, r6, #2
endif_primzahl        
step_primzahl
                add r2, r2, #1
                b until_primzahl  
enddo_primzahl

forever         b   forever
                ENDP
                END