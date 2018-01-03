;*********************************************
;	setup.asm
;*********************************************

bits	16
%include "memory.asm"

org		$SETUP_ADDRESS
start:  jmp Loader

msg db "Starting compatibility mode", 0

;*************************************************;
;	Entry point
;*************************************************;
Loader:
    sti
    xor	ax, ax		
    mov	ds, ax		
    mov	es, ax	
	mov si, msg
	
    call print_string
    ;jmp BOOT_LOADER_ADDRESS
    cli
    hlt

%include "printer.asm"
    
times 510 - ($-$$) db 0	
dw 0xAA55
