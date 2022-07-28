.model small
.stack 100h
.data
str1 db 50 dup('$')
str2 db 50 dup('$')
str3 db 50 dup('$')
arr_count dw 3 dup(0)
arr_counter db 3 dup()
input_string db "Enter string: ", '$'
msg db "The strings in ascending order are: ", 13, 10, '$'
msg1 db "String ", '$'
count db 1
arr1 dw ?
arr2 dw ?
arr3 dw ?
.code
	start:
	mov ax, @data
	mov ds, ax

    mov dx, offset input_string
    mov ah, 09
    int 21h
    mov dx, offset str1
    mov ah, 3fh
    int 21h
    mov dx, offset input_string
    mov ah, 09
    int 21h
    mov dx, offset str2
    mov ah, 3fh
    int 21h
    mov dx, offset input_string
    mov ah, 09
    int 21h
    mov dx, offset str3
    mov ah, 3fh
    int 21h
    mov si, offset str1
    mov di, offset arr_count    
    L1:
        mov bl, [si]
        cmp bl, 13
        je out1
        mov al, [si]
        mov ah, 0
        mul count
        mov CX, 0
        add CX, AX 
        mov [di], CX
        inc count
        inc si
        jmp L1
    out1:
        mov ax, [di]
        mov arr1, ax
        
        inc di  
        mov si, offset str2  
        mov count, 1
       L2:
        mov bl, [si]
        cmp bl, 13
        je out2
        mov al, [si]
        mov ah, 0
        mul count
        mov CX, [di]
        add CX, AX 
        mov [di], CX
        inc count
        inc si
        jmp L2
    out2:
        mov ax, [di]
        mov arr2, ax
        
        inc di
    mov si, offset str3   
    mov count, 1
           L3:
        mov bl, [si]
        cmp bl, 13
        je out3
        mov al, [si]
        mov ah, 0
        mul count
        mov CX, [di]
        add CX, AX 
        mov [di], CX
        inc count
        inc si
        jmp L3
    out3:
    mov ax, [di]
    mov arr3, ax
    
      
    mov count, 3
    mov dx, offset msg
    mov ah, 09
    int 21h
    mov AX, arr1
    
    mov AX, arr2
    
    mov AX, arr3
    
    mov AX, arr1
    cmp AX, arr2
    jb check
    mov BX, arr3
    cmp arr2, BX
    jb print2
    jmp print3
    jmp ed

    check:
        cmp AX, arr3
        jb print1
        mov BX, arr2
        cmp arr3, BX
        jb print3
    chck23:
    mov AX, arr2
    cmp arr2, AX
    jb print2
    jmp print3    

    print1:
    mov dx, offset msg1
     mov ah, 09
     int 21h
        mov dl, 1
        add dl, 48
        mov ah, 02
        int 21h
        mov dl, ','
        mov ah, 02
        int 21h
        dec count
        cmp count, 0
        je ed
        mov AX, arr2
        cmp ax, arr3
        jb print2
        jmp print3
    print2:
    mov dx, offset msg1
     mov ah, 09
     int 21h
        mov dl, 2
        add dl, 48
        mov ah, 02
        int 21h
        mov dl, ','
        mov ah, 02
        int 21h 
        dec count
        cmp count, 0
        je ed
       mov AX, arr3
       cmp AX, arr1
       jb print3
       jmp print1 
    print3:
    mov dx, offset msg1
     mov ah, 09
     int 21h
        mov dl, 3
        add dl, 48
        mov ah, 02
        int 21h
        mov dl, ','
        mov ah, 02
        int 21h
        dec count
        cmp count, 0
        je ed
        mov AX, arr2
        cmp AX, arr1
        jb print2
    ed:
        mov ah, 4ch
        int 21h 
 
        end start    


    
     
        


        


   



