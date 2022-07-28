.model small
.stack 100h
.data
msg db "Enter Number:",10,13,'$'
msg1 db "The number is armstrong $"
msg2 db "The number is not armstrong $"
var dw 0
sum db 0
count db 0
.code
main proc
mov ax,@data
mov ds,ax

mov ah,09
mov dx,offset msg
int 21h

call multidig
call am 

mov cl,sum
mov ch,0
cmp cx,var
jne notam
mov ah,09
mov dx,offset msg1
int 21h
notam:
mov ah,09
mov dx,offset msg2
int 21h

mov ah,4ch
int 21h

main endp

multidig proc
	input_label:

	mov ah,01
	int 21h
	cmp al,13
	je end_input
	sub al,48
	mov ah,0
	mov cx,ax

	mov ax,var
	mov bx,10
	mul bx

	add cx,ax
	mov var,cx
	jmp input_label

	end_input:
	ret
multidig endp

am proc
	mov ax,var
	mov bl,10
	l1:
		div bl 
		mul al
		mul al
		add sum,al
		mov al,ah
		mov ah,0
		cmp al,0
		jne l1		
ret
am endp

end main