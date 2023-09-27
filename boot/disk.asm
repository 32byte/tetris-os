disk_load:
	pusha
	push dx

	mov ah, 0x02	; read mode
	mov al, dh	  ; read dh number of sectors
	mov cl, 0x02	; start from sector 2
					; (sector 1 is boot sector)
	mov ch, 0x00	; cylinder 0
	mov dh, 0x00	; head 0

	; dl = drive number (input to disk_load)
	; es:bx = buffer pointer (also input)

	int 0x13		; BIOS interrupt to read
	jc disk_error   ; check carry bit for error

	pop dx		  ; get back original number
	cmp al, dh	  ; check if all sectors read
	jne sectors_error

	popa
	ret

disk_error:
	; TODO: handle disk error
	jmp $

sectors_error:
	; TODO: handle sectors error
	jmp $
