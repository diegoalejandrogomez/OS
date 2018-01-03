print_string:
	lodsb						
	or			al, al			
	jz			done			
	mov			ah,	0eh			
	int			10h
	jmp			print_string	
done:
	call gotonextline
	ret							
gotonextline:
	xor ax, ax
	mov ah, 0x03				;Get cursor position
	int 10h
	mov ah, dh					;Cursor row
	add ah, 0x1					;Cursor row++
	mov dh, ah					;/n
	mov	dl, 0x0					;column 0
	mov ah, 0x02				
	int 10h
	ret