.model small
.stack 100h
.data
count db 0
msg db "Enter your string: ",'$'
msg1 db "Enter your word: ",'$'
str1 db 50 dup('$')
key db 10 dup('$')
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

	mov DX, offset key
	mov AH, 3FH
	int 21h	
	
	mov si, offset str1
	
	L1:
		mov count, 0
		mov di, offset key
		L2:
			mov al, [si]
			mov bl, [di]
			cmp al, bl
			jne again
			add count, 1
			inc si
			inc di
			mov cl, [di]
			cmp cl, 13
			je swap
			jmp L2
		again:	
			inc si
		mov cl, [si]
		cmp cl, 13
		je ed
		jmp L1
		
	swap:
		mov al, count
		mov ah, 0
		sub si, AX
		sub di, AX
		mov CL, count
		mov CH, 0
		L3:	
			mov al, [si]
			sub al, 32
			mov [si], al
			inc si
		loop L3	
	jmp L1	
			
			
	ed:
	mov DX, offset str1
	mov AH, 09
	int 21h
	mov AH, 4CH
	int 21h
	end start
				
		
	
