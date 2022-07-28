.model large
.stack 200h
.data
x dw ? ; Starting axis for the drawing of rectangle
y dw ? ; Starting axis for the drawing of rectangle
With dw ? ; Width of rectangle
Height dw ? ; Height of rectangle
colour db 9 ; Colour of rectangle. Change it for different colours (0 - 15)
xenemy dw ? ;Coordinates for first enemies
xenemy2 dw ? ;Coordinates for the second enemy
enemydirection db 1 ;If enemy is moving right or left
xcastle dw ?
ycastle dw ?
level db 1
.code
	start:
	mov ax, @data
	mov ds, ax

    main PROC
        startagain:
        ;call DrawBoard ; Function draws the board
        mov x, 20
        mov y, 420
        call DrawMario
        mov xenemy, 95
        mov xenemy2, 265
        Untilesc: ; Loop runs until esc key pressed
                mov AH, 01
                int 16H
                JNZ outta ;If key pressed, otherwise run loop again
                cmp level, 1
                je Untilesc
                call DrawEnemy
                call delay
                jmp Untilesc
            outta:
                mov AH,00  ; Clear buffer
                INT 16H
                cmp ah,48h ; If Up Arrow key
                je up_key
                cmp ah,4Bh  ; If left Arrow key
                je left_key
                cmp ah,4Dh ; If right Arrow key
                je right_key
                cmp ah,50h ; If down Arrow key
                je down_key
                cmp AL, 27  ; If EsC key pressed exit
                jne Untilesc  ; If none of these keys pressed, run loop one
                call endprogram
        up_key:
            cmp y, 410
            jbe upscreen
            sub y, 70
            cmp level, 1
            je firstlevel
            cmp enemydirection, 0
			je leftside
			add xenemy, 20
			add xenemy2, 20
			jmp upscreen1
			leftside:
			sub xenemy, 20
			sub xenemy2, 20
            upscreen1:
            call DrawEnemy
            firstlevel:
                call DrawMario ; Drawing Mario above 100 pixels
            call jumpdown   ;proc to check if mario is on platform
            call delay
            call DrawMario ; Drawing Mario back at bottom
            upscreen:
            jmp Untilesc
        down_key:
            jmp Untilesc
        right_key:
           cmp x, 620
           jae rightscreen
            add x, 15 			;mario moves 15 pixels right
            call rightCollision ;checking for collison while moving right
            call DrawMario ; Drawing Mario right 30 pixels
            call Flagcollision ;Checking if flag reached
            rightscreen:
            jmp Untilesc
        left_key:
            cmp x, 20
            jbe leftscreen
            sub x, 15				;mario moves 15 pixels left
            call leftCollision  ;checking for collison while moving left
            call DrawMario ; Drawing Mario left 30 pixels
            call Flagcollision ;Checking if flag reached
            leftscreen:
            jmp Untilesc
        call endprogram
    main ENDP

    DrawBoard PROC uses AX BX CX DX  ; Main function to Draw our Board
        mov Al, colour
        mov ah, 0
        push AX
        push x
        push y
        push with
        push height
        mov AL, 12H ; Function to clear screen and convert to graphics mode
        mov AH, 0
        int 10h
        mov CX, 3 ;Printing 3 bases of hurdles
        mov x, 100 ;Assigning starting values
        mov y, 440 ;Assigning starting values
        mov with, 20 ;Assigning starting values
        mov height, 50 ;Assigning starting values
        mov AL, colour
        mov AH, 0
        push AX ; Pushing colour to preserve it
        Hurdles:
            call DrawRectangle
            add x, 160 ; Increase this number to increase distance between hurdle but also increase add x line in hurdles by same amount
            add with, 5
            add height, 5 ;Increase to increase height of hurdles. Also make add y in Hurdles too same
            inc colour ;Changing colour
        LOOP Hurdles
        mov x, 90 ;Assigning starting values
        mov y, 400 ;Assigning starting values
        mov with, 40 ;Assigning starting values
        mov height, 10 ;Assigning starting values
        mov cx, 3 ;Printing 3 tops of hurdles
        pop AX ;Using the pre preserved colour
        mov colour, AL
        Hurdles2:
            call DrawRectangle
            add with, 25
            add height, 5
            sub y, 10 ; Keep this value same to add height in hurdles
            add x, 150 ;Keep this number -10 of the value in Hurdles
            inc colour
        LOOP Hurdles2
        mov colour, 2 ;Changing colour for flagpole
        mov x, 620 ;Assigning starting values
        mov y, 440 ;Assigning starting values
        mov with, 5 ;Assigning starting values
        mov height, 300 ;Assigning starting values
        call DrawRectangle
        mov y, 210 ; Setting positions for y axis of flag
        mov with, 15 ; Size of boxes are 15 x 15
        mov height, 15
        mov cx, 5 ; 5 rows and 6 columns
        Checkerboard: ;Drawing checkerboard style for flag
            mov x, 520
            push cx
            mov ax, cx
            mov bl, 2
            div bl
            cmp ah, 0 ; Checking if even or odd row
            mov cx, 3
            je rows1
                rows: ; Odd rows
                    mov colour, 15 ; Colour white
                    call DrawRectangle
                    add x, 15
                    mov colour, 0 ; Colour Black
                    call DrawRectangle
                    add x, 15
                    loop rows
                jmp rows2 ; Jumping to end after loop completes iterations
                rows1: ; Even rows
                    mov colour, 0 ; Colour Black
                    call DrawRectangle
                    add x, 15
                    mov colour, 15 ; Colour white
                    call DrawRectangle
                    add x, 15
                    loop rows1
                rows2:
                pop cx
            sub y, 15
        loop Checkerboard
        mov x, 0 ; Drawing floor
        mov y, 445
        mov height, 5
        mov with, 640
        mov colour, 6
        call DrawRectangle
        pop height
        pop with
        pop y
        pop x
        pop AX
        mov colour, al
        RET
    DrawBoard ENDP
    DrawEnemy PROC 
        mov ax, xenemy
         sub ax, 10
        cmp ax, x
        jbe checkupper
        jmp eddd
        checkupper:
            add ax, 20
            cmp ax, x
            jae collisionenemy
            jmp eddd
        collisionenemy:
            cmp y, 420
            jne eddd	
            call endprogram
        eddd:
        mov ax, xenemy2
		  sub ax, 10
        cmp ax, x
        jbe checkupper1
        jmp eddd1
        checkupper1:
            add ax, 20
            cmp ax, x
            jae collisionenemy1
            jmp eddd1
        collisionenemy1:
            cmp y, 420
            jne eddd1
            call endprogram
        eddd1:
        cmp enemydirection, 0
        je colissionright
        add xenemy, 20
        add xenemy2, 20
        cmp xenemy, 245
        jae colissionleft 
		
   ;;;;;;;;;Draw after this line;;;;;;;;     
       draw:
        mov al, colour
        mov AH, 0
        push AX
        push x
        push y
        call DrawMario
        mov colour, 15
        mov ax, xenemy
        mov x, ax
        mov y, 440
        mov height, 10
        mov With, 10
       call DrawRectangle
       mov xcastle, ax
		add xcastle, 6
		mov ycastle, 430
		mov colour, 6
		mov y, 440
        mov height, 10
        mov With, 10
		call drawtri
		add x, 2
		sub y, 12
		mov colour, 0
		mov height, 3
		mov With, 3
		call DrawRectangle
		add x, 4
		call DrawRectangle
		mov colour, 15
        mov y, 440
        mov ax, xenemy2
        mov x, ax
        mov height, 10
        mov with, 10
        call DrawRectangle
        mov height, 10
		mov colour, 6
		mov xcastle, ax
		add xcastle, 6
		call Drawtri
		add x, 2
        sub y, 12
		mov colour, 0
		mov height, 3
		mov With, 3
		call DrawRectangle
		add x, 4
		call DrawRectangle
    ;;;;;;;;Draw before this line;;;;;;;;
        pop y
        pop x
        pop AX
        mov colour, al
        RET
        colissionleft:
            mov enemydirection, 0
            sub xenemy, 20
            sub xenemy2, 20
            ;call DrawEnemy
            RET
        colissionright:
            sub xenemy, 20
            sub xenemy2, 20
            cmp xenemy, 125
            jbe leftt
            jmp draw
            leftt:
            mov enemydirection, 1
            add xenemy, 20
            add xenemy2, 20
            ;call DrawEnemy
        RET
    DrawEnemy ENDP

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Draw Mario;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DrawMario PROC uses CX AX
        call DrawBoard
        mov al, colour
        mov AH, 0
        push AX
        push height
        push x
        push y
        ;;;;
        mariostart:
        mov colour, 4
        mov with, 20
        mov height, 20
        call DrawRectangle
        mov with,5
        mov height, 20
        add x, 3
        add y, 20
        mov CX, 2
        mov colour, 3
        Legs:
            call DrawRectangle
            add x, 10
        Loop Legs
        mov with, 10
        mov height, 3
        sub x, 3
        sub y, 30
        mov colour, 15
        mov CX, 2
        Arms:
            call DrawRectangle
            sub x, 30
        loop Arms
        add x, 46
        mov with, 8
        mov height, 5
        sub y, 10
        mov colour, 5
        call DrawRectangle
        sub x, 2
        sub y, 5
        mov with, 12
        mov height, 8
        mov colour, 15
        call DrawRectangle
        pop y
        pop x
        pop height
        pop AX
        mov colour, al
        RET
    DrawMario ENDP
    DrawRectangle PROC uses AX BX CX DX ;Function that draws Rectangle
        mov DX, y ; Moving y axis into variable
        sub DX, Height
        L1:
            mov CX, x ;As we are printing row wise, make sure value of x returns of same in every iteration
            add CX, with
            L2:
            mov AL, colour
            mov AH, 0CH ;Calling function to print pixel
            int 10h
            dec CX
            cmp CX, x
            jne L2
            inc DX
            cmp DX, y ;Once our height has been printed, break loop
            je outt
            jmp L1
        outt:
        RET
    DrawRectangle ENDP
    	drawtri PROC uses AX BX CX DX 			;Function that draws triangle
		push xcastle
		push ycastle
		mov dx,ycastle
		sub dx,Height
		mov cx,xcastle
		dec cx
		push cx
		loop1:
			mov ah,0ch
			mov al,colour
			int 10h
			inc cx
			cmp cx,xcastle
			jne loop1
			inc dx
			pop cx
			dec cx
			inc xcastle
			push cx
			cmp dx,ycastle
			jne loop1
			pop cx
		pop ycastle
		pop xcastle	
		RET
