;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to setup three LEDs
;                     :
;                     :
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker
                        ;- In this context it set the entry point,too

; setup the peripherie - Mapping the GPIO
PERIPH_BASE         equ 0x40000000
AHB1PERIPH_BASE     equ (PERIPH_BASE + 0x00020000)
GPIOD_BASE          equ (AHB1PERIPH_BASE + 0x0C00)
    
GPIO_D_SET          equ (GPIOD_BASE + 0x18)
GPIO_D_CLR          equ (GPIOD_BASE + 0x1A)
    

;* We need minimal memory setup of InRootSection placed in Code Section
    AREA  |.text|, CODE, READONLY, ALIGN = 3
    ALIGN
main
    BL initITSboard             ; needed by the board to setup
    nop                         ; no operation
    LDR     R6, =GPIO_D_SET     ; get address of the GPIO data set register
    LDR     R7, =GPIO_D_CLR     ; get address of the GPIO data clear register
    ; MOV     R0, #0x01           ; load mask 0b0001
    ; MOV     R1, #0x02           ; load mask 0b0010
    ; MOV     R2, #0x40           ; load mask 0b0100
    ; MOV     R3, #0x80           ; load mask 0b1000
    MOV     R3, #0x83           ; 1000 0011 = 0x83

; WarmUp

a   DCB     4
b   DCW     5
c   DCD     0   

; addieren nur auf registern

LDR     R0, =a ; steht die Adresse von a in R0
LDR     R0, =a ;
LDRB    R1, [R0] ;(Wort=4 Byte)
LDRH    R2, [R0] ; 
ADD     R3, R1, R3
LDR     R0, =c
STR     R3, [R0]

STR (Speichern)
LDR (Laden)

    MOV     R8, #0b0010
    MOV     R9, #0b0011
    ADD     R10, R8
    ADD     R10, R9
    IT      
  

    
    ; Lösung 1
    ; Set LED new
    ; MOV R0, #0xF                ; Entspricht  0000 1111 zum testen                    
    ; STR    R0, [R6]             ; lädt den Inhalt von R0 in den speicher von R6
    ; STR    R0, [R7]             ; lädt den Inhalt von R0 in den speicher von R7
    ; b .

    ; Lösungsansatz 2
    ; Bits schrittweise addieren und Ergebnis in R6 schieben (Nicht vollständig durchdacht)
    ; MOV     R0, [R6]    ; LED D8 on
    ; MOV     R1, R8      ; R1 in R8
    ; ADD     R2, R8      ; Addiere R2 zu R8
    ; STRB     R8, [R6]
    ; b .


    ; Gedanken zur Übersetzung von Binär in Hex
    ; Ich brauch 1000 0000 = 0x8D
    ;    0000 0011 = 0x03
    
    ; Set LED
    ; STRB    R2, [R6]    ; switch on LED D14 (richtig)
    ; STRB    R3, [R6]    ; switch on LED D15 (richtig)
    ; STRB    R0, [R6]    ; switch on LED D08 (richtig)
    ; STRB    R0, [R7]    ; switch off LED D08 (richtig)
    ; STRB    R0, [R6]    ; switch on LED D08 (richtig)
    ; STRB    R1, [R6]    ; switch on LED D09 (richtig)
    ; STRB    R2, [R7]    ; switch off LED D14 (richtig)
    ; STRB    R3, [R7]    ; switch off LED D15 (richtig) Endzustand=D8, D9, D15 on => 10000011

    ; Lösung 1.1
    STRB    R3, [R6]    ; lädt Inhalt von R3 in Speicher von R6
    ; STRB    R3, [R7]    ; switch off LED D15 (richtig)
    
    ;MOV     R0, [R6]    ; LED D8 on
    ;ADD     R1, R0
    STRB     R8, [R6] ; (falsch) -> sind nur die Lampen 8 und 9
    b .

    ALIGN
    END