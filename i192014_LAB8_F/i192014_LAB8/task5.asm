.model small
.stack 100h
.data
v1 dw ?
max dw 0
found db 0
arr dw 5 dup('$')
digits db 0
multiplicant db 1, 10, 100
count1 db 0
frequency db 0
msg db "Enter your number: ", '$'
msgchoice db "To find element in array, press a. To find max element in array, press b. To sort array in descending, press c. To find frequency of element, press d. ", '$'
msgfind db "Enter your number to be searched: ", '$'
msgindex db "The found number is at index: ", '$'
msgmax db "The max number is: ", '$'
msgfreq db "The frequency is: ", "$"
.code
	start:
	mov ax, @data
	mov ds, ax
	mov DX, offset msgchoice
    mov Ah, 09
    int 21h
    mov AH, 01
    int 21h
    cmp al, 'a'
    je find_el
    cmp al, 'b'
    je max_el
    cmp al, 'c'
    je sort_des
    cmp al, 'd'
    je frequ
    jmp ed
    find_el:
        call find
        jmp ed
    max_el:
        call max_no
        jmp ed
    sort_des:
        call sort
        jmp ed
    frequ:
        call count_element    
        jmp ed        
    ed:
    mov Ah, 4CH
    int 21h
    find PROC 
        call input1
        mov v1, 0
        mov DX, offset msgfind
        mov AH, 09
        int 21h
     mov di, offset multiplicant 
    mov digits, 0
    input:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp input
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            ;mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    mov CX, 5
    mov si, offset arr
    find_no:
        mov BX, [si]
        cmp bx, AX
        je swp1
        add found, 1
        inc si
        loop find_no
    swp1:
        mov dx, offset msgindex
        mov AH, 09
        int 21h
        mov dl, found
        add dl, 48
        mov AH, 02
        int 21h     
        RET
    find ENDP
    max_no PROC 
        call input1
        mov si, offset arr
        mov CX, 6
        max_find:
            mov AX, [si]
            cmp max, ax
            jb swp_max
            temp_max:
                inc si
        loop max_find
        jmp outt
        swp_max:
            mov max, AX
            jmp temp_max
    outt:
    mov DX, max
    add Dl, 48
    mov Ah, 02
    int 21h
    mov AX, max
    mov v1, AX
    mov count1, 0
    L1:
        cmp v1, 0
        jbe display
        mov AX, v1
        mov DL, 10
        mov DH, 0
        div DL
        mov DL, AH
        mov DH, 0
        push DX
        inc count1
        mov CL, AL
        mov CH, 0
        mov v1, CX
        jmp L1
    display:
        cmp count1, 0
        jbe ot
        pop DX
        add DL, 48
        mov AH, 02
        int 21h
        dec count1
        jmp display
    ot: 
        RET
    max_no ENDP
    count_element PROC 
        call input1
        mov v1, 0
        mov DX, offset msgfind
        mov AH, 09
        int 21h
         mov di, offset multiplicant
    mov digits, 0
    input:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp input
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            ;mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov CX, 5
    mov si, offset arr
    count_find:
            mov AX, [si]
            cmp AX, v1
            je freq
            temp_freq:
                inc si
        loop count_find
        mov DX, offset msgfreq
        mov AH, 09
        int 21h 
        mov DL, frequency
        add DL, 48
        mov AH, 02
        int 21h
        RET
        freq:
            inc frequency
            jmp temp_freq   
    count_element ENDP
    sort PROC 
    call input1
    mov CX, 5
	mov si, offset arr
	L2:
		mov DX, CX
		mov si, OFFSET arr
		mov CX, 4
		L3:
			mov AX, [si]
			cmp [si + 1], ax	
			ja swap
			L4:					
				inc si
				
		loop L3
		mov CX, DX
	loop L2
	jmp display_arr
	swap:
		mov BX, [si + 1]
		mov [si + 1], AX
		mov [si], BX
		jmp L4
    display_arr:
    mov CX, 5
    mov si, offset arr
    print:
    mov BX, CX
    mov DL, [si]
    add DL, 48
    mov Ah, 02
    int 21h
    mov DL, 'T'
    mov AH, 02
    int 21h
    mov AX, [si]
    mov v1, AX
    mov count1, 0
    L1:
        cmp v1, 0
        jbe display
        mov AX, v1
        mov DL, 10
        mov DH, 0
        div DL
        mov DL, AH
        mov DH, 0
        push DX
        inc count1
        mov CL, AL
        mov CH, 0
        mov v1, CX
        jmp L1
    display:
        cmp count1, 0
        jbe ot
        pop DX
        add DL, 48
        mov AH, 02
        int 21h
        dec count1
        jmp display
    ot: 
        inc si
        mov CX, BX
        mov DL, ','
        mov AH, 02
        int 21h
    loop print    
        RET
    sort ENDP
    input1 PROC
    mov CX, 5
    mov si, offset arr
    inp: 
    mov v1, 0
    mov DX, offset msg
    mov AH, 09
    int 21h
	mov di, offset multiplicant
    mov DX, CX 
    mov digits, 0
    inputs:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp inputs
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            ;mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    mov [si], AX
    inc si
    mov CX, DX
    loop inp 
        RET
    input1 ENDP
    end start