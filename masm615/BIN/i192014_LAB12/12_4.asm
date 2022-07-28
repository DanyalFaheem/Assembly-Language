.model large
.stack 100h
.data
msgfile db "Writing data into File2 ", '$'
filename db "File2.txt", 0
FileString db 20 dup('D')
V1 dw ?
count db 0
digits db 0
multiplicant db 1, 10, 100
msg db 10, "Enter your number: ",'$'
arr dw 6 dup('$')
.code
start:
mov AX, @data
mov DS, AX
main PROC 
    call input
    mov ah, 09
    mov dx, offset msgfile
    int 21h 
    mov dx, offset filename
    mov ah, 3dh
    mov al, 1
    int 21h
    mov bx, ax
    mov CX, 20
    mov DX, offset arr
    mov Ah, 40h
    int 21h
    mov ah, 3eh
    int 21h
    mov AH, 4ch
    int 21h
main ENDP
   input PROC uses AX BX CX DX
   mov si, offset arr
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
    inc count
    mov AX, v1
    cmp count, 5
    je return
    add AX, 48
    mov [si], AX
    inc si
    jmp Again
    return:
        RET
    input ENDP
end start
