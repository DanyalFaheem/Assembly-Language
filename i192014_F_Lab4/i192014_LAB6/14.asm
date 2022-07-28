.model small
.stack 100h
.data

.code
	start:
	mov ax, @data
	mov ds, ax

	mov CX, 26
	mov bl, 65
	L1:
		mov DL, 10
		mov AH, 02
		int 21h
		mov dl, bl
		mov AH, 02
		int 21h
		inc bl
	loop L1
	
	mov AH,4CH
	int 21h
	end start	
