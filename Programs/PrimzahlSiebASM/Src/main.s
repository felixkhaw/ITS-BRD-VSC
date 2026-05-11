; ein Array mit primzahlen bis 10
; ein Array mit Zahlen

; Ein loop der das Zahlenarray durchläuft und für jedes Element prüft
; ob die Zahl ein vielfaches einer Zahl in dem Primzahlen array ist
; Falls nicht ist es eine Primzahl und kann in das array 
; der Primzahl mit aufgenommen werden.

; Zweite Idee näher am Sieb des Eratosthenes
; Ein loop der zahlen array durchläuft und die vielfachen von primzahlen löscht
; Bsp in Zahlen(Array) stehen die Zahlen 11-1000
; in Primzahlen(Array) stehen die Primzahlen von 1-10 also 2,3,5,7
; jetzt durchläuft der Loop das Zahlen(Array) 11-1000 und löscht alle Vielfachen von 7
; danach nochmal mit dem Vielfachen von 5 u.s.w
; Am Ende stehen alle Primzahlen bis 1000 im Zahlen(Array)
; Vorteil: es werden zunehmend weniger Zahlen, durch das löschen und es gibt insgesamt weniger Durchläufe

;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base

; Reservieren eines 2 Byte Bereiches unter dem Label VariableA mit Wert
Primzahlen      DCD 0x0 ; Wenn wir 999 inklusive 0 also [0;999] dann benötigen wir 4 Bytes für die Darstellung
Zahlen          DCD 0x0 ;


; dem Programm verfügbar machen
                   EXPORT VariableA

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
