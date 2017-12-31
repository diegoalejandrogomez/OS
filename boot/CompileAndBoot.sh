./Clean.sh
nasm -f bin -o bootloader.bin boot.asm 
nasm -f bin -o setup.bin setup.asm

#Lets create a virtual floppy
dd if=/dev/zero of=MisticOS.img bs=512 count=2880

#copy bootloader to the first sector
dd if=bootloader.bin of=MisticOS.img conv=notrunc 

#Copy setup to sector 2
dd if=setup.bin of=MisticOS.img bs=512 seek=1 conv=notrunc


qemu-system-x86_64 -fda MisticOS.img
