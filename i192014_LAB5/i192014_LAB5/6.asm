.model small
.stack 100h
.data
v1 db ?
v2 db ?
.code
	start:
	mov ax, @data
	mov ds, ax

	mov AH,01
	int 21H
	
	mov v1, AL
	;add v1, 48
	
	mov DL, '*'
	mov AH, 02
	int 21h
	
	mov AH,01
	int 21H
	
	mov v2, AL
	;add v2, 48
	
	mov al, v1
	
	mov bl, v2

	mul bl
	
	mov v2, AL
	
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
	
	
	
	
	
