; Pseudocode: https://github.com/felixkhaw/Primzahlen

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 4 Byte Arrays mit Werten
zahlen              FILL    1000, 0x01
                    DCB     0xFF // Terminierungsvariable

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

; Start der main Schleife des Programmes
;   r0 -> Zeiger zahlen
;   r1 -> Wert zahlen
;   r2 -> Primzahl
;   r3 -> Zeiger Vielfaches
;   r4 -> Wert Vielfaches
;   r5 -> Sprung Vielfaches
;   r6 -> Start primzahl
main            PROC
                bl    initITSboard ; HW Initialisieren
                ldr  r0,=zahlen    ; Start Adresse von Zahlen
                add  r0,r0, #2
                ldr  r6,=primzahl

; ******************
; FOR Zahlen
; Info -> Counter ist nicht nötig wegen Terminierungsvariable
; ******************
for_zahlen      // Sprungziel 
until_zahlen    
                ldrb  r1, [r0]      ; Lade Wert aus Adress r0
                cmp   r1, #0xFF     ; Prüfe ob Terminator erreicht ist
                beq   enddo_zahlen  ; Springe wenn Terminator erreicht ist -> r2=0
do_zahlen   
if_gestrichen
                cmp r1, #1
                bne endif_gestrichen
then_gestrichen 
                b for_vielfaches
endif_gestrichen
step_zahlen     
                add r0,r0, #1
                b until_zahlen
enddo_zahlen    
                b step_zahlen

; ******************
; FOR Vielfaches
; ******************
;   r0 -> Zeiger zahlen
;   r1 -> Wert zahlen
;   r2 -> Primzahl
;   r3 -> Zeiger Vielfaches
;   r4 -> Wert Vielfaches
;   r5 -> Sprung Vielfaches
;   r6 -> Start Primzahl

for_vielfaches      // Sprungziel
until_vielfaches
                cmp 
                blt enddo_vielfaches
do_vielfaches   
                r3, =zahlen
                sub r4, r0, r3 \\ Im ersten Durchlauf müsste 2 darin stehen
                strb r4, [r3]
step_vielfaches     
                add r3, r3, r4
                b until_vielfaches
enddo_vielfaches
                b step_vielfaches

forever         b   forever
                ENDP
                END

; Sequentieller Ablauf nach Beendigung der ersten beiden Scheifen in zahlen stehen gestrichen die Primzahlen
                ldr  r0,=zahlen

; Ausgabe der Primzahlen in primzahl Array
; for_primzahl     // Sprungziel
; until_primzahl
;                cmp   r0, #0xFF
;                beq   enddo_primzahl
; do_primzahl  
; if_primzahl
;                ldrb r1,[r0]
;                cmp r1, #1
;                bne endif_gestrichen
; then_primzahl 
;                b for_vielfaches
; endif_primzahl        
; step_primzahl     
;                add r0,r0, #1 
;                b until_primzahl
; enddo_primzahl
;                b step_primzahl

; forever         b   forever
;                ENDP
;                END