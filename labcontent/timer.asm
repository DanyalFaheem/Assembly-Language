.model small
.stack 100
.data
.code   

;To select mode
 mov ah,0
 mov al,13h
 int 10h


 mov si,20 ;starting column
 mov di,20 ;starting row
 outer:
  cmp di,25  ;20-180 row
  je away
  mov si,20
  here:
   cmp si,300 ;20-300 column
   je exit
   inc si
   mov ah,0ch; interrupt number
   mov al,03 ; color
   mov cx,si ;column number
   mov dx,di ;row number
   int 10h
 jmp here
 exit:
 MOV     CX, 0FH
 MOV     DX, 4240H
 MOV     AH, 86H
 INT     15H

 inc di
 jmp outer

 away:
 mov ah,4ch
 int 21h 
end
