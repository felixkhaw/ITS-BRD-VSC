; ein Array mit primzahlen bis 10
; ein Array mit Zahlen

; Ein loop der das Zahlenarray durchläuft und für jedes Element prüft
; ob die Zahl ein vielfaches einer Zahl in dem Primzahlen array ist
; Falls nicht ist es eine Primzahl und kann in das array 
; der Primzahl mit aufgenommen werden.

; Zweite Idee näher am Sieb des Eratosthenes
; Ein loop der zahlen array durchläuft und die vielfachen von primzahlen löscht
; Bsp in zahlen stehen die Zahlen 11-1000
; in Primzahlen stehen die Primzahlen von 1-10 also 2,3,5,7
; jetzt durcläuft der loop die Zahle 11-1000 und löscht alle vielfachen von 7
; danach von das gleiche mit dem vielfachen von 5 u.s.w
; Am Ende stehen alle Primazahlen bois 1000 im array Zahlen
; Vorteil es werden zunehmend weniger Zahlen durch das löschen und dadurch gibt es insgesamt weniger durchläufe.