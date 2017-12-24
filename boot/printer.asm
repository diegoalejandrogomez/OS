
;*************************************************;
;	Print message
;*************************************************;
Print:
	lodsb					;Load byte at address DS:(E)SI into AL.	
	or al, al				;accumulator (8 bits (lower part))
	jz PrintDone			;Jump if zero
	mov	ah,	0eh				;Function display character
	int	10h					;al already contains character to print, call interruption
	jmp	Print

;*************************************************;
;	Print return
;*************************************************;
PrintDone:
	ret
