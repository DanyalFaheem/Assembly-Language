.model small
.stack 100h
.data
var1 db 255
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov ax,0
	mov al, 255
	mov bl, var1
	
	mul bl
	
	mov AH,4CH
	int 21h
	end start
