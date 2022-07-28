.model small
.stack 100h
.data
v1 db 1,5,6,3,7,4
key db ?
.code
	start:
	mov ax, @data
	mov ds, ax


		mov si, OFFSET v1
		mov CX, lengthof v1
		 L7:
		 	mov dl, [si]
		 	add dl, 48
		 	mov ah, 02
		 	int 21h
			mov DL, ','
			mov AH, 02
			int 21h		 	
		 	inc si
		 loop L7
		 
		mov DL, 10
		mov AH, 02
		int 21h		 	
	
	mov AH,01
	int 21H
	sub al, 48
	mov key, al
	
		mov DL, 10
		mov AH, 02
		int 21h
	
		
	mov CX, lengthof v1
	mov si, offset v1
	L1:
		mov al, [si]
		cmp key, al
		je swp
		inc si
	loop L1
	
		
	mov CX, lengthof v1
	mov si, offset v1
	L2:
		mov al, 3
		mov [si], al
		inc si
	loop L2
	
	L6:
		mov si, OFFSET v1
		mov CX, lengthof v1
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
	jmp ed	 
	 
	swp:
		mov al, 2
		mov [si], al
		jmp L6	 
		
		
	ed:	 		
	mov AH, 4CH
	int 21h
	end start	
				
