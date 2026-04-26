# Aufgabe 2
*Nutzen Sie den Debugger, um zunächst die Zeilen mit den Kommentaren Anw01 bis
Anw06 zu verstehen. Beschreiben Sie in der Datei Programs/A2/README.md für
jede Zeile den Effekt auf die Register R0, R2 und R3 und den Speicher (Memory)
ab der Adresse der Variable VariableA. Achten Sie besonders auf die
unterschiedliche Darstellung von “beef“ im Speicher.*

---

Zeilen mit dem Kommentar Anw01 bis Anw06:

Anw01:
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

Anw02:
```
ldrb    R2,[R0]         ; Anw02
```
Der Typ B des ldr Befehl lädt ein Byte ohne Zeichen. Das heisst alle 8 Bits (Oder zwei Nibble) stehen zur Verfügung. Angefangen bei a0(Liddle endian)
Das heisst der der Wert wird derefernziert und in R2 geladen.

Anw03:
```
ldrb    R3,[R0,#1]      ; Anw03
```
Lädt den Inhalt von R0, mit einem Offset(von links gesehen) von einem Byte, in R3.
Anw04:

Anw05:

Anw06: