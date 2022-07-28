.model large
.stack 100h
.data
buffer db 500 dup('$')
filename db "File1.txt", 0
.code
start:
mov AX, @data
mov DS, AX
main PROC 
    mov dx, offset filename
    mov ah, 3dh
    mov al, 0
    int 21h
    mov bx, AX
    mov dx, offset buffer
    mov ah, 3fh
    int 21h
    mov ah, 09
    mov dx, offset buffer
    int 21h 
    mov ah, 3eh
    int 21h
    mov AH, 4ch
    int 21h
main ENDP
end start