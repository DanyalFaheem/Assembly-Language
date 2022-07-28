.model small
.stack 100h
.data
var db 0
count db 0
msg db "Enter your string: ",'$'
msg1 db "Enter your key: ",13,10,'$'
msg2 db "Encrypted key is: ",'$'
msg3 db "Decrypted key is: ",'$'
str1 db 50 dup('$')
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
	
		mov AH, 01
		int 21h
		add var, al
		sub al, 48
		mov al, 10
		mul var
		mov var, al
		mov AH, 01
		int 21h
		sub al, 48		
		add var, al
		
	mov si, offset str1
	L1:
		mov al, [si]
		cmp al, 13
		je print
		add al, var
		;mov dl, al
		;sub dl, var
		;mov ah, 02
		;int 21h
		mov bl, 122
		cmp al, bl
		jb rotate
		sub al, 122
		mov bl, 'a'
		add bl, al
		mov [si], bl
		
		temp:
			inc si
		jmp L1
	
	rotate:
		;mov DL, 'P'
		;mov ah, 02
		;int 21h
		mov [si], al
		jmp temp	
		
	print:
	mov DX, offset msg2
	mov AH,09
	int 21h	
	
	mov DX, offset str1
	mov AH,09
	int 21h	
	
	mov Ah, 4ch
	int 21h
	end start
		
		
