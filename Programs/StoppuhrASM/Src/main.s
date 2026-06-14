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
TICKS_10MIN     	EQU 60000000
TICKS_1MIN      	EQU 6000000
TICKS_10SEC     	EQU 1000000
TICKS_1SEC      	EQU 100000

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
ZEIT				DCB		"00:00.00", 0
NULL_ZEIT			DCB		"00:00.00", 0
STATE				DCB		0


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
		LDR   	r1, =DEFAULT_BRIGHTNESS
		LDRH 	r0, [r1]
		BL   	GUI_init
		BL  	initTimer
		LDR 	R1,=TIM2_PSC   			; Set pre scaler such that 1 timer tick represents 10 us
		MOV 	R0,#(90*10-1) 
		STRH	R0,[R1]
		LDR 	R1,=TIM2_ERG   			; Restart timer	
		MOV		R0,#0x01
		STRH	R0,[R1]					; Set UG Bit
		MOV 	R0, #24					
		BL  	lcdSetFont
		; Ihre Initialisierung
		MOV 	R0, #0
		MOV 	R1, #6
        BL      lcdGotoXY
		; Simple test code
		LDR 	R0,=NULL_ZEIT
		BL  	lcdPrintS
superloop
		LDR		R0,=GPIO_F_PIN
		LDRH	R0,[R0]
		AND		R0, #0xFF
		EOR		R0,R0,#0xFF
		LDR		R3, =STATE
		LDRB	R3, [R3]

; Zustandsautomat
		CMP	    R3,#0
		BLEQ	init
		CMP	    R3,#1
		BLEQ	run
		CMP	    R3,#2
		BLEQ	hold
		BAL		superloop
		ENDP

init PROC
		CMP	    R0, #0x80
		BNE		init_done		
		LDR	    R3,=STATE
		MOV	    R4,#1  
		STRB    R4,[R3]
init_done 
		BX lr
		ENDP

run PROC
		PUSH {R0, LR}
		BL	    time
		LDR	    R3,=STATE
		MOV	    R4,#0  
		STRB    R4,[R3]
		POP {R0, LR}
		BX LR
		ENDP

hold PROC
		LDR		R0,=GPIO_F_PIN
		LDRH	R0,[R0]
		STR		R0,[R1]
		EOR		R1,R1,#0xFF
		BX LR
		ENDP

time PROC
		PUSH	{R0, R1, R2, R3, LR}
		LDR	    R1, =TIMER
		LDR	    R1, [R1]
		LDR     R0, =ZEIT
		MOV     R3, #'0'
        STRB    R3, [R0, #0]
        STRB    R3, [R0, #1]
        STRB    R3, [R0, #3]
        STRB    R3, [R0, #4]
        STRB    R3, [R0, #6]
        STRB    R3, [R0, #7]
min10_loop
		LDR	    R2, =TICKS_10MIN
		CMP	    R1, R2
		BLT		min1_loop
		SUB	    R1, R1, R2
		LDRB    R3, [R0]
		ADD	    R3, R3, #1
		STRB    R3, [R0]
		B		min10_loop
min1_loop
		LDR	    R2, =TICKS_1MIN
		CMP	    R1, R2
		BLT		sec10_loop
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #1]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #1]   
		B		min1_loop
sec10_loop
		LDR	    R2, =TICKS_10SEC
		CMP	    R1, R2
		BLT		sec1_loop
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #3]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #3]  
		B		sec10_loop
sec1_loop
		LDR	    R2, =TICKS_1SEC
		CMP	    R1, R2
		BLT		done
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #4]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #4]  
		B		sec1_loop
done
		MOV     R0, #0      
        MOV     R1, #6
        BL      lcdGotoXY
		LDR	    R0, =ZEIT 
		BL  	lcdPrintS
		POP		{R0, R1, R2, R3, LR}
		BX LR
		ENDP

; print_time
;		PUSH	{R0, R1, R2, LR}
;		POP		{R0, R1, R2, LR}
;		BX LR
;		ENDP


ENDP
		ALIGN
		END
