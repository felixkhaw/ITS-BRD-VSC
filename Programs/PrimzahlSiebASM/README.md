# PrimzahlenSieb

## Konzept

Dieses Programm berechnet alle Primzahlen von 0-1000 nach dem Algorithmus Sieb des Erathosthenes.

## Darstellung der Zahlen

Die Zahlen werden zu Beginn nicht direkt als Werte gespeichert, sondern als boolean Wert.

Beispiel:

- `zahlen[2]` = Zahl 2

Der Wert an der jeweiligen Stelle des Arrays gibt in Form eines boolean Wertes an, ob die durch den Index repräsentierte Zahl bereits gestrichen wurde.

- 1 = Zahl wurde nicht gestrichen und gilt weiterhin als mögliche Primzahl
- 0 = Zahl wurde gestrichen und ist keine Primzahl

## Ablauf des Programms

1.  **Initialisierung**  
    - Alle Elemente im Array zahlen werden mit 1 initialisiert.
    - Wenn eine Zahl keine Primzahl ist wird der Wert auf 0 gesetzt.
    - Alle Elemente des Arrays primzahlen werden zunächst mit 0 initialisiert. Nach der Berechnung werden dort die gefundenen Primzahlen gespeichert.

2.  **Sieb des Eratosthenes**  
    - Das Array `zahlen` wird durchlaufen.
    - Für jede nicht gestrichene Zahl werden alle Vielfachen gestrichen.
3.  **Speichern der Primzahlen**
    - Das Array `zahlen` wird erneut durchlaufen
    - Alle nicht gestrichenen Zahlen werden in das Array `primzahlen` kopiert.
4.  **Programmende**
    - Das Programm verbleibt in einer Endlosschleife.