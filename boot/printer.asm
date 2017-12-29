;*************************************************;
;	Print memory amount (TODO)
;*************************************************;
PrintMemory:
	mov ax, 0
	int	0x12 				;Now AX = Amount of KB in system recorded by BIOS
	mov dx, ax				;Dividend
	mov cx, 0x400			;divisor 1024 (mb)


;*************************************************;
;	Print
;		this is the public function to use
;*************************************************;

Print:
	mov	ax, 0					;clean accumulator
	mov	ds, ax					;clean Data Segment
	mov	es, ax					;clean Extra Segment
	mov	si, msg					;Source Index register (SI). Used as a pointer to a source in stream operations 
	call Print_Message	
	mov ah, 0x03				;Get cursor position
	int 10h
	mov ah, dh					;Cursor row
	add ah, 0x1					;Cursor row++
	mov dh, ah					;/n
	mov	dl, 0x0					;column 0
	mov ah, 0x02				
	int 10h
	xor	ax, ax		
	int	0x13					;interruption to print string
	
	ret

;*************************************************;
;	Print message
;		this is private
;*************************************************;
Print_Message:
	lodsb					;Load byte at address DS:(E)SI into AL.	
	or al, al				;accumulator (8 bits (lower part))
	jz Print_Done			;Jump if zero
	mov	ah,	0eh				;Function display character
	int	10h					;al already contains character to print, call interruption
	jmp	Print_Message

;*************************************************;
;	Print return
;*************************************************;
Print_Done:
	ret
