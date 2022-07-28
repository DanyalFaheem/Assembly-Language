.model small
.stack 100h
.data
v1 db 8 dup(?)
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 8
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
	
	
	mov CX, 4
	mov si, offset v1	
	
		mov AH, 01
		int 21H	
		cmp AL, 66
		je pl44		
		cmp AL, 65
		je p4
	

	p4:
		mov dl, [si]
		add dl, 48
		mov AH, 02
		int 21h
		inc si
		mov DL, ','
		mov AH, 02
		int 21h					
	loop p4
	jmp ed	
			
	pl44:
		mov si, offset v1
		add si, 4
		mov CX, 4
			p5:
			mov dl, [si]
			add dl, 48
			mov AH, 02
			int 21h
			inc si
			mov DL, ','
			mov AH, 02
			int 21h					
		loop p5					

	ed:
		mov AH, 4CH
	int 21h
	
	end start 	
