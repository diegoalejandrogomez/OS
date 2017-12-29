;in order to make it work for any parameter, the quantity of sectors to read should be saved in al
        
Load_from_device:
	mov dx, 0x0001		;DH=Head  DL=Drive
	mov cx, 0x0002		;CH=Cylinder CL=Sector (first sector is boot.asm)
	mov bx, 0x0200		;512 buffer address pointer
	mov ax, 0			;clean ax
	add ax, BOOT_LOADER_SIZE
	add ax, 0x0200		;02 AH, sectors to read AL
	int 0x13
	jnc Load_ok

Load_ok:
	;mov dword [msg], "success" 		
	;call	Print