drawtri ENDP

    rightCollision PROC
    cmp x, 90
    jge decX1
    jmp skip


    decX1:        ;collision with 1st hurdle
    cmp x,110
    jg decX2
    cmp y,410
    jle skip
    sub x,15      ;reduce 40 for collision
    jmp skip

    decX2:        ;collision with 2nd hurdle
    cmp x,300
    jg decX3			;mario is to the right of 2nd hurdle
    cmp x,240			;mario is to the left of 2nd hurdle
    jl skip
    cmp y,410     ;mario is jumping
    jle skip
    sub x,15      ;reduce 40 for collision

    decX3:        ;collision with 2nd hurdle
    cmp x,440
    jg skip
    cmp x,410
    jl skip
    cmp y,410
    jle skip
    sub x,15      ;reduce 40 for collision

    skip:
    call jumpdown
    ret
    rightCollision ENDP

    leftCollision PROC
    cmp x, 40
    jge decX1
    jmp skipleft


    decX1:        ;collision with 3rd hurdle
    cmp x,450
    jg skipleft
    cmp x,440      ;mario is to the left of right hurdle
    jl decX2       ;check for collision with 2nd hurdle
    cmp y,410
    jle skipleft  ;mario is jumping
    add x,15      ;add 30 for collision
    jmp skipleft

    decX2:        ;collision with 2nd hurdle
    cmp x,220     ;mario is to the left of 2nd hurdle
    jl decX3      ;check for collison with 1st hurdle
    cmp x,280
    jg skipleft   ;mario is to the right of 2nd hurdle
    cmp y,410     ;mario is jumping
    jle skipleft
    add x,15      ;add 30 for collisions

    decX3:        ;collision with 1st hurdle
    cmp x,100     ;mario is to the left of 1st hurdle
    jl skipleft
    cmp x,110     ;mario is to the right of 1st hurdle
    jg skipleft
    cmp y,410     ;mario is jumping
    jle skipleft
    add x,15      ;add 30 for collision

    skipleft:
    call jumpdown
    ret
    leftCollision endp

    jumpdown proc   ;procedure to check if mario is on platform or not
    cmp y, 410
    jg skip
    decY1:
    cmp x, 70
    jl decrease ;mario drops back down
    cmp x, 140
    jl skip     ;mario is on top of platform
    cmp x, 230
    jl decrease ;mario drops back down
    cmp x, 300
    jl skip     ;mario is on top of platform
    cmp x, 380
    jl decrease ;mario drops back down
    cmp x, 480
    jl skip     ;mario is on top of platform
    decrease:
    add y, 70  ; Drawing Mario back at bottom
    skip:
    ret
    jumpdown endp
    Flagcollision PROC 
        cmp x, 600
        jae flagreached
        RET
        flagreached:
            cmp y, 260
            jbe flown
            sub y, 30
            call DrawMario
            call delay
        jmp flagreached
        flown:
        inc level
         mov x, 20
        mov y, 420
        call DrawMario
        mov xenemy, 95
        mov xenemy2, 265
        RET
    Flagcollision ENDP
    endprogram PROC 
        mov AH, 4ch
        int 21h
        RET
    endprogram ENDP
    delay proc uses ax bx cx dx
mov cx,1000
mydelay:
mov bx,600    ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
mydelay1:
dec bx
jnz mydelay1
loop mydelay
ret
delay endp
end start
