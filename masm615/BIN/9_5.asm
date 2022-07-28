.model small
.stack 100h
.data
.code
	start:
      main PROC 
      mov ax, @data
	mov ds, ax
        .while ax < bx
            inc ax
            .if dx == bx
                mov cx, 2
            .else
                mov cx, 3
            .endif        
        .endw
    mov AH, 4ch
    int 21h    
     main ENDP
     end start
       