.model small
.stack 100h
.data
var1 dw 65535
var2 db 2
var3 dw 2
.code
	start:
	mov ax, @data
	mov ds, ax

	mov DX, 0
	mov AX, var1
	mov BX, var3
	
	Div BX
	
	mov AX, 256
	
	mov BL, var2
	
	div BL
	
	
	mov dl, '1' ;command just to check execution of program
	mov AH, 02
	int 21h
	
	mov AH, 4CH
	int 21h
	
	end start 
