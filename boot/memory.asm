;*********************************************
;	memory.asm
;		- Memory layout
;*********************************************
;http://wiki.osdev.org/Memory_Map_(x86)

; start 	    end 	    size 	                type 	                                description
;Low Memory (the first MiB)
;0x00000000 	0x000003FF 	1 KiB 	                RAM - partially unusable (see above) 	Real Mode IVT (Interrupt Vector Table)
;0x00000400 	0x000004FF 	256 bytes 	            RAM - partially unusable (see above) 	BDA (BIOS data area)
;0x00000500 	0x00007BFF 	almost 30 KiB 	        RAM (guaranteed free for use) 	        Conventional memory
;0x00007C00  	0x00007DFF 	512 bytes 	            RAM - partially unusable (see above) 	Your OS BootSector
;0x00007E00 	0x0007FFFF 	480.5 KiB 	            RAM (guaranteed free for use) 	        Conventional memory
;0x00080000 	0x0009FBFF 	approximately 120 KiB 	RAM (free for use, if it exists) 	    Conventional memory
;0x0009FC00  	0x0009FFFF 	1 KiB 	                RAM (unusable) 	                        EBDA (Extended BIOS Data Area)
;0x000A0000 	0x000FFFFF 	384 KiB 	            various (unusable) 	                    Video memory, ROM Area 

;*********************************************
;	Custom Memory Map
;*********************************************

; start 	    end 	    size 	                type            description
;0x00000500 	0x00000519  32 bytes    	        RAM  	        String Messages
;0x00000520 	0x00007BFF  30.431 bytes    	    RAM  	        Free
;0x00007C00  	0x00007DFF 	512 bytes 	            RAM             BootSector
;0x00007E00 	0x0007FFFF 	480.5 KiB 	            RAM  	        Free
;0x00080000 	0x0009FBFF 	approximately 120 KiB 	RAM             free for use, if it exists

STRING_HANDLER_ADDRESS equ 0x0:0x0500
BOOT_LOADER_ADDRESS equ 0x0:0x7C00
SETUP_ADDRESS equ 0x0:0x0520
SETUP_LENGHT  equ 1