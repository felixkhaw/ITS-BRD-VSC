;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke    
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2    
VariableA   DCW 0xbeef
VariableB   DCW 0x1234

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Lädt die die Anfangsadresse vom Label VariableA
    ldrb    R2,[R0]         ; Lädt ein Byte in R2, aus der Adresse 0x2000000c
    ldrb    R3,[R0,#1]      ; Lädt ein Byte in R3, aus der Adresse 0x2000000c+1=0x2000000d
    lsl     R2, #8          ; Verschiebt die Bits um 8 Stellen nach links in R2
    orr     R2, R3          ; Wertet nach bitweisem oder R2 und R3 aus Ergebnis steht in R2

    strh    R2,[R0]         ; Schreibt Inhalt von R2 an Inhalt von Adresse in R0
    
;* const in var
    mov     R5,#ConstByteA  ; Anw07
    mov     R7, 0x4EB1
    add     R5, R7
    strh    R5,[R0]         ; Anw08
    
;* Change value from x1234 to x4321
    ldr     R1,=VariableB   ; Anw09
    ldrh    R6,[R1]         ; Anw0A
    mov     R7, #0x21DE     ; Ändern der Bitmaske zu 0x21DE
    add     R6, R7          ; Nach Addition steht 0x3412 in R6
    strh    R6,[R1]         ; Durch liddle endian steht 1234 im Speicher
    b .                     ; Anw0E
    
    ALIGN
    END