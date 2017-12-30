;This cannot be the best way to do this, I will search options (someday)

PrintErrorMessage:
	call CleanStringMemory
	mov byte [$STRING_HANDLER_ADDRESS], "E"
	mov byte [$STRING_HANDLER_ADDRESS+8], "r"
	mov byte [$STRING_HANDLER_ADDRESS+16], "r"
	mov byte [$STRING_HANDLER_ADDRESS+24], "o"
	mov byte [$STRING_HANDLER_ADDRESS+32], "r"
	call Print
	ret

PrintSuccessMessage:
	call CleanStringMemory
	mov byte [$STRING_HANDLER_ADDRESS], "S"
	mov byte [$STRING_HANDLER_ADDRESS+8], "u"
	mov byte [$STRING_HANDLER_ADDRESS+16], "c"
	mov byte [$STRING_HANDLER_ADDRESS+24], "c"
	mov byte [$STRING_HANDLER_ADDRESS+32], "e"
	mov byte [$STRING_HANDLER_ADDRESS+40], "s"
	mov byte [$STRING_HANDLER_ADDRESS+48], "s"
	call Print
	ret

PrintBootMessage:
	call CleanStringMemory
	mov byte [$STRING_HANDLER_ADDRESS], "O"
	mov byte [$STRING_HANDLER_ADDRESS+8], "S"
	mov byte [$STRING_HANDLER_ADDRESS+16], " "
	mov byte [$STRING_HANDLER_ADDRESS+24], "B"
	mov byte [$STRING_HANDLER_ADDRESS+32], "o"
	mov byte [$STRING_HANDLER_ADDRESS+40], "o"
	mov byte [$STRING_HANDLER_ADDRESS+48], "t"
	mov byte [$STRING_HANDLER_ADDRESS+56], "i"
	mov byte [$STRING_HANDLER_ADDRESS+64], "n"
	mov byte [$STRING_HANDLER_ADDRESS+72], "g"
	call Print
	ret

PrintSetupStartupMessage:
	call CleanStringMemory
	mov byte [$STRING_HANDLER_ADDRESS], "S"
	mov byte [$STRING_HANDLER_ADDRESS+8], "e"
	mov byte [$STRING_HANDLER_ADDRESS+16], "t"
	mov byte [$STRING_HANDLER_ADDRESS+24], "u"
	mov byte [$STRING_HANDLER_ADDRESS+32], "p"
	mov byte [$STRING_HANDLER_ADDRESS+40], " "
	mov byte [$STRING_HANDLER_ADDRESS+48], "s"
	mov byte [$STRING_HANDLER_ADDRESS+56], "t"
	mov byte [$STRING_HANDLER_ADDRESS+64], "a"
	mov byte [$STRING_HANDLER_ADDRESS+72], "r"
	mov byte [$STRING_HANDLER_ADDRESS+80], "t"
	mov byte [$STRING_HANDLER_ADDRESS+88], "i"
	mov byte [$STRING_HANDLER_ADDRESS+96], "n"
	mov byte [$STRING_HANDLER_ADDRESS+104], "g"
	call Print
	ret


PrintSetupMessage:
	call CleanStringMemory
	mov byte [$STRING_HANDLER_ADDRESS], "S"
	mov byte [$STRING_HANDLER_ADDRESS+8], "e"
	mov byte [$STRING_HANDLER_ADDRESS+16], "t"
	mov byte [$STRING_HANDLER_ADDRESS+24], "u"
	mov byte [$STRING_HANDLER_ADDRESS+32], "p"
	mov byte [$STRING_HANDLER_ADDRESS+40], " "
	mov byte [$STRING_HANDLER_ADDRESS+48], "L"
	mov byte [$STRING_HANDLER_ADDRESS+56], "o"
	mov byte [$STRING_HANDLER_ADDRESS+64], "a"
	mov byte [$STRING_HANDLER_ADDRESS+72], "d"
	mov byte [$STRING_HANDLER_ADDRESS+80], "e"
	mov byte [$STRING_HANDLER_ADDRESS+88], "d"
	call Print
	ret

Print:
	mov cx, 0x0 		;initial position
	cmp cx, 0x20		; < 32
 	jg end
 	beginning:
 		mov ax, 8		;I need to move 1 byte in memory
		mul cx
		add ax, $STRING_HANDLER_ADDRESS
		mov bx, ax
		mov byte al, [bx]
		mov	ah,	0eh				;Function display character
		int	10h					;al already contains character to print, call interruption
	    inc cx
		cmp cx, 0x20
 		jl beginning
		jge end
	end:
		call MoveToNextLine
		ret

MoveToNextLine:
	mov ah, 0x03				;Get cursor position
	int 10h
	mov ah, dh					;Cursor row
	add ah, 0x1					;Cursor row++
	mov dh, ah					;/n
	mov	dl, 0x0					;column 0
	mov ah, 0x02				
	int 10h
	ret

PrintDone:
	ret

CleanStringMemory:
	mov cx, 0x0 		;initial position
	cmp cx, 0x20		; < 32
 	jg end_clean_string
 	beginning_clean_string:
 		mov ax, 8		;I need to move 1 byte in memory
		mul cx
		add ax, $STRING_HANDLER_ADDRESS
		mov bx, ax
		mov byte [bx], 0
		inc cx
		cmp cx, 0x20
 		jl beginning_clean_string
		jge end_clean_string
	end_clean_string:
		ret
	ret
	