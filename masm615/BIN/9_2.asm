.model small
.stack 100h
.data
v1 dw ?
digits db 0
multiplicant db 1, 10, 100
arr dw 2 dup('$')
msg db "Enter your Number: ", '$'
part2 db 10, "Q2 part 2 begins here: ", 10,'$'
msg1 db "Enter your string: ", '$'
strinp db "Danyal Faheem", '$'
str_copy db 50 dup('$')
.code
	start:
    Larger macro var, var2
    mov Ax, var
    cmp AX, var2
    ja move
    mov AX, var2
    move:
    endm
    strcpy macro str1, str2
        mov si, offset str1
        mov di, offset str2
        L1:
            mov AL, str1
            cmp AL, '$'
            mov DL, AL
            ;add DL, 48
            ;mov AH, 02
            ;int 21h
            je outt
            mov str2, AL
            inc str1
            inc str2
            jmp L1
        outt:        
    endm
      main PROC 
    mov ax, @data
	mov ds, ax
    call input1
    mov BX, offset arr
    mov AX, [bx]
    Larger AX, v1 ; Macro for task 1
    mov DX, offset part2
    mov Ah, 09
    int 21H
    
    
    strcpy strinp, str_copy ; Macro for task 2
    mov DX, offset str_copy
    mov AH, 09
    ;int 21h
    mov ah, 4ch
    int 21h
    main endp
    input1 PROC
    mov CX, 2
    mov si, offset arr
    inp: 
    mov v1, 0
    mov DX, offset msg
    mov AH, 09
    int 21h
	mov di, offset multiplicant
    mov DX, CX 
    mov digits, 0
    inputs:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp inputs
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            ;mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    mov [si], AX
    inc si
    mov CX, DX
    loop inp 
        RET
    input1 ENDP
            display   proc       ;Whatever value is in AX is in displayed
    push AX
    push BX
    push CX
    push DX
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
   pop DX
   pop CX
   pop BX
   pop AX
   RET       
display  ENDP   
    end start