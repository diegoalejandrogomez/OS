
LoadSetupFromDevice:
	pusha
	Reset:
		mov		ah, 0					; reset floppy disk function
		mov		dl, 0					; drive 0 is floppy drive
		int		0x13					; call BIOS
		jc		Load_Failed
		jc		Reset					; If Carry Flag (CF) is set, there was an error. Try resetting again

	mov ax, 0x0							; we are going to read sector into address $SETUP_ADDRESS
	mov es, ax
	
	mov dh, 0
	mov dl, 0  ;DH=Head  DL=Drive
	mov ch, 0
	mov cl, 2	;CH=Cylinder CL=Sector (first sector is boot.asm)
	mov ax, $SETUP_ADDRESS
	mov bx, ax
	mov ah, 0x02
	mov al,	$SETUP_LENGHT
	int 0x13
	popa
	jnc Load_ok
	jc 	Load_Failed
	ret
Load_ok:
	mov si, success
	call print_string
	ret

Load_Failed:
	mov si, fail
	call print_string
	ret