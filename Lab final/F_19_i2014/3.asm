.model small
.stack 100h
.data
msg db "Please Enter your string", 13, 10, '$'
str1 byte 100 dup('$') ;First string for input
str2 byte 100 dup('$') ; copy string
.code

start:
mov ax, @data
mov ds, ax
mov dx, word PTR offset msg
mov ah, 09
int 21h
 
mov dx, word PTR offset str1 ; Taking input from user
mov ah, 3fh
int 21h

mov si, offset str1
mov di, offset str2

l1:
	mov al, [si]
	cmp al, 13 ;Checking for endline
	je endline
	call check ;Calling procedure to check
	cmp cl, 0 ;Checking if value to be removed
	je swap
	temp:
		inc si
		jmp l1

swap:
	mov bl, ' ' ;swapping with space
	mov [si], bl
	jmp temp
	
endline: ;Copying into otherr string
mov si, offset str1
	l2: 
	  mov al, [si]
	  mov [di], al	
	  cmp al, 13
	  je ed
	  inc si
	  inc di
	  jmp l2
	  
ed:
mov dl, 'P'
mov ah, 02
;int 21h
mov dx, offset str1 ; Displaying string
mov ah, 09
int 21h	  

mov ah, 4ch
int 21h
check proc uses ax ;Procedure to check if valid or invalid value
cmp al, 'z' ;If not lowercase alphabet
ja chck2
cmp al, 'A' ;if not uppercase
jb chck2
jmp chck3
chck2:
cmp al, '.' ;If not .
je chck3
cmp al, ',' ;If not ,
je chck3
cmp al, ' ' ;If not space
je chck3
mov cl, 0 ; Move 0 to say that false and value should be replaced with space
ret
chck3:
	mov cl, 1
	ret
check endp
	end start
