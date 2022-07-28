INCLUDE Irvine16.inc

.data
abc BYTE "Hello Worl",0
.code
main proc
mov ax,@data
mov ds,ax
mov dx, offset abc
call WriteString
exit
main endp
end main
