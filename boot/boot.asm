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

booting db "Booting...", 0
success db "Success", 0
fail db "Fail", 0
setupLoaded db "Setup Loaded", 0

;*************************************************;
;	Entry point
;*************************************************;
Loader:
	sti
	xor	ax, ax		
	mov	ds, ax		
	mov	es, ax		
	
	mov si, booting
	call print_string
	
	call LoadSetup
	jmp $SETUP_ADDRESS
	
;*************************************************;
;	Load setup
;*************************************************;
LoadSetup:
	call 	LoadSetupFromDevice
	
	mov si, setupLoaded
	call print_string
	
	ret

%include "printer.asm"
%include "files.asm"

times 510 - ($-$$) db 0	
dw 0xAA55
