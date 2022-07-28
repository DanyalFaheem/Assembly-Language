.model small
.stack 100h
.data
Employee struct
ID db ?
nam db "Danyal", '$'
Salary dw ?
House db "11, Burki Road", '$'
City db "Islamabad", '$'
PinCode dw ?
Employee ends
emp Employee<>
msg db "Employee Id: ",'$' 
msg1 db "Employee Name: ",'$' 
msg2 db "Employee Salary: ",'$' 
msg3 db "Employee Address: ",'$' 
msg4 db "Employee City: ",'$' 
msg5 db "Employee PinCode: ",'$' 
.code
    start:
    main Proc
    mov ax, @data
	mov ds, ax
    mov emp.ID, 001
    mov emp.Salary, 10000
    mov emp.PinCode, 1234
    mov DX, offset msg
    mov AH, 09
    int 21h
    mov AL, emp.ID
    mov AH, 0
    call display
    mov DX, offset msg1
    mov AH, 09
    int 21h
    mov DX, offset emp.nam
    mov AH, 09
    int 21h
    mov DL, 10
    mov AH, 02
    int 21h
    mov DX, offset msg2
    mov AH, 09
    int 21h
    mov AX, emp.Salary
    call display
    mov DX, offset msg3
    mov AH, 09
    int 21h
    mov DX, offset emp.House 
    mov AH, 09
    int 21h
    mov DL, 10
    mov AH, 02
    int 21h
    mov DX, offset msg4
    mov AH, 09
    int 21h
    mov DX, offset emp.City 
    mov AH, 09
    int 21h
    mov DL, 10
    mov AH, 02
    int 21h
    mov DX, offset msg5
    mov AH, 09
    int 21h
    mov AX, emp.PinCode
    call display
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
   mov DL, 10
   mov AH, 02
   int 21h
   pop DX
   pop CX
   pop BX
   pop AX
   RET      
display  ENDP   
    end start
