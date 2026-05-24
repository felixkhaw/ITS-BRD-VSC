; Pseudocode: https://github.com/felixkhaw/Primzahlen

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 4 Byte Arrays mit Werten
zahlen              FILL    1000, 0x01
                    DCB     0xFF // Terminierungsvariable

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
main            PROC
                bl    initITSboard ; HW Initialisieren
                ldr  r0,=zahlen    ; Start Adresse von Zahlen
                add  r0,r0, #2

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
;   r0 -> Zeiger zahlen
;   r1 -> Wert zahlen
;   r2 -> Primzahl
;   r3 -> Zeiger Vielfaches
;   r4 -> Wert Vielfaches
;   r5 -> Sprung Vielfaches

for_vielfaches      // Sprungziel
until_vielfaches    // Bei innerer For Schleife funktioniert die Terminate nicht zuverlässig
                ldrb r4, [r3]
                cmp  r4, #0xFF
                beq enddo_vielfaches
do_vielfaches   
                // noch nicht ganz klar

step_vielfaches     // Durch Addition das nächste Vielfache
enddo_vielfaches


forever         b   forever
                ENDP
                END