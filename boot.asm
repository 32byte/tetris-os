; Master boot record, this program will be copied to
; 0000:7C00 by the BIOS and is running in 16-bit mode.
[bits 16]
[org 0x7c00]

; Where to load the kernel to
	KERNEL_OFFSET equ 0x1000

; BIOS sets the boot drive in 'dl', store for later
	mov [BOOT_DRIVE], dl

; Setup stack (NOTE-to-self: bp is base stack pointer)
	mov bp, 0x9000
	mov sp, bp

	call load_kernel
	call switch_to_32bit

	jmp $

%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/switch-to-32bit.asm"

[bits 16]
load_kernel:
	mov bx, KERNEL_OFFSET   ; bx -> destination
	mov dh, 2			   ; dh -> sector count
	mov dl, [BOOT_DRIVE]	; dl -> disk
	call disk_load
	ret

[bits 32]
BEGIN_32BIT:
	call KERNEL_OFFSET  ; give control to kernel
	jmp $			   ; loop in case kernel returns


; Variables
BOOT_DRIVE: db 0

; Padding
times 510-($-$$) db 0   ; Pad remainder with 0s
dw 0xAA55			   ; Boot signature
