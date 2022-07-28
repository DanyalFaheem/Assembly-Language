.model small
.stack 100h
.data
v1 db ?
v2 db ?
v3 db ?
.code
	start:
	mov ax, @data
	mov ds, ax

	mov AH,01
	int 21H
	
	mov v1, AL
	add v1, 48
	
	mov DL, '+'
	mov AH, 02
	int 21h
	
	mov AH,01
	int 21H
	
	mov v2, AL
	add v2, 48
	
	mov bl, v1
	
	add bl, v2
	
	mov v1, bl
	
	mov v2, bl
	
	mov DL, '-'
	mov AH, 02
	int 21h
	
	mov AH,01
	int 21H
	
	mov v3, AL
	add v3, 48
	
	mov bl, v3
	
	sub v2, bl
	
	mov DL, '='
	mov AH, 02
	int 21h
	
	mov DL, v2
	sub DL, 48
	mov AH, 02
	int 21h
	
	mov AH, 4CH
	int 21h
	
	end start 
	
	
	
	
	
