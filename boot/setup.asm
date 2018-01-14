;*********************************************
;	setup.asm
;*********************************************

bits	16
%include "memory.asm"

org		$SETUP_ADDRESS
start:  jmp Loader


%include "printer.asm"
%include "gdt.asm"

msg db "Starting compatibility mode", 0
loadingGdt db "Loading GDT", 0
success db "Success", 0

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

    mov si, loadingGdt	
    call print_string;
    
    call InstallGDT;
    mov si, success	
    call print_string
    
    call StartProtectedMode
    
    call OpenA20
    jmp	0x08:Stage3
    hlt

;******************************************************
;	Start protected mode
;******************************************************
StartProtectedMode:
    cli				    ; clear interrupts
	mov	eax, cr0		; set bit 0 in cr0--enter pmode
	or	eax, 1
	mov	cr0, eax
    ret

;******************************************************
;	Open A20 (Now we can use all our memory)
;******************************************************
OpenA20:
    mov al, 0xdd	; command 0xdd: enable a20
    out 0x64, al	; send command to controller
    ret
 

;******************************************************
;	ENTRY POINT FOR STAGE 3
;******************************************************

bits 32	
Stage3:
 
	mov		ax, 0x10		; set data segments to data selector (0x10 (based on offset of GDT))
	mov		ds, ax
	mov		ss, ax
	mov		es, ax
	mov		esp, STACK_BEGIN_ADDRESS		; stack begin address
    hlt
