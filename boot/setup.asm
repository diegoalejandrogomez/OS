bits	16
%include "memory.asm"	

org		$SETUP_ADDRESS

Main:
    call PrintBootMessage
    cli
    hlt

%include "printer.asm"
times 512 - ($-$$) db 0	
