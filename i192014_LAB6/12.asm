.model small
.stack 100h
.data
v1 db ?
.code
	start:
	mov ax, @data
	mov ds, ax

	mov AH,01
	int 21H
	
	mov v1, AL
	sub v1, 48
	
	mov DL, 10
	mov AH, 02
	int 21h
	
	cmp v1, 4
	ja med

	mov DL, 'L'
	mov AH, 02
	int 21h
	mov DL, 'O'
	mov AH, 02
	int 21h
	mov DL, 'W'
	mov AH, 02
	int 21h
	jmp ed
	med:
		cmp v1, 6
		ja hi
		mov DL, 'M'
		mov AH, 02
		int 21h
		mov DL, 'E'
		mov AH, 02
		int 21h
		mov DL, 'D'
		mov AH, 02
		int 21h
		mov DL, 'I'
		mov AH, 02
		int 21h
		mov DL, 'U'
		mov AH, 02
		int 21h
		mov DL, 'M'
		mov AH, 02
		int 21h
	jmp ed
	hi:
		mov DL, 'F'
		mov AH, 02
		int 21h
		mov DL, 'U'
		mov AH, 02
		int 21h
		mov DL, 'L'
		mov AH, 02
		int 21h
		mov DL, 'L'
		mov AH, 02
		int 21h
	ed:
		mov AH, 4CH
		int 21H
		end start
