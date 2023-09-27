# $@ = target file
# $< = first dependency
# $^ = all dependencies

all: run

kernel.bin: kernel-entry.o kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel-entry.o: kernel/kernel-entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel/main.c
	gcc -m32 -ffreestanding -fno-pie -c $< -o $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

os-image.bin: boot.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -hda $<

clean:
	rm *.bin *.o