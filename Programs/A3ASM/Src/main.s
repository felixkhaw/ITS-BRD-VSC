;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 2 Byte Bereiches unter dem Label VariableA mit Wert
VariableA          DCW 0x1234

; Reservieren eines 2 Byte Bereiches unter dem Label VariableB mit Wert
VariableB          DCW 0x4711

; Reservieren eines 4 Byte Bereiches unter dem Label VariableC mit Wert
VariableC          DCD  0

; Reservieren eines 2 Byte Arrays mit Werten
MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

; Reservieren eines 4 Byte Arrays mit Werten
MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

; Reservieren eines 1 Byte Arrays mit Werten
; Jeder Buchstabe im String wird zu einem Element des Arrays
MeinTextFeld       DCB "ABab0123",0

; dem Programm verfügbar machen
                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard

; Start der main Schleife des Programmes
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register

; Schreibt den Wert hinter # direkt in das Register r0
                mov   r0,#0x12                      ; Anw-01

; Schreibt den Wert hinter # direkt in das Register r1
                mov   r1,#-128                      ; Anw-02

; Schreibt den Wert hinter # direkt in das Register r1 mit der Pseudo-Instruktion = damit entscheidet der Assembler selber wie der Wert geladen wird
; Wirft ggf Probleme auf aber funktioniert
; lädt mit ldr also 32 bit (4 Bytes)
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
; lädt die Adresse, die auf den Anfang des Labels VariableA zeigt
                ldr   r0,=VariableA                 ; Anw-04

; lädt ein halb Wort ab der Adresse die in r0 steht [] bdeutet: Achtung, du bekommst eine Adresse
                ldrh  r1,[r0]                       ; Anw-05
                ldr   r2,[r0]                       ; Anw-06

; Schreibt unbegrenzt (4 Bytes) den Inhalt von r2 an die Adresse in r0 mit einem Offset von 4
; Die Adresse wird berechnet in dem die Adresse von VariableC - VariableA = #4
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
                ldr   r0,=MeinHalbwortFeld          ; Anw-08

; ldrh = load Wort
                ldrh  r1,[r0]                       ; Anw-09

; lädt halb Wort mit Offset von 2
                ldrh  r2,[r0,#2]                    ; Anw-10

; schreibt sozusagen hard den Wert 10 in r3, # bedeute oder zwingt den assembler 10 als Wert zu verstehen
                mov   r3,#10                        ; Anw-11
                ldrh  r4,[r0,r3]                    ; Anw-12

; lädt ein halb Wort, [rX,#x]! in Kombination mit ! kann eine Adresse inkrementiert werden
; Das bedeutet nach dem Befehl wird die Adress die in r0 steht um 2 erhöht
                ldrh  r5,[r0,#2]!                   ; Anw-13
                ldrh  r6,[r0,#2]!                   ; Anw-14
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ldr  r0,=MeinWortFeld               ; Anw-16
                ldr  r1,[r0]                        ; Anw-17

lädt 4 Bytes mit offset 4
                ldr  r2,[r0,#4]                     ; Anw-18

; addition mit entsprechenden Interpretations-Möglichkeiten unter Berücksichtigung der Flags in xPSR (StatusRegister)
                adds r3,r1,r2                       ; Anw-19

                ldr  r4,[r0,#8]                     ; Anw-20
                ldr  r5,[r0,#12]                    ; Anw-21

; ähnlich Anw-19 aber komplizierter weil die Semantik sich umdrehen kann von dem C flag
                subs r6,r4,r5                       ; Anw-22

                ldr  r7,[r0,#16]                    ; Anw-23
                ldr  r8,[r0,#20]                    ; Anw-24
                subs r9,r7,r8                       ; Anw-25

forever         b   forever                         ; Anw-26
                ENDP
                END