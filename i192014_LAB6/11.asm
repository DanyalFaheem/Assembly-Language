.model small
.stack 100h
.data
v1 db ?
v2 db ?
v3 db ?
v4 db 0
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov AH,01
	int 21H
	
	mov v1, AL
	sub v1, 48
	
	mov DL, ','
	mov AH, 02
	int 21h
	
	mov AH, 01
	int 21H
	
	mov v2, AL
	sub v2, 48
	
	mov bl, v1
	
	mov DL, ','
	mov AH, 02
	int 21h
	
	mov AH,01
	int 21H
	
	mov v3, AL
	sub v3, 48

	add bl, v3
	mov v1, bl
	mov v3, bl

	mov CL, v1
	mov CH, 0
	dec CL
	L1:
		mov AL, v2
		mov AH, 0
		mul v2
		add v4, AL
	loop L1

	mov DL, '='
	mov AH, 02
	int 21h
	
	mov DL, v4
	add DL, 48
	mov AH, 02
	int 21h
	
	mov AH, 4CH
	int 21h
	
	end start 
