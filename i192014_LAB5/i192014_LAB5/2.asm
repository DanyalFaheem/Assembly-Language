.model small
.stack 100h
.data
var1 dw 255
var2 dw 1024
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov ax, var1
	mov bx, var2
	
	mul bx
	
	mov dl, '1' ;command just to check execution of program
	mov AH, 02
	int 21h
	mov AH, 4CH
	int 21h
	
	end start
