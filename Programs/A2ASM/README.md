# Aufgabe 2

Zeile 28, Kommentar Anw01 (Nach Abschluss des Befehls)

**ldr     R0,=VariableA   ; Anw01**

R0  0x2000000c  
R2  0x4  
R3  0x8  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00

---
Zeile 29, Kommentar Anw02 (Nach Abschluss des Befehls)

**ldrb    R2,[R0]         ; Anw02**

R0  0x2000000c  
R2  0xef  
R3  0x8  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00

---
Zeile 30, Kommentar Anw02 (Nach Abschluss des Befehls)

**ldrb    R3,[R0,#1]      ; Anw03**

R0  0x2000000c  
R2  0xef  
R3  0xbe    <-  Hier hat sich etwas geändert  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00

---