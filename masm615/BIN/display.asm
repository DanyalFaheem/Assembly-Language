.model large
.stack 100h
.data
v1 dw 0
v2 dw 0
;Multiplicand db 9 ; Consider Assigned Number Digit A0 9213
;Multiplier db 1 ; Consider Assigned Number Digit A3
;Result db 0
;Q2
multiplicand dd 23FDH ;Hexa of assigned word 
multiplier dw 005AAH
result dd 0
count db 0
.code
start:
mov ax,@data
mov ds,ax
mov ax,0
mov cl,4
;mov al,multiplicand
;mov bl,multiplier
checkbit:
mov dH, 0
;mov dl, result
mov v1, dx
;call display
mov bH, 0
mov v1, bx
;call display
mov AH, 0
mov v1, AX
;call display
shr bl,1
jnc skip
;add result,al

skip:
shl al,1
loop checkbit

mov ax, 0
mov cl,16	;initialize bit count to 16 
mov dx, multiplier	;initialize bit mask
 
checkbit1:
mov v1, dx
call display
shr dx,1
jnc noadd	;skip addition if no carry
push dx
mov dl, 'b'
mov ah, 02
int 21H
pop dx
mov ax, word ptr[multiplicand]		;mov LSW of multiplicand to ax 
mov v1, ax
;call display
add word ptr[result],ax	;add LSW of multiplicand to result 
push ax
mov ax, word ptr [result] 
mov v2, ax
;call display ;C8
pop ax
mov bx, word ptr[multiplicand+2]	;mov MSW of multiplicand to bx
mov v1, bx
;call display
adc word ptr[result+2],bx	;add MSW of multiplicand to result 
push ax
mov ax, word ptr [result + 2] 
mov v1, ax
call display ;C8
mov ax, v2
mov v1, ax
call display
pop ax
noadd:
push dx
push ax
mov dl, 'a'
mov ah, 02
int 21h
shl word ptr[multiplicand],1	;shift LSW multiplicand to left 
mov ax, word ptr [multiplicand] 
mov v2, ax
;call display ;C8
rcl word ptr[multiplicand+2],1;rotate MSW of multiplicand to left
mov ax, word ptr [multiplicand + 2] 
mov v1, ax
call display
mov ax, v2
mov v1, ax
call display
pop ax
pop dx
inc count
Loop checkbit1	;jump to check bit in not zero mov ah,04ch

mov ax, word ptr [result + 2] 
mov v1, ax
;call display ;C8
mov ax, word ptr [result] 
mov v1, ax
;call display ;C8

ed:
mov Ah, 4ch
int 21h
    display proc uses ax bx cx dx    ;Beginning of procedure
   MOV BX, 10     ;Initializes divisor
   MOV DX, 0000H    ;Clears DX
   MOV CX, 0000H    ;Clears CX
   mov AX, v1
          ;Splitting process starts here
loop1:  
   MOV DX, 0000H    ;Clears DX during jump
   div BX      ;Divides AX by BX
   PUSH DX     ;Pushes DX(remainder) to stack
   INC CX      ;Increments counter to track the number of digits
   CMP AX, 0     ;Checks if there is still something in AX to divide
   JNE loop1     ;Jumps if AX is not zero
    
loop2:  
   POP DX      ;Pops from stack to DX
   ADD DX, 30H     ;Converts to it's ASCII equivalent
   MOV AH, 02H     
   INT 21H      ;calls DOS to display character
   LOOP loop2    ;Loops till CX equals zero
   mov DL, ' '
   mov AH, 02
   int 21h
      ;Loops till CX equals zero
   mov DL, ' '
   mov AH, 02
   int 21h
   RET       ;returns control
display  ENDP   
end start