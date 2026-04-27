# Aufgabe 2
*Nutzen Sie den Debugger, um zunächst die Zeilen mit den Kommentaren Anw01 bis
Anw06 zu verstehen. Beschreiben Sie in der Datei Programs/A2/README.md für
jede Zeile den Effekt auf die Register R0, R2 und R3 und den Speicher (Memory)
ab der Adresse der Variable VariableA. Achten Sie besonders auf die
unterschiedliche Darstellung von “beef“ im Speicher.*

---

Zeilen mit dem Kommentar Anw01 bis Anw06:

(Z.28)Anw01:
```
ldr     R0,=VariableA   ; Anw01
```
- Lädt die Speicheradresse des Labels in das Register **R0**
- ldr lädt ohne Begrenzung alle Bitstellen 
- Nachdem Befehl steht in R0 0x2000000c
- Nachdem R0 zur watchlist hinzugefügt wurde steht dort 536870924
- Das bringt mich zu der Frage was genau 536870924 ist oder was in R0 steht.
- Als Dezimalzahl interpretiert ist 0xbeef 48879.
- **Durch die Referenzierung = auf das Label steht eine Speicheradresse in R0. Zum erkennen des Wertes muss die Adresse dereferinziert werden.**

(Z.29)Anw02:
```
ldrb    R2,[R0]         ; Anw02
```
Der Typ B des ldr Befehl lädt ein Byte ohne Zeichen. Das heisst alle 8 Bits (Oder zwei Nibble) stehen zur Verfügung. Angefangen bei a0(Liddle endian)
Das heisst der Wert wird derefernziert und in R2 geladen.

(Z.30)Anw03:
```
ldrb    R3,[R0,#1]      ; Anw03
```
Lädt den Inhalt von R0, mit einem Offset(von rechts gesehen) von einem Byte, in R3.

*Erkenntnis: man kann mit dem ldr Befehl auch ein Offset veranlassen*

(Z.31)Anw04:
```
lsl     R2, #8          ; Anw04
```
lsl (Logical Shift Left): verschiebt die Bits nach links um einen angegebenen Wert. hier #8, also 8 Bitstellen nach links.

Dadurch ist eine Multiplikation möglich. Eine Stelle nach Links vergrößert die Zahl um den Faktor 2.

0001 = 1
0010 = 2
0100 = 4
1000 = 8
0001 0000 = 16
0010 0000 = 32
0100 0000 = 64
1000 0000 = 128

(Z.31)Anw05:
```
orr     R2, R3          ; Anw05
```
orr (Bitwise OR) ist das bitweise oder. Was bedeutet das es zwei Bits vergleich und ein Ergebnis liefert das dem oder entspricht.

    0001
    1101
E:  1101

Macht auf Zahlen so keinen Sinn.

*Eignet sich zum kombinieren von Bits oder sicherstellen das bestimmte gesetzt sind. -> Wobei ich mir nicht sicher bin was man alles damit machen kann.*

Als Parameter ist eine Maske möglich.


Quelle:
https://developer.arm.com/documentation/ddi0597/2026-03/Base-Instructions/ORR--ORRS--register---Bitwise-OR--register--?lang=en

(Z.33)Anw06:
```
strh    R2,[R0]         ; Anw06
```
Lädt ein halb Wort (16 Bit | 2 Byte) der Adresse von R0

Frage: warum macht man das?
1. Die Adresse ist nicht der Wert
2. Von einer 32 Bit Adresse sind 16 Bit nicht mehr die Adresse des Speichers
E: Also warum macht man das?