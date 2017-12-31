bits	16
%include "memory.asm"	

org		$SETUP_ADDRESS
start:  jmp Load

Load:
   sti
   call PrintSuccessMessage
   cli
   hlt
    

%include "printer.asm"
times 512 - ($-$$) db 0	
