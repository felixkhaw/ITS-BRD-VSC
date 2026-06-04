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
;   r5 -> Adresse primzahlen

main            PROC
                bl    initITSboard ; HW Initialisieren
for_zahlen
                ldr  r0,=zahlen     ; Start Adresse von Zahlen
                mov r1, #0x00       ; Maske -> Ausdruck=false
                strb r1, [r0]       ; Setze Boolean Werte der Zahl 0 auf false
                strb r1, [r0, #1]   ; Setze Boolean Werte der Zahl 1 auf false
                mov  r2, #2         ; 
until_zahlen    
                cmp   r2, #1000   ; Abbruchbedingung -> Wenn Counter / Zahl in r2 größer als 1000 wird.
                bgt   enddo_zahlen
do_zahlen   
                ldrb r3, [r0, r2]   ; lade ein Byte in r3 von Startadresse + Counter
if_gestrichen
                cmp r3, #1          ; Wenn Wert in r3 true -> 0x1 ist dann fahre fort mit Schleife -> vielfaches
                bne endif_gestrichen
then_gestrichen 
for_vielfaches
                mul r4,r2,r2        ; Multipliziere Counter * Counter und schreibe Ergebnis in r4 / r4 ist quasi der Counter für diese Schleife
until_vielfaches
                cmp r4, #1000     ; Abbruchbedingung wenn Counter größer als 1000 ist / wird
                bgt enddo_vielfaches
do_vielfaches
                
                strb r1, [r0, r4]   ; Schreibe Maske in Startadresse + Counter(Innere Schleife)
step_vielfaches     
                add r4, r4, r2      ; Erhöhe Counter um Counter der äußeren Schleife
                b until_vielfaches
enddo_vielfaches
endif_gestrichen
step_zahlen     
                add r2,r2, #1       ; Erhöhe Counter in r2, der äußeren Schleife um 1
                b until_zahlen
enddo_zahlen

; Ausgabe der Primzahlen in primzahl Array
for_primzahl
                mov r2, #0              ; Counter zurücksetzen
                ldr r5, =primzahlen     ; lade Startadresse von Array Primzahlen
until_primzahl
                cmp r2, #1000         ; Abbruchbedingung 
                bgt enddo_primzahl      ; Wenn Counter in r2 größer als 1000 Springe zum Label enddo_primzahl
do_primzahl
if_primzahl   
                ldrb r3, [r0, r2]       ; lade ein Byte in r3 ab Startadresse von zahlen + Counter
                cmp r3, #1              ; Vergleiche ob Wert in r3 true ist
                bne endif_primzahl      ; Springe wenn not equal vom vorherigen cmp zum ende vom If
then_primzahl   
                strh r2, [r5]           ; Schreibe den Wert in r2 (Counter) als halb Wort (2 Byte) an Adresse r5(primzahl)
                add  r5, r5, #2         ; Erhöhe Adresse in r5 um 2
endif_primzahl        
step_primzahl
                add r2, r2, #1          ; Schritt der primzahl Schleife -> erhöhe Wert in r2 um 1
                b until_primzahl        ; Springe unbedingt an Label until_primzahl
enddo_primzahl

forever         b   forever             ; Endlos-Schleife
                ENDP
                END