# Aufgabe 2

Zeile 28

**ldr     R0,=VariableA   ; Anw01**

R0  0x2000000c  
R2  0x4  
R3  0x8  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00

---
Zeile 29

**ldrb    R2,[R0]         ; Anw02**

R0  0x2000000c  
R2  0xef  
R3  0x8  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00

---
Zeile 30

**ldrb    R3,[R0,#1]      ; Anw03**

R0  0x2000000c  
R2  0xef  
R3  0xbe    <-  Hier hat sich etwas geändert  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00
---
Zeile 31

**lsl     R2, #8          ; Anw04**

R0  0x2000000c  
R2  0xef00  
R3  0xbe  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00
---
Zeile 32

**orr     R2, R3          ; Anw05**

R0  0x2000000c  
R2  0xefbe   
R3  0xbe  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00
---
Zeile 33

**strh    R2,[R0]         ; Anw06**

R0  0x2000000c  
R2  0xefbe   
R3  0xbe  

Speicher &VariableA  
0x2000000c	ef	be	34	12	00	00	00	00	00	00	00	00	00	00	00	00

Speicher &VariableB  
0x2000000e	34	12	00	00	00	00	00	00	00	00	00	00	00	00	00	00
---