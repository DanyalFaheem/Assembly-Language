.model small
.stack 100h
.data
var db 0
count db 0
msg db "Enter your string: ",'$'
msg1 db "Enter your letter to be replaced: ",'$'
msg2 db "Enter your letter to be replaced with: ",'$'
msg3 db "Modified string is: ",'$'
str1 db 50 dup('$')
key db ?
key1 db ?
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov DX, offset msg
	mov AH,09
	int 21h
	
	mov DX, offset str1
	mov AH, 3FH
	int 21h
	
	mov DX, offset msg1
	mov AH,09
	int 21h	
	
	mov ah, 01
	int 21h
	mov key, al
	mov DL, 10
	mov Ah, 02
	int 21h

	mov DX, offset msg2
	mov AH,09
	int 21h	
	mov ah, 01
	int 21h
	mov key1, al	
	mov DL, 10
	mov Ah, 02
	int 21h

	mov si, offset str1
	L1:
		mov al, [si]
		cmp al, 13
		je ed
		cmp al, key
		je swap
		temp:
			inc si
		jmp L1
	
	swap:
		mov al, key1
		mov [si], al
		jmp temp

	ed:
		mov DX, offset msg3
		mov AH,09
		int 21h
		mov DX, offset str1
		mov AH, 09
		int 21h
		mov AH, 4ch
		int 21h
		end start


	
	
		
	
