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
TICKS_10CENT		EQU	10000
TICKS_1CENT			EQU 1000

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
ZEIT_ALT			DCB		"aa:aa.aa", 0
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
		MOV	    R0,#7 
		LDR		R1,=GPIO_F_PIN
		LDR	    R1, [R1] 
		BL	    isButtonPressed
		CMP	    R0, #0
		BEQ	    notPressed
		LDR	    R4, =STATE
		MOV	    R3, #1 
		STRB    R3, [R4]   
notPressed
; Zustandsautomat
		LDR	    R4, =STATE
		LDRB    R4, [R4] 
		CMP	    R4,#0
		BLEQ	init
		CMP	    R4,#1
		BLEQ	run
		CMP	    R4,#2
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
		BL	    print_time
		; LDR	    R3,=STATE
		; MOV	    R4,#0  
		; STRB    R4,[R3]
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
		PUSH	{R0-R3, LR}
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
		BLT		cent10_loop
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #4]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #4]  
		B		sec1_loop
cent10_loop
		LDR	    R2, =TICKS_10CENT
		CMP	    R1, R2
		BLT		cent1_loop
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #6]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #6]  
		B		cent10_loop
cent1_loop
		LDR	    R2, =TICKS_1CENT
		CMP	    R1, R2
		BLT		done
		SUB	    R1, R1, R2
		LDRB    R3, [R0, #7]
		ADD	    R3, R3, #1
		STRB    R3, [R0, #7]  
		B		cent1_loop
done
		POP		{R0-R3, LR}
		BX LR
		ENDP

; for(int i=0; zeit[i] != 0; i++)
;   if (zeit[i] != zeitalt(i))
;       cursor setzen
;	   zeichen ausgeben
;	   zeitalt[i]= zeit[i]

print_time PROC
		PUSH	{R4-R8, LR}
for_sc 
		MOV	    R4, #0 
		LDR		R5, =ZEIT
		LDR	    R7, =ZEIT_ALT 
until_sc 
		CMP	    R4, #8
		BEQ		enddo_sc 
do_sc		
		LDR	    R6,[R5,R4]
		LDR	    R8,[R7,R4]
		CMP 	R6, R8
		BEQ		do_nothing
		STRB    R6, [R5,R4]
		MOV     R0, R4      
        MOV     R1, #6
        BL      lcdGotoXY
		MOV  	R0, R6
		BL  	lcdPrintC
do_nothing		
step_sc
		ADD	    R4, R4, #1
		B	    until_sc
enddo_sc
		POP		{R4-R8, LR}
		BX LR
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
