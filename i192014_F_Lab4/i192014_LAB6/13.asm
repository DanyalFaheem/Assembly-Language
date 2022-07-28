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
	
	mov AL, v1
	mov AH, 0
	
	mov bl, 2

	div bl
	
	cmp ah, 0
	je eve

	mov CL, v1
	mov CH, 0
	sub CX, 2
	mov bl, 2
	L1:
		mov AL, v1
		mov AH, 0
		div bl
		cmp ah, 0
		je od
		inc bl
	loop L1
		mov DL, 'P'
		mov AH, 02
		int 21h
		mov DL, 'r'
		mov AH, 02
		int 21h
		mov DL, 'i'
		mov AH, 02
		int 21h
		mov DL, 'm'
		mov AH, 02
		int 21h
		mov DL, 'e'
		mov AH, 02
		int 21h
	jmp ed
	
	eve:
		mov DL, 'E'
		mov AH, 02
		int 21h
		mov DL, 'v'
		mov AH, 02
		int 21h
		mov DL, 'e'
		mov AH, 02
		int 21h
		mov DL, 'n'
		mov AH, 02
		int 21h
	jmp ed
	
	od:
		mov DL, 'O'
		mov AH, 02
		int 21h
		mov DL, 'd'
		mov AH, 02
		int 21h
		mov DL, 'd'
		mov AH, 02
		int 21h
	
	jmp ed
	
	ed: 
	mov AH, 4CH
		int 21H
		end start
	
