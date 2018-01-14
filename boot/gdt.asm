 ;*******************************************
; Global Descriptor Table (GDT)
;*******************************************
gdt_data:
;null descriptor 
	dd 0 				; null descriptor--just fill 8 bytes with zero
	dd 0 
  
;code descriptor:
    lower_segment_limit: ;bits 0-15
	    dw 0FFFFh 		;2 bytes
    base_address:
	    dw 0 			;2 bytes
        db 0            ;1 byte remaining
    access_bit:         ;This is a readable and writable segment, we are a code descriptor, at Ring 0.
        db 10011010b
         			    ;1 bit, used for virtual memory (0)
                        ;1 bit Readable and Writable (1)
                            ;0: Read only (Data Segments); Execute only (Code Segments)
                            ;1: Read and write (Data Segments); Read and Execute (Code Segments) 
                        ;1 bit expansion direction (0)
                        ;1 bit executable segment (1 data, 0 code) (1)
                        ;1 bit Descriptor Bit (1)
                            ;0: System Descriptor
                            ;1: Code or Data Descriptor
                        ;2 bit Descriptor Privilege Level (0)
                            ;0: (Ring 0) Highest
                            ;3: (Ring 3) Lowest
                        ;1 bit Segment is in memory (Used with Virtual Memory) (1)
    granularity:
        db 11001111b 
                        ;3 bits Bits 16-19 of the segment limit
                            ;in this case is F, so if we sum with the lower segment we have FFFF
                        ;1 bit reserved for the os
                        ;1 bit reserved, should be 0
                        ;1 bit segment type:
                            ;0 16 bits
                            ;1 32 bits
                        ;1 bit granularity
                            ;0 none
                            ;1 limits get multiplied by 4k
    base_high:
        db 0 			;Bits 24-32 of the base address
                        
 ;data descriptor:
	dw 0FFFFh 			; limit low (Same as code)
	dw 0 				; base low
	db 0 				; base middle
	db 10010010b 		; access
	db 11001111b 		; granularity
    
	db 0				; base high


end_of_gdt:
toc:
	dw end_of_gdt - gdt_data - 1 	; limit (Size of GDT)
	dd gdt_data 			        ; base of GDT

InstallGDT: 
	cli				    ; clear interrupts
	pusha				; save registers
	lgdt 	[toc]		; load GDT into GDTR
	sti				    ; enable interrupts
	popa				; restore registers
	ret				
