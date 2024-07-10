
myos.iso: myos.bin grub.cfg isodir/boot/grub
	cp myos.bin isodir/boot/
	cp grub.cfg isodir/boot/grub/
	nix-shell -p grub2 xorriso --run 'grub-mkrescue -o myos.iso isodir'

isodir/boot/grub:
	mkdir -p isodir/boot/grub

boot.o: boot.s
	nix-shell --run '$AS boot.s -o boot.o' shell.nix

kernel.o: kernel.c
	nix-shell --run '$CC -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra' shell.nix

myos.bin: kernel.o boot.o
	nix-shell --run '$CC -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc' shell.nix


clean:
	rm myos.bin
	rm myos.iso
	rm boot.o
	rm kernel.o
