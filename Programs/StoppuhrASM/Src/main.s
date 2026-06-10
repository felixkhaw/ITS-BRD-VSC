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
	
TIMER				equ (TIM2_BASE + 0x24)   ; CNT : current time stamp (32 bit),  resolution
TIM2_PSC			equ (TIM2_BASE + 0x28)   ; Prescaler  resolution
TIM2_ERG			equ (TIM2_BASE + 0x14)   ; 16 Bit register, Bit 0 : 1 Restart Timer


    EXTERN initITSboard
    EXTERN GUI_init
	EXTERN TP_Init
	EXTERN initTimer
	EXTERN lcdSetFont
	EXTERN lcdGotoXY      		; TFT goto x y function
	EXTERN lcdPrintS			; TFT output function	
    EXTERN lcdPrintC            ; TFT output one character		
	EXTERN Delay				; Delay (ms) function


;********************************************
; Data section, aligned on 4-byte boundery
;********************************************
	AREA MyData, DATA, align = 2

DEFAULT_BRIGHTNESS	DCW     800
ZEIT				DCB		"00:01.00", 0
NULL_ZEIT			DCB		"00:00.00", 0
TEST_SPEICHER		DCW		0x00
STATE				DCB		0x00

;********************************************
; Code section, aligned on 8-byte boundery
;********************************************
	AREA |.text|, CODE, READONLY, ALIGN = 3


;--------------------------------------------
; main subroutine
;--------------------------------------------
	EXPORT main [CODE]
	
main	PROC

		; Initialisierung der HW
		BL		initITSboard
		ldr   	r1, =DEFAULT_BRIGHTNESS
		ldrh 	r0, [r1]
		bl   	GUI_init
		bl  	initTimer
		ldr 	R1,=TIM2_PSC   			; Set pre scaler such that 1 timer tick represents 10 us
		mov 	R0,#(90*10-1) 
		strh	R0,[R1]
		ldr 	R1,=TIM2_ERG   			; Restart timer	
		mov		R0,#0x01
		strh	R0,[R1]					; Set UG Bit
		MOV 	R0, #24					
		bl  	lcdSetFont
		; Ihre Initialisierung
		MOV 	R0, #0
		MOV 	R1, #6
        BL      lcdGotoXY

		; Simple test code
		LDR 	R0,=NULL_ZEIT
		BL  	lcdPrintS
superloop
		; read buttons
		LDR		R0,=GPIO_F_PIN
		ldrh	R0,[R0]
		and		R0, #0xFF
		; LDR		R1,=GPIO_D_CLR
		; str		R0,[R1]
		eor		R0,R0,#0xFF
		; LDR		R1,=GPIO_D_SET
		; str		R0,[R1]	
		LDR	    R3, =STATE
		LDR	    R3, [R3]
if_init
		CMP	    R3,#0
		BNE		endif_init
then_init
		BL	    init
endif_init
if_run
		CMP	    R3,#1
		BNE		endif_run
then_run
		BL	    run
endif_run
if_hold
		CMP	    R3,#2
		BNE		endif_hold
then_hold
		BL	    hold
endif_hold
		BAL		superloop				; End of superloop
		ENDP

init PROC	; Reset timer
	; LDR	    R0, =NULL_ZEIT
	; BL	    lcdPrintS
if_s7
	CMP	    R0, #0x80
	bne		endif_s7
then_s7
	LDR	    R3,=STATE
	MOV	    R4,#1  
	STRB    R4,[R3]
endif_s7   
	BX lr

run PROC	; run the timer / again
	push {R0, LR}
	ldr 	R0, =ZEIT
	bl		lcdPrintS
	LDR	    R3,=STATE
	MOV	    R4,#0  
	STRB    R4,[R3]
	pop {R0, LR}
	bx lr

hold PROC	; stop the timer
	LDR		R0,=GPIO_F_PIN
	ldrh	R0,[R0]
	str		R0,[R1]
	eor		R1,R1,#0xFF

	bx lr

ENDP

		ALIGN
		END
