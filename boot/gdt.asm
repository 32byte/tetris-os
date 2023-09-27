; null segment descriptor (8 0x0 bytes)
gdt_start:
	dq 0x0

; code segment descriptor
gdt_code:
	dw 0xFFFF		; segment length
	dw 0x0			; segment base (bits 0-15)
	db 0x0			; segment base (bits 16-23)
	db 10011010b	; flags (8 bits)
	db 11001111b	; flags (4 bits) + segment length
	db 0x0			; segment base (bits 24-31)

; data segment descriptor
gdt_data:
	dw 0xFFFF		; segment length
	dw 0x0			; segment base (bits 0-15)
	db 0x0			; segment base (bits 16-23)
	db 10010010b	; flags (8 bits)
	db 11001111b	; flags (4 bits) + segment length
	db 0x0			; segment base (bits 24-31)

gdt_end:

; GDT descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1	; size (16 bits)
	dd gdt_start				; base (32 bits)

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start