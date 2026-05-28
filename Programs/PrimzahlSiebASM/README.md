# PrimzahlenSieb

Derzeitige todo's bis zum Praktikum:
- Pseudocode verbessern
    - Das Thema Pseudocode ist mir noch nicht 100% klar dazu die Frage: ist Pseudocode in eigener Sprache oder schon code?
- Bis jetzt ist die Aufgabe noch nicht 100% gelöst in meinem Java-Code benutzte ich modulo und den gibt es nicht in Assembler
außerdem fehlt noch das herausstreichen der Primzahlen ab ihrem Quadrat
- Grafische-Darstellung des Speichers siehe Aufgabe

---

Konzept im Hinblick auf den Assembler-Code

;   r0 -> Zeiger auf aktuelle Zahl in zahlen
;   r1 -> Wert bzw. Boolean an [r0]
;   r2 -> Startadresse zahlen
;   r3 -> aktuelle Zahl / Schrittweise
;   r4 -> aktuelles Vielfaches als Zahl
;   r5 -> Zeiger auf aktuelles Vielfaches
;   r6 -> Zeiger primzahl

Ein Großteil besteht, aus meiner Sicht, in der Planung der Register. Also was soll auf welchem Register stattfinden.

Ein wesentliches Problem, wenn man das so sagen kann, ist das die äußere Schleife läuft bis der Wert 0xFF gelesen wird. Das kann auf die innere Schleife nicht angewendet werden. Da bei dem Vielfachen "gesprungen" wird. Daher hat die innere Schleife als Abbruch-Bedinung -> größer als 1000.

--- 

Für mich als Erkenntnis muss ich sagen, dass das Konstrukt der Schleifen im Prinzip "nur" Labels sind zwischen denen gesprungen wird. Man könnte es genauso gut komplett anders bauen.