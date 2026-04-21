# Protokoll und Gedankengänge  
Aufgabe: *A1*  
Modul: *GT*  
Student: *Felix Knupper*    
---

**Nachfolgend werden Notizen mit N[1...n] aufgeführt.**

*N1:* Nach anfänglichen Problemen, mit der Inbetriebnahme der Erweiterungen, für die Assembler Programmierung auf dem GT-Board war ich im Labor und habe gemeinsam mit Tobias alles zum laufen bekommen. Der Fehler war das ich vergessen hatte beide Kabel an das Board zu schließen und während ich nur ein Kabel angeschlossen hatte habe ich verschiedene Debugger ausprobiert und sehr wahrscheinlich irgendeine config zerstört.

Es ist ungewohnt eine so große Erweiterung zu benutzen von der ich nur Teile verstehe.

*N2:*
Beim Weiterarbeiten habe ich Probleme mit den Branches gehabt und einen Merge-Konflikt. Ich frage mich was genau das tag macht oder um genauer, was der Befehl git tag "" auslöst. Außerdem habe ich heute eine Frage im Forum bzw. in der GT Gruppe gestellt weil mir noch nicht klar ist wie es stattfinden soll das wir also ich und mein Praktikumspartner zusammen arbeiten aber getrennt abgeben sollen. Weil es ja nur einen Readme.md in dem Projekt gibt. Entweder wir müssen zusammen ander Readme schreiben für das Protokoll.[Noch nicht fertig]
Aber ich habe noch keine Antwort und kann nicht 100% sagen ob ich auf diesem Repo weitermachen soll oder das von meinem PP und auf dem arbeiten soll.

*N3:*
Zum Thema Breakpoints setzen habe ich herausgefunden dass man nur begrenzt Breakpoints setzen kann. Schritt für Schritt durchlaufen geht so oder so.

*N4:*
Man kann nicht in dem Editor einfach R1 -> add watch machen. Man muss wenn in der Registerliste ein Register zu watch Liste hinzufügen.

*N4:*
Nach dem Befehl: "LDR     R6, =GPIO_D_SET" landet 1073875992 im R6 in D6 tut sich nichts. LDR scheint ohne nähere Angaben etwas einfach zu laden. Was mir auffällt ist das 1073875992 keine Binäre oder Hexzahl ist. Das Label wurde mit = geladen. Anscheindend sind Speicheradressen Ganzezahlen.

*N5:*
Bei dem Befehl:  
```
MOV     R0, #0x01           ; load mask 0b0001
```
Im Anschluss des Befehls steht im Register r0 eine 1. Ich frage mich was eine load mask im Kommentar bedeuten soll oder was eine Maske ist. Ich gehe davon aus das 0b Binär bedeuten soll, aber ich bin mir nicht sicher.

*N6:*

Ziel der Aufgabe ist alle LEDs aufeinmal anzustellen. 

Befehle:

*equ:*
Durch den Befehl equ kann eine Konstante definiert werden. Definition eines Labels.

Beispiel:

```
PERIPH_BASE         equ 0x40000000
```

Die Hexzahl 0x40000000 wird dem Label PERIPH_BASE zugewiesen und steht dem Programm unter diesem Namen zur Verfügung.

---

```
AHB1PERIPH_BASE     equ (PERIPH_BASE + 0x00020000)
```

Das Lebel AHB1PERIPH_BASE wird definiert.
Dem Wert von PERIPH_BASE wird die Hexzahl 0x00020000 hinzuaddiert.

Vermutung: 
PERIPH_BASE definiert wo oder ab welcher Adresse das Programm anfängt.

*STRB*:
Der Befehl STRB "Store Register Byte" speichert ein Byte also lädt den Wert in größe eines Bytes in einen den Speicher.

STRB Register, Zielspeicher

Der Ausdruck [R6] bedeutet greife auf Speicher an Adresse R6 zu.

*LDR*:
Der Befehl LDR *Load Register* lädt einen Wert aus dem Speicher in ein Register.

---

*N7:*
Es gibt Teile die ich noch nicht vollständig verstehe. Auf jeden Fall werden die LEDs über die Bits gesteuert.
Das heisst  durch 0000 0000 0000 1111 werden die ersten 4 LEDs angesprochen.
Was in R6 steht schaltet die LEDs an und was in R7 steht schaltet sie aus.

Aber warum?
---
*N9:*

Problem: Breakpoints funktionieren noch nicht richtig.
Lösung: Kaya hat mir gezeigt dass ich in den Einstellungen von VSCode Breakpoints in jedem Dateitypen aktivieren muss
---
*N10:*

- Gestern hat mir jemand im Tutorium noch eine gute Methode gezeigt wie einfach oder relativ einfach Binäre Zahlen in Hex übersetzen kann.
- Ich habe noch ein paar Fragen bezüglich einiger Register und das Mapping aber an sich habe ich viel gelernt durch die Aufgabe und muss noch etwas ausprobieren. Als nächstes hatte ich als Idee mal einer for schleife auszuprobieren welche nach und nach alles Bits setzt.
