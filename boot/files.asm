
LoadSetupFromDevice:
	Reset:
		mov		ah, 0					; reset floppy disk function
		mov		dl, 0					; drive 0 is floppy drive
		int		0x13					; call BIOS
		jc		Load_Failed
		jc		Reset					; If Carry Flag (CF) is set, there was an error. Try resetting again

	mov ax, $SETUP_ADDRESS				; we are going to read sector into address $SETUP_ADDRESS
	mov es, ax
	
	mov dh, 0
	mov dl, 0  ;DH=Head  DL=Drive
	mov ch, 0
	mov cl, 2	;CH=Cylinder CL=Sector (first sector is boot.asm)
	mov ah, 0x02
	mov al,	$SETUP_LENGHT
	xor	bx, bx
	int 0x13
	jnc Load_ok
	jc 	Load_Failed
	ret
Load_ok:
	call PrintSuccessMessage
	ret
Load_Failed:
	call PrintErrorMessage
	ret