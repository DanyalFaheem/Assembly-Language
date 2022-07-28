.model small
.stack 100h
.data
arr1 db 50 dup('$')
arr2 db 50 dup('$')
arr3 db 50 dup('$')
msg db "Enter your string(lowercase): ", '$'
palindrome_not db "String is not a Palindrome", '$'
palindrome db "String is a Palindrome", '$'
.code
	start:
	mov ax, @data
	mov ds, ax

    mov DX, OFFSET msg
    mov AH, 09
    int 21h

    mov DX, offset arr1
    mov AH, 3Fh
    int 21h

    mov si, offset arr1
    mov di, offset arr2
    L1:
        mov al, [si]
        cmp al, 13
        je outer
        cmp al, 65
        jb temp
        cmp al, 122
        ja temp
        mov [di], al
        inc di
        mov ah, 0
        push AX
        temp:
            inc si
        jmp L1

    outer:
    mov [di], al
    mov di, offset arr2
    mov CX, lengthof arr2
    L3: 
        mov dl, [di]
        mov ah, 02
        int 21h
        inc di
    loop L3    

    mov DX, offset arr2
    mov AH, 09 
    int 21h
    mov di, offset arr2

    L2:
        mov cl, [di]
        cmp cl, 13
        je outer2
        pop BX
        mov BH, 0
        mov dl, bl
        mov ah, 02
        ;int 21h
        mov dl, cl
        mov ah, 02
        ;int 21h
        cmp cl, bl
        jne ed
        inc di
        jmp L2

    outer2:
        mov dx, word PTR OFFSET palindrome 
        mov ah, 09
        int 21h  
        jmp edd

    ed:
        mov dx, word PTR OFFSET palindrome_not  
        mov ah, 09
        int 21h

    edd:
        mov ah, 4CH
        int 21h
        end start

        
