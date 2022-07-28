.model small
.stack 100h
.data
var1 db 25
var2 db ?
.code
	start:
	mov ax, @data
	mov ds, ax

	mov AH, 01
	int 21h
	
	mov var2, AL
	
	add var2, 48
	
	mov AH, 00
	mov AL, 25
	
	mov BL, var2
	Div BL
	
	mov dl, '1' ;command just to check execution of program
	mov AH, 02
	int 21h
	
	mov AH, 4CH
	int 21h
	
	end start 
