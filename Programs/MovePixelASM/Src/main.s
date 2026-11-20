;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Silke Behn	
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main.
;					  :
;					  : Replace this main with yours.
;
;*******************************************************************************
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
		ldr r1, =DEFAULT_BRIGHTNESS
		ldrh r0, [r1]
		bl GUI_init
		mov r0, #0x00
;		bl TP_Init
		MOV  R0, #100           ; altX
        MOV  R1, #50            ; altY
        MOV  R2, #101           ; neuX
        MOV  R3, #50            ; neuY
        BL   lcdMoveBlock

forever	b	forever		; nowhere to retun if main ends		
		ENDP
	
		ALIGN
       
		END