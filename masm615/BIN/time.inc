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
    ENDM

    