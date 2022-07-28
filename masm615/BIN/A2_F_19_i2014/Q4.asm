.model large
.stack 100h
.data
Str1 db 30 dup('$')
Check_brackets db 1
msgagain db 10, "If you want to enter another string, press Y else press any other character", '$'
msg1 db 10, "Please enter your string: ", '$'
msgy db 10, "Incorrect Brackets", '$'
msgn db 10, "Correct Expression!", '$'
.code
	jmp start
    BracketsCheck PROC uses AX BX CX DX
        mov bp, sp
        mov AX, [bp + 4]
        mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string
        CheckLabel:
            mov al, [si]
            cmp al, '{' ;Checking if opening bracket achieved
            je outttt
            inc si
            loop CheckLabel
        mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string           
         CheckLabel1:
            mov al, [si]
            cmp al, '(' ;Checking if opening bracket achieved
            je outttt
            inc si
            loop CheckLabel1
       mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string            
         CheckLabel2:
            mov al, [si]
            cmp al, '[' ;Checking if opening bracket achieved
            je outttt
            inc si
            loop CheckLabel2
       mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string            
         CheckLabel6:
            mov al, [si]
            cmp al, '}' ;Checking if closing bracket achieved
            je outttt
            inc si
            loop CheckLabel6
        mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string           
         CheckLabel3:
            mov al, [si]
            cmp al, ')' ;Checking if closing bracket achieved
            je outttt
            inc si
            loop CheckLabel3
       mov CX, lengthof Str1 ; Length of string
        mov si, offset Str1 ; To traverse string            
         CheckLabel4:
            mov al, [si]
            cmp al, ']' ;Checking if closing bracket achieved
            je outttt
            inc si
            loop CheckLabel4 
        outttt:
        RET
    BracketsCheck ENDP
    CheckExpression Macro 
        mov DX, offset msg1
        mov AH, 09
        int 21h 
        input:
            mov ah, 01
            int 21h
            cmp al, 13 ; Checking if enter is pressed
            je outta
            .If al == '[' || al == '(' || al == '{' ; Checking if bracket matches
            mov Ah, 0
            push ax ; Pushing onto Stack to be checked
            .ENDIF
            .IF al == ']' || al == ')' || al == '}' ;Checking if closing bracket achieved
            pop BX  ; To compare last element in stack with new element
                .IF al == ']' && bl != '[' ;Checking for correct number of brackets
                    jmp false
                .ENDIF    
                .IF al == ')' && bl != '(' ;Checking for correct number of brackets
                    jmp false
                .ENDIF    
                .IF al == '}' && bl != '{' ;Checking for correct number of brackets
                    jmp false
                .ENDIF   
            .ENDIF     
            jmp input  
            outta:
            cmp Check_brackets, 0
            ;je false
            pop AX ; To check if stack is holding extra brackets
            .If al == '[' || al == '(' || al == '{' ;Checking for correct number of brackets 
                    jmp false
            .ENDIF
            jmp true
            false:
                 mov DX, offset msgy
                    mov AH, 09
                    int 21h
                    jmp ed
            true:        
            mov DX, offset msgn
            mov AH, 09
            int 21h    
            ed:
    ENDM
    start:
	mov ax, @data
	mov ds, ax
    main PROC
        AskAgain:
            CheckExpression ;Calling to check Expression
            mov DX, offset msgagain
            mov AH, 09
            int 21h
            mov AH, 07 ; Taking non echo input for new string input
            int 21h
            cmp al, 'Y' ; Checking if they want to enter again
            je AskAgain
            cmp al, 'y' ; Checking if they want to enter again
            je AskAgain
        
        mov Ah, 4ch
        int 21h
    main ENDP
    end start