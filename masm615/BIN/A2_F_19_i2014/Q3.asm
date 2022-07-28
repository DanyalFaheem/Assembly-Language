.model large
.stack 100h
.data
V1 dw ?
count db 0
digits db 0
multiplicant db 1, 10, 100
msg db 10, "Enter your number: ",'$'
msginput db "Please only enter between 1 - 100", '$'
msgperfect db "The entered number is Perfect!", 13, 10, '$'
msgnperfect db "The entered number is not Perfect!", '$'
.code
	start:
	mov ax, @data
	mov ds, ax
    main PROC 
        call input ; Taking input
        push v1 ; Passing parameter to function
        call perfect
        mov AH, 4ch
        int 21h
    main ENDP
    perfect PROC 
        mov bp, sp
        mov CX, [bp + 4] ; moving value of input into Counter
        shr CL, 1 ; Dividing by 2 as we know factor can't be bigger
        L1:
            mov AX, [bp + 4] ; Getting value of input
            mov BL, CL
            mov BH, 0
            div BL
            cmp AH, 0 ; Checking if remainder zero
            jne jump
            push CX ; Pushing factors onto stack
            inc count ; To hold number of factors
            jump:
           loop L1
        mov CL, count ; Moving number of factors into counter
        mov CH, 0
        mov BX, 0
        L2:
            pop AX
            Add BX, AX ; Adding the values back
        loop L2   
        cmp BX, [bp + 4] ; Comparing if sum equal to input
        je prft
        mov DX, offset msgnperfect
        mov AH, 09
        int 21H
        RET 2
        prft:
         mov DX, offset msgperfect
        mov AH, 09
        int 21H
        mov count, 0
         mov CX, [bp + 4]
        shr CL, 1
        L3:
            mov AX, [bp + 4]
            mov BL, CL
            mov BH, 0
            div BL
            cmp AH, 0
            jne jummp
            push CX
            inc count
            jummp:
           loop L3
        mov CL, count
        dec CL
        mov CH, 0
        mov BX, 0
        L4:
            pop AX
            call display ; Printing the factors
        loop L4   
        pop AX
        call display
        mov Dl, '='
        mov AH, 02
        int 21H
        mov AX, [bp + 4]
        call display 
        RET 2
    perfect ENDP

    input PROC uses AX BX CX DX
    Again:
        mov v1, 0
        mov digits, 0
        mov DX, offset msg
    mov AH, 09
    int 21h
	mov di, offset multiplicant
    iput1:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp iput1
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    cmp AX, 100
    jbe return
    mov DX, offset msginput
    mov AH, 09
    int 21h
    jmp Again
    return:
        RET
    input ENDP

    
  display   proc  uses AX BX CX DX      ;Whatever value is in AX is in displayed
   MOV BX, 10     
   MOV DX, 0  
   MOV CX, 0       
loop1:  
   MOV DX, 0   
   div BX      
   PUSH DX     
   INC CX      
   CMP AX, 0     
   JNE loop1     
    
loop2:  
   POP DX      
   ADD DX, 48     
   MOV AH, 02H     
   INT 21H      
   LOOP loop2    
   mov DL, '+'
   mov AH, 02
   int 21h
   RET      
display  ENDP   
    end start