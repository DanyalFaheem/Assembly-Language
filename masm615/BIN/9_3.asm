include time.inc
.model small
.stack 100h
.data
Time struct
Hours db ?
Minutes db ?
Seconds db ?
Time ends
Ti Time<>
msg db "Hours:Minutes:Seconds ", 10, '$'
.code
	start:
      main PROC 
      mov ax, @data
	mov ds, ax
    mov Ah, 2ch
    int 21h
    mov Ti.Hours, ch
    mov Ti.Minutes, cl
    mov Ti.Seconds, DH
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