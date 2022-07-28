.model large
.stack 100h
.data
Str1 db 30 dup('$')
Str2 db 30 dup('$')
count1 dw 0
count2 dw 0
msg1 db "Please enter your string: ", '$'
msgy db "The entered strings are equal!", '$'
msgn db "The entered strings are not equal!", '$'
.code
	start:
	mov ax, @data
	mov ds, ax
    makeUpper1 macro strab ; To convert entire string into Uppercase
        mov si, offset strab
        Lm1:
            mov al, [si]
            cmp al, 13
            je edm
            add count1, 1
            cmp al, 96
            ja convert
            inc si
            jmp Lm1
            convert:
                sub al, 32
                mov [si], al
                inc si
                jmp Lm1
        edm:        
    endm
     makeUpper2 macro strb ; To convert entire string into Uppercase
        mov di, offset strb
        Lm2:
            mov al, [di]
            cmp al, 13
            je edm2
            add count2, 1
            cmp al, 96
            ja convert2
            inc di
            jmp Lm2
            convert2:
                sub al, 32
                mov [di], al
                inc di
                jmp Lm2
        edm2:
    endm
    main PROC 
        mov DX, offset msg1 ;Taking inputs
        call display_string
        mov DX, offset Str1
        mov AH, 3FH
        int 21h
        mov DL, 10
        mov AH, 02
        int 21h
        mov DX, offset msg1
       call display_string
        mov DX, offset Str2
        mov AH, 3FH
        int 21h
        mov AX, 0
        push AX ; Pushing return value onto stack
        makeUpper1 Str1 ; Converting into Uppercase
        makeUpper2 Str2
        mov si, offset Str1
        mov di, offset Str2
        push si ; Pushing offset as parameter
        push count1 ; Pushing size as parameter
        push di ; Pushing offset as parameter
        push count2 ; Pushing size as parameter
        call equalsIgnoreCase
        pop CX
        cmp CX, 1 ; Checking if function returned true or false
        jne fal2
        mov DX, offset msgy
        call display_string
         mov AH, 4ch
        int 21h
        RET
        fal2: ; If value is false
            mov DX, offset msgn
            call display_string
        mov AH, 4ch
        int 21h
        RET
    main ENDP
    equalsIgnoreCase PROC 
        mov bp, sp
        mov CX, [bp + 4] ; Taking size
        mov DX, [bp + 8] ; Taking size
        cmp CX, DX ; Checking if string sizes are same
        jne fale
        mov di, [bp + 6] ; Taking offset
        mov si, [bp + 10] ; Taking offset
        L1:
            dec CX
            dec DX
            mov al, [si]
            cmp al, 13
            je ed
            mov bl, [di]
            cmp al, 13
            je ed
            cmp al, bl ; Checking if value same
            jne ed
            inc si
            inc di
            jmp L1
        ed:
            cmp DX, CX
            jne fale
        mov CX, 1
        mov [bp + 12], CX  ; Moving return value onto position 
        RET 8
        fale:
            mov CX, 0
            mov [bp + 12], CX ; Moving return value onto position 
            RET 8    
    equalsIgnoreCase ENDP
    display_string PROC  uses AX BX CX ; Function to display string
        mov AH, 09
        int 21h
        RET
    display_string ENDP
end start