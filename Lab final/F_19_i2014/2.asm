.model small
.stack 100h
.data
dummy db 0
msg db "Please press your button(Lowercase d/q/t)", 13, 10, '$'
.code
start:
mov ax, @data
mov ds, ax


loopp:
mov dx, word PTR OFFSET msg
mov ah, 09
int 21h
mov ah, 01
int 21h
cmp al, 'd' ;If d pressed, print date
je datepro
cmp al, 't'
je timepro ;If t pressed, print time
cmp al, 'q'
je ed
temp:
jmp loopp ;Keep looping until q is pressed

timepro: 
	call timeproc
	jmp temp
	
datepro:
	call dateproc
	jmp temp	

ed:
mov ah, 4ch
int 21h

dateproc proc uses ax ;Function to get date and print it
mov dl, 10
	mov ah, 02
	int 21h
mov ah, 2ah
int 21h
mov ah, 0 ;Moving values and displaying them accordingly
mov al, dl
call display
mov al, dh
call display
mov ax, cx
call display
mov dl, 13
	mov ah, 02
	int 21h
mov dl, 10
	mov ah, 02
	int 21h
ret
dateproc endp

timeproc proc uses ax ;Procedure to get time and print it
mov dl, 10
	mov ah, 02
	int 21h
mov ah, 2ch ;Moving values and printing them
int 21h
mov ah, 0
mov al, ch
call display
mov al, cl
call display
mov al, dh
call display
mov dl, 13
	mov ah, 02
	int 21h
mov dl, 10
	mov ah, 02
	int 21h
ret
timeproc endp

display proc uses ax bx cx dx ; Procedur to display multidigit values ;Prints whatever value is in AX
	mov bx, 10
	mov cx, 0
	mov dx, 0
	
	L1:
		mov dx, 0
		div bx ;Dividing by 10 to get remainder
		push dx ;Pushing remainder onto stack
		inc cx
		cmp ax, 0 ;Checking if value is 0 to break
		jne L1
	
	L2:
		pop dx ;Popping remainders in opposite
		add dx, 48
		mov ah, 02
		int 21h
		loop L2
		mov dl, '/'
		mov ah, 02
		int 21h
	Ret
	display endp    
	end start
