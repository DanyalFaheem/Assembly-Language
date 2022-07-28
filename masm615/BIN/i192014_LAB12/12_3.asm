.model large
.stack 100h
.data
msg db "Appending data into File2 ", '$'
filename db "File2.txt", 0
FileString db 20 dup('A')
.code
start:
mov AX, @data
mov DS, AX
main PROC 
    mov ah, 09
    mov dx, offset msg
    int 21h 
    mov dx, offset filename
    mov ah, 3dh
    mov al, 1
    int 21h
    mov bx, ax
    mov cx, 0
    mov ah, 42h
    mov al, 02h
    int 21h
    mov CX, 20
    mov DX, offset FileString
    mov Ah, 40h
    int 21h
    mov ah, 3eh
    int 21h
    mov AH, 4ch
    int 21h
main ENDP
end start