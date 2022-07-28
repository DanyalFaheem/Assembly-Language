.model small
.stack
.data
.code
start:
main proc 
mov ax,@data
mov ds,ax
mov ax,0
again:
mov dl,'a'
mov ah,02
int 21h

mov ah,01
int 16h
cmp ah,4Dh ;48 for arrow up
jne again
mov ah,4ch
int 21h