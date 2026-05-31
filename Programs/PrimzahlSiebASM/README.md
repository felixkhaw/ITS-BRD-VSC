# PrimzahlenSieb

## Konzept

Dieses Programm berechnet alle Primzahlen von 0-1000 nach dem Algorithmus Sieb des Erathosthenes.

## Darstellung der Zahlen

Die Zahlen werden zu Beginn nicht direkt als Werte gespeichert, sondern über den jeweiligen Index beziehungsweise den Counter der Schleifenvariable dargestellt, die durch das Boolean-Array iteriert.

Ablauf des Programms:

1.  **Initialisierung**  
    - Alle Elemente im Array zahlen werden mit 1 initialisiert.
    - Wenn eine Zahl keine Primzahl ist wird der Wert auf 0 gesetzt.
    - Alle Elemente des Arrays primzahlen werden zunächst mit 0 initialisiert. Nach der Berechnung werden dort die gefundenen Primzahlen gespeichert.

2.  **Sieb des Eratosthenes**  
3.  **Speichern der Primzahlen**
4.  **Programmende**