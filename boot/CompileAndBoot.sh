rm bootloader.bin
rm bootloader.img
nasm -f bin -o bootloader.bin boot.asm 

dd if=/dev/zero of=bootloader.img bs=5120 count=2880
dd status=noxfer conv=notrunc if=boot.bin of=bootloader.img
qemu-system-x86_64 bootloader.bin

