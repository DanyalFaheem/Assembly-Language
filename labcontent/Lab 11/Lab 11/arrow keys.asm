.model small
.stack
.data
upstring db "Up pressed",13,10,'$'
downstring db "Down pressed",13,10,'$'
leftstring db "Left pressed",13,10,'$'
rightstring db "Right pressed",13,10,'$'
.code
start:
main proc 
mov ax,@data
mov ds,ax

repeat1:
; Get keystroke
mov ah,0
int 16h
; AH = BIOS scan code
cmp ah,48h
je up
cmp ah,4Bh
je left
cmp ah,4Dh
je right
cmp ah,50h
je down
cmp ah,1
jne repeat1  ; loop until Esc is pressed
mov ah,4ch
int 21h


up:
mov dx,offset upstring
mov ah,9
int 21h
jmp repeat1

down:
mov dx,offset downstring
mov ah,9
int 21h
jmp repeat1

left:
mov dx,offset leftstring
mov ah,9
int 21h
jmp repeat1

right:
mov dx,offset rightstring
mov ah,9
int 21h
jmp repeat1

main endp
end