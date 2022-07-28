.model small
.stack 100h
.data
val dw ?
arr db 0,1,1
.code
	start:
	mov ax, @data
	mov ds, ax
	main proc
	mov ah, 0
	mov di, offset arr
	mov si, offset arr
	mov al, [di] ;Printing first three values
	call display
	mov al, [di + 1]
	call display
	mov al, [di + 2]
	call display 
	print:
		call addd ;Function to add three elemts
		call display
		call shift ;Procedure to shift values in arrays
		cmp val, 20
		jb print
	mov ah, 4ch
	int 21h	
	main endp

addd proc ;Proc to add all three last values
mov cx, 3
mov ax, 0
mov di, offset arr
	ad:
	mov bl, [di]
	add al, bl
	;call display
	inc di
	loop ad
	mov val, ax ;Keeping values in val
	Ret	
addd endp

shift proc ; Proc to shift values in array to fit latest value
	mov di, offset arr
	mov al, [di+1]
	mov cl, [di+2]
	mov [di], al
	mov [di+1], cl
	mov ax, val
	mov [di+2], al
	ret
shift endp

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
mov dl, ' '
mov ah, 02
int 21h
	Ret
	display endp   
	end start
