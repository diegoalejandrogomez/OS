./Clean.sh
nasm -f bin -o bootloader.bin boot.asm 
nasm -f bin -o setup.bin setup.asm

( dd if=bootloader.bin  bs=512 count=1
  dd if=setup.bin bs=512 count=2879  ) > MisticOS.img

qemu-system-x86_64 -fda MisticOS.img
