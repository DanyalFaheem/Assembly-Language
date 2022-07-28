.model small
.stack 100h
.data
v1 db ?
v2 db 1
print db 1
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

    mov CL, v1
    mov CH, 0
    
    L1:
        mov BX, CX
        cmp CX, 1
        je temp
        dec CX
       L2:
          mov DL, ' '
          mov AH, 02
          int 21H
        loop L2
        
        temp:


        mov CL, v2
        mov CH, 0
        
        L3:
            mov DL, print
            add DL, 48
            mov AH, 02
            int 21H   
        loop L3    
        
        mov CX, BX
        add v2, 2
        inc print
        mov DL, 10
        mov AH, 02
        int 21H
       
    loop L1

    mov AH, 4CH
    int 21H

    end start