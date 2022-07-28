.model small
.stack 100h
.data
v1 db ?
v2 db 1
spaces dw 1
count dw 1
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov AH,01
	int 21H
	
	mov v1, AL
	sub v1, 48
	
	mov DL, 10
	mov AH, 02
	int 21h

    mov al, 2
    mov AH, 0
    mul v1
    mov spaces, AX
    sub spaces, 1
    mov AL, v2
    mov AH, 0
    push AX
    mov CL, v1
    mov CH, 0
    
    L1:
        mov BX, CX
        mov CX, spaces
       L2:
          mov DL, ' '
          mov AH, 02
          int 21H
          loop L2 
        

        mov CL, v2
        mov CH, 0
        
        L3:
            mov DL, '*'
            mov AH, 02
            int 21H  
            mov Dl, ' '
            mov AH, 02
            int 21H
        loop L3    
        
        mov CX, BX
        mov al, 2
        mov ah, 0
        mul v2
        mov ah, 0
        push ax
        mov v2, al
        mov BX, count
        sub spaces, bx
        inc count
        mov DL, 10
        mov AH, 02
        int 21H
       
    loop L1

    pop AX
    pop AX
    pop AX
    mov v2, al
    mov bx, count
    add spaces, bx
    add spaces, bx
    mov bl, v1
    mov bh, 0
    sub spaces, bx
    mov count, 1
    mov CL, v1
    mov CH, 0
    sub CX, 1
    
    L5:
        mov BX, CX
        mov CX, spaces
       L6:
          mov DL, ' '
          mov AH, 02
          int 21H
          loop L6 
        

        mov CL, v2
        mov CH, 0
        
        L7:
            mov DL, '*'
            mov AH, 02
            int 21H  
            mov Dl, ' '
            mov AH, 02
            int 21H
        loop L7    
        
        mov CX, BX
        pop ax
        mov v2, al
        mov BX, count
        add spaces, bx
        inc count
        mov DL, 10
        mov AH, 02
        int 21H
       
    loop L5

    mov AH, 4CH
    int 21h        

    end start

	