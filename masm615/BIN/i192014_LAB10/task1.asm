.model small
.stack 100h
.data
x dw 200
y dw 200
With dw 200
Height dw 100
colour db 3
.code
	start:
	mov ax, @data
	mov ds, ax

    main PROC 
        
        call DrawRectangle
        Untilesc:
             mov AH,01
                int 16H
                JNZ outta
                jmp Untilesc 
            outta:      
                mov AH,00   
                INT 16H
                cmp AL, 27
                jne Untilesc 
                jmp ed
        ed:
        mov AH, 4ch
        int 21h
    main ENDP

    DrawRectangle PROC uses AX BX CX DX 
        mov AL, 12H
        mov AH, 0
        int 10h
        mov CX, x
        add CX, with
        mov DX, y
        add DX, Height
        L1:
            mov CX, x
            add CX, with
            L2:
            mov AL, colour
            mov AH, 0CH
            int 10h
            dec CX
            cmp CX, x
            jne L2
            dec DX
            cmp DX, y
            je outt
            jmp L1
        outt:    
        RET
    DrawRectangle ENDP
    end start