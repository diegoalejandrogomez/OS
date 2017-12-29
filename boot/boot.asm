;*********************************************
;	boot.asm
;		- Bootloader
;
;	Main bootloader
;		It must load the main SO code
;*********************************************

bits	16
%include "memory.asm"	

org		$BOOT_LOADER_ADDRESS
start:  jmp Loader
msg	db	"OS Booting", 0		; the string to print

;*************************************************;
;	Entry point
;*************************************************;
Loader:
	call	Print
	call 	InitializeStack
	cli	
    hlt
;*************************************************;
;	Move Loader to a safe position
;*************************************************;

MoveLoader:
	mov ax, BOOT_LOADER_SAFE_ADDRESS
	mov ds, ax 				;Data segment
	mov ax, BOOT_LOADER_SAFE_ADDRESS
	mov es, ax				;Extra data segment
	mov cx, 256			;cx is used for looping, I am passing a word (2 bytes x 256 times (512 bytes))
	sub si, si				;source index register, used for string and memory array copying
	sub di, di				;destionation index register, used for ES
	rep
	movw					;copy one register pair into another register pair
	ret
InitializeStack:	
	mov ax, BOOT_LOADER_SAFE_ADDRESS
	add ax, STACK_SIZE
	;This allows us to use stack operations
	mov ss, ax ;stack 0x9FF00
	mov sp, STACK_SIZE	;512
	ret

%include "printer.asm"
%include "files.asm"

times 510 - ($-$$) db 0	

dw 0xAA55
