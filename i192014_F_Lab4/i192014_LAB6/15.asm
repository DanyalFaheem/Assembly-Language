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
	
    mov DL, 10
	mov AH, 02
	int 21h

	mov AH,01
	int 21H
	
	mov v2, AL
	sub v2, 48

	mov DL, 10
	mov AH, 02
	int 21h
	
	mov AH,01
	int 21H
	
	mov v3, AL
	sub v3, 48

    mov DL, 10
	mov AH, 02
	int 21h

    mov al, v2
    mov ah, 0
    mov bl, 3
    mul bl

    mov bl, 2
    div bl

    add v3, al

    mov al, v2
    mov ah, 0
    mov bl, 6
    mul bl
    sub al, v1
    mov ah, 0
    mul v3

    mov DL, al
    add DL, 48
    mov AH, 02
    int 21h

    mov AH, 4CH
    int 21h
    end start