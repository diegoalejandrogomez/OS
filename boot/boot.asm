;*********************************************
;	boot.asm
;		- Bootloader
;
;	Main bootloader
;		It must load the main SO code
;*********************************************

bits	16
org		0x7c00
start:  jmp Loader
msg	db	"OS is booting...!", 0		; the string to print

;*************************************************;
;	Entry point
;*************************************************;
Loader:
	mov	ax, 0				;clean accumulator
	mov	ds, ax				;clean Data Segment
	mov	es, ax				;clean Extra Segment
	mov	si, msg				;Source Index register (SI). Used as a pointer to a source in stream operations 		
	call	Print			
	xor	ax, ax		
	int	0x13				;interruption to print string
	cli				
    hlt

;*************************************************;
;	Print memory amount (TODO)
;*************************************************;
PrintMemory:
	mov ax, 0
	int	0x12 				;Now AX = Amount of KB in system recorded by BIOS
	mov dx, ax				;Dividend
	mov cx, 0x400			;divisor 1024 (mb)

%include "printer.asm"
	
times 510 - ($-$$) db 0	

dw 0xAA55
