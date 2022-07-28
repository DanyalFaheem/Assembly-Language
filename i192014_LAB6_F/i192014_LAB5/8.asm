.model small
.stack 100h
.data
v1 db 9 dup('$')
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 9
	mov si, offset v1
	L1:
	
		mov AH,01
		int 21H
		
		sub al, 48
		mov [si], al
		add si, 1
		mov DL, 10
		mov AH, 02
		int 21h
	loop L1
	
	mov CX, 9
	mov si, offset v1
	L2:
		mov DX, CX
		mov si, OFFSET v1
		mov CX, 8
		L3:
			mov al, [si]
			cmp [si + 1], al	
			ja swp
			L4:	
				;mov DL, al
				;mov AH, 02
				;int 21h				
				inc si
				
		loop L3
		mov CX, DX
	loop L2
	jmp L6
	
	swp:
		mov bl, [si + 1]
		mov [si + 1], al
		mov [si], bl
		jmp L4
	
	L6:
	mov si, OFFSET v1
	mov CX, 3
	 L5:
	 	mov dl, [si]
	 	add dl, 48
	 	mov ah, 02
	 	int 21h
		mov DL, ','
		mov AH, 02
		int 21h		 	
	 	inc si
	 loop L5
	 		
	mov AH, 4CH
	int 21h
	end start	
					
