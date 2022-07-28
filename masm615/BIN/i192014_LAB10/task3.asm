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
            add x, 20
            cmp x, 440
            je Untilesc2
           call DrawRectangle
           call delay
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
        Untilesc2:
            sub x, 20
            cmp x, 0
            je Untilesc
           call DrawRectangle
           call delay
             mov AH,01
                int 16H
                JNZ outta2
                jmp Untilesc2
            outta2:      
                mov AH,00   
                INT 16H
                cmp AL, 27
                jne Untilesc2 
                jmp ed        
        ed:
        mov AH, 4ch
        int 21h
    main ENDP

    DrawRectangle PROC uses AX BX CX DX 
        mov AL, 12H
        mov AH, 0
        int 10h
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
    delay proc uses ax bx cx dx
mov cx,1000
mydelay:
mov bx,300      ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
mydelay1:
dec bx
jnz mydelay1
loop mydelay
ret
delay endp
    end start