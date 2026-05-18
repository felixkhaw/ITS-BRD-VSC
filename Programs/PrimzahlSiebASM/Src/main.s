; Pseudocode: https://github.com/felixkhaw/Primzahlen

; Wesentliche Schritte:
; Anlegen von Boolean Array mit 1000 Feldern; Index repräsentiert die Zahl
; Schrittweises Druchlaufen des Boolean Array -> Schleifenvariable symbolisiert die Zahl
; Für jeden Schritt Vielfaches der Indexzahl aus Boolean Array streichen -> Streichen bedeutet Wert an Stelle x auf False setzen
; Am Ende Ausgabe im Sinne einer For-Schleife des Variable als Index benutzt wird und mit einer If Afrage nur Werte ausgibt des Wert auf True sind