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

*Nachdem Befehl steht 536870924 in speicheradresse 0x2000000c*

Was genau macht:
```
VariableA   DCW 0xbeef
```

Anw02:
```
ldrb    R2,[R0]         ; Anw02
```


Anw03:

Anw04:

Anw05:

Anw06: