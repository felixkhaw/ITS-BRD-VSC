; Pseudocode: https://github.com/felixkhaw/Primzahlen

; Vorbereitung Assembler code
; primzahlen DCB 2,3,5,7,11 ; Definieren von Array mit Primzahlen von 2-11
; zahlen FILL 999,0 ; Definieren von Array mit Zahlen von 2-1000 / Wenn man das so macht muss noch überprüft werden welche Größe FILL anlegt

; for_01
;   mov r0, #1