.model small
.stack 100h
.data
H dw ?
space db -1
digits db 0
Newlinecount db 0
multiplicant db 1, 10, 100
msginput db "Please only enter between 1 - 24", 10, '$'
msg db "Enter Height h: ",'$'
x dw 40
y dw 0
.code
	start:
	mov ax, @data
	mov ds, ax

    main PROC 
        call input ; Taking input of height
        mov AX, h
        sub y, AX
        Loop1:
        call ClearScreen ; Calling clear screen
        call DrawTriangle ; Calling function to draw triangle
        call delay ; Calling delay after drawing
         mov AL, Newlinecount
         mov AH, 0
        add AX, H
        cmp AX, 24
        ja ed
        jmp Loop1
        ed:
        mov AH, 4ch
        int 21h
    main ENDP

    DrawTriangle PROC uses AX BX CX DX 
        mov CX, H ; Moving height into CX
        mov space, -1
        mov x, 40
        Mainloop:
            Push CX ; Storing value of CX
            mov BX, CX
            mov CX, x
            Spaces: ; Printing the spaces
               mov DL, ' '
               mov AH, 02
               int 21h
            loop Spaces
            mov DL, '*' ; Printing the asterisk
            mov AH, 02
            int 21h
            cmp space, -1 ; For first line
            je first
            cmp BX, 1 ; For last line
            je lastline
            mov CL, space
            mov CH, 0
            Spaces2: ; Printing the spaces
                mov DL, ' '
               mov AH, 02
               int 21h
            loop Spaces2  
            mov DL, '*' ; Printing the asterisk
            mov AH, 02
            int 21h
        first:
        pop CX
        ;call delay ; Calling delay before new line
         mov DL, 10 ; Gointo new line
        mov AH, 02
        int 21h
        sub x, 1
        add space, 2   
        loop Mainloop
        lastline: ; Printing the Last line
            pop CX
            mov CL, space
            mov CH, 0
            add CX, 1
            shr CL, 1
                line:
                    mov DL, ' ' ; Printing the spaces
                    mov AH, 02
                    int 21h
                    mov DL, '*' ; Printing the asterisk
                    mov AH, 02
                    int 21h
                loop line
            mov DL, 10
            mov AH, 02
            int 21h        
        RET
    DrawTriangle ENDP
    ClearScreen PROC uses AX BX CX DX
        mov AX, 03H
        int 10h
        mov CL, Newlinecount
        mov CH, 0
        newline:
            mov DL, 10
            mov Ah, 02
            int 21h
        loop newline
        inc Newlinecount    
        outtt:
        RET
    ClearScreen ENDP
       input PROC uses AX BX CX DX
       again:
       mov H, 0
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
            add H, AX
			inc di
        loop combine 
    mov AX, H
    cmp H, 24
    jbe return
    mov DX, offset msginput
    mov AH, 09
    int 21h
    jmp again
    return:
        RET
    input ENDP
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