; Define address of selected GPIO and Timer registers
PERIPH_BASE     	equ	0x40000000                 ;Peripheral base address
AHB1PERIPH_BASE 	equ	(PERIPH_BASE + 0x00020000)
APB1PERIPH_BASE     equ PERIPH_BASE

GPIOD_BASE			equ	(AHB1PERIPH_BASE + 0x0C00)
GPIOF_BASE			equ	(AHB1PERIPH_BASE + 0x1400)
TIM2_BASE           equ (APB1PERIPH_BASE + 0x0000)
	
GPIO_F_PIN        	equ	(GPIOF_BASE + 0x10)

GPIO_D_PIN			equ	(GPIOD_BASE + 0x10)
GPIO_D_SET			equ (GPIOD_BASE + 0x18)
GPIO_D_CLR			equ	(GPIOD_BASE + 0x1A)

    EXTERN initITSboard
    EXTERN lcdPrintS            ;Display ausgabe
    EXTERN GUI_init
;	EXTERN TP_Init
	IMPORT lcdDrawPixel
	IMPORT lcdMovePixel
	IMPORT lcdMoveBlock

;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	
	AREA MyData, DATA, align = 2
	
DEFAULT_BRIGHTNESS DCW  800
	
SCHWARZ EQU 0x0000
WEISS   EQU 0xFFFF
ROT     EQU 0xF800

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************

	AREA |.text|, CODE, READONLY, ALIGN = 3

;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	

main	PROC
        BL initITSboard
		LDR r1, =DEFAULT_BRIGHTNESS
		LDRH r0, [r1]
		BL GUI_init
		MOV r0, #0x00
;		BL TP_Init
		MOV  R0, #100           ; altX
        MOV  R1, #50            ; altY
        MOV  R2, #101           ; neuX
        MOV  R3, #50            ; neuY
        BL   lcdMoveBlock

forever	b	forever		; nowhere to retun if main ends		
		ENDP
	
; Param: R0 Button, R1 GPIO_F_PIN Inhalt
; Return: R0 1-> pressed 0 -> not pressed
isButtonPressed PROC
		MOV	    R2,#1
		LSL	    R2, R2, R0
		AND	    R2, R1, R2
		CMP	    R2, #0
		BEQ		isPressed
		MOV	    R0,#0
		B	    endPressed 		
isPressed
		MOV	    R0, #1
endPressed  
		BX LR
		ENDP

		ALIGN
		END