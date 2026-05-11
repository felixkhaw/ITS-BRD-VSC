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