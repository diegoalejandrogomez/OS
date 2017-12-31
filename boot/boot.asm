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
;*************************************************;
;	Entry point
;*************************************************;
Loader:
	call PrintBootMessage
	call LoadSetup
	jmp $SETUP_ADDRESS
	
;*************************************************;
;	Load setup
;*************************************************;
LoadSetup:
	call 	LoadSetupFromDevice
	call 	PrintSetupMessage
	ret

%include "printer.asm"
%include "files.asm"

times 510 - ($-$$) db 0	

dw 0xAA55
