include time.inc
.model small
.stack 100h
.data
Time struct
Hours db ?
Minutes db ?
Seconds db ?
Miliseconds db ?
Time ends
Ti Time<>
msg db "Hours:Minutes:Seconds:Milliseconds ", 10, '$'
.code
print MACRO T
    mov DX, offset msg
    mov AH, 09
    int 21h
    mov AL, T.Hours
    mov AH, 0
    call display       
    mov AL, T.Minutes
    mov AH, 0
    call display
    mov AL, T.Seconds
    mov AH, 0
    call display 
    mov AL, T.Miliseconds
    mov AH, 0
    call display
    ENDM
	start:
      main PROC 
      mov ax, @data
	mov ds, ax
    mov Ah, 2ch
    int 21h
    mov Ti.Hours, ch
    mov Ti.Minutes, cl
    mov Ti.Seconds, DH
    mov Ti.Miliseconds, DL
    print Ti
    mov ah, 4ch
    int 21h
    main endp
         display   proc       ;Whatever value is in AX is in displayed
    push AX
    push BX
    push CX
    push DX
   MOV BX, 10     
   MOV DX, 0  
   MOV CX, 0       
loop1:  
   MOV DX, 0   
   div BX      
   PUSH DX     
   INC CX      
   CMP AX, 0     
   JNE loop1     
    
loop2:  
   POP DX      
   ADD DX, 48     
   MOV AH, 02H     
   INT 21H      
   LOOP loop2    
   mov DL, ':'
   mov AH, 02
   int 21h
   pop DX
   pop CX
   pop BX
   pop AX
   RET       
display  ENDP   
end start