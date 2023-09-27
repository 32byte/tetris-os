# NOTE-to-self: useful variables
# $@ = target file
# $< = first dependency
# $^ = all dependencies

CC=gcc
CFLAGS=-m32 -ffreestanding -fno-pie
AS=nasm
LD=ld
LDFLAGS=-m elf_i386 -Ttext 0x1000 --oformat binary

BUILDDIR=build
KERNELSRC=kernel

dir_guard=@mkdir -p $(@D)

all: run

$(BUILDDIR)/kernel.bin: $(BUILDDIR)/kernel-entry.o $(BUILDDIR)/kernel.o
	$(dir_guard)
	$(LD) $(LDFLAGS) $^ -o $@

$(BUILDDIR)/kernel-entry.o: $(KERNELSRC)/kernel-entry.asm
	$(dir_guard)
	$(AS) -f elf $< -o $@

$(BUILDDIR)/kernel.o: $(KERNELSRC)/main.c
	$(dir_guard)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILDDIR)/boot.bin: boot.asm
	$(dir_guard)
	$(AS) $< -f bin -o $@

$(BUILDDIR)/os-image.bin: $(BUILDDIR)/boot.bin $(BUILDDIR)/kernel.bin
	$(dir_guard)
	cat $^ > $@

run: $(BUILDDIR)/os-image.bin
	qemu-system-i386 -hda $<

clean:
	rm -rf build