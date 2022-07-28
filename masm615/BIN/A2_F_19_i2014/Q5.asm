.model large
.stack 100h
.data
Matrix db 4 dup(4 dup('$'))
Vowelset db 4 dup('$')
Vowels db 'A', 'E' , 'I', 'O', 'U'
vowelcount db 0
rowsorcols dw 0
colscount dw 1
msg1 db "The matrixes are:(There is little delay) ", 10, '$'
msg2 db 10, "The Second part of the question Starts here. The rows/cols/diagonals will be     checked of the last printed matrix", 10, '$'
.code
	start:
	mov ax, @data
	mov ds, ax
	main PROC 
		mov DX, offset msg1
		mov AH, 09
		int 21h
		mov CX, 5
		Matrixloop: ; Loop to Create and display 5 matrixesS
		call CreateMatrix 
		LOOP Matrixloop
		mov DX, offset msg2 ;Message to display Part 2 starts here
		mov AH, 09
		int 21h
		mov rowsorcols, 1 ;Telling to check rows
		call CheckRowsCols
		mov rowsorcols, 4 ;Telling to check cols
		call CheckRowsCols
		;Checking for left to right diagonal
		mov si, offset Matrix ; Moving address of matrix
			mov CX, 4
			mov vowelcount, 0
			mov di, offset Vowelset
			Inner1: ;Loop to check how many vowels
				push CX
				mov CX, 5
				mov al, [si]
				mov [di], al
				inc di
				mov bx, offset Vowels
				Inner2: 
				cmp al, [bx]
				jne notmatch
				inc vowelcount
				notmatch:
				inc bx
				LOOP Inner2
				pop CX
				add si, 5
			LOOP Inner1
			cmp vowelcount, 2
			jb norow
			mov CX, 4
			mov di, offset Vowelset
			Inner3: ;Printing if vowels found
				mov dl, [di]
				mov AH, 02
				int 21h
				mov dl, ' '
				mov Ah, 02
				int 21h
				inc di
			LOOP Inner3
			mov DL, ','
			mov AH, 02
			int 21h
		norow:

		;Checking for right to left diagonal
		mov si, offset Matrix ; Moving address of matrix
		add si, 3
			mov CX, 4
			mov vowelcount, 0
			mov di, offset Vowelset
			Innerr1: ;Loop to check how many vowels
				push CX
				mov CX, 5
				mov al, [si]
				mov [di], al
				inc di
				mov bx, offset Vowels
				Innerr2: 
				cmp al, [bx]
				jne notmatchh
				inc vowelcount
				notmatchh:
				inc bx
				LOOP Innerr2
				pop CX
				add si, 3
			LOOP Innerr1
			cmp vowelcount, 2
			jb ed
			mov CX, 4
			mov di, offset Vowelset
			Innerr3: ;Printing if vowels found
				mov dl, [di]
				mov AH, 02
				int 21h
				mov dl, ' '
				mov Ah, 02
				int 21h
				inc di
			LOOP Innerr3
		ed:		
		mov AH, 4ch
		int 21h
		RET
	main ENDP
	;Function to Create Randomized Matrixed
	CreateMatrix PROC uses AX BX CX DX 
		mov CX, 4
		mov si, offset Matrix ; Moving address of matrix
		Mainloop: 
			push CX
				Again:
				mov CX, 4
				mov di, offset Vowelset ; Moving offset of subarray
				random: 
					push CX
					mov AH, 2ch ;Using milliseconds for randomness
					int 21h
					shr DL, 1 ; Shifting to divide by 4 to make values till 0-25
					shr DL, 1
					add DL, 65 ; Addind 65 to convert into Uppercase Alphabets
					mov [di], DL 
					call delay ; Calling delay to make sure same time isn't repeated
					inc di
					pop CX
				LOOP random
				call CheckVowel ; Making 50% probability of vowels
				cmp vowelcount, 1
				jb Again
				mov CX, 4
				mov di, offset Vowelset ; Moving offset of subarray
				insert:  ;Inserting values into matrix
					mov al, [di]
					mov [si], al
					inc di
					inc si
				LOOP insert
				pop CX
				mov vowelcount, 0
		LOOP Mainloop
		call PrintMatrix ;Calling function to print matrix
		RET 
	CreateMatrix ENDP
	;Function to Print 4x4 Matrix
	PrintMatrix PROC uses AX BX CX DX
		mov DL, 10
			mov AH, 02
			int 21h
		mov si, offset Matrix ; Moving address of matrix
		mov CX, 4 ;4 rows to display
		rows: 
			Push CX
			mov CX, 4 ; 4 columns to display
			cols:
				mov dl, [si]
				mov ah, 02
				int 21h
				inc si
				mov dl, ' '
				mov ah, 02
				int 21h
			loop cols
			mov DL, 10 ; Adding new line
			mov AH, 02
			int 21h
		pop CX		
		LOOP rows
		RET
	PrintMatrix ENDP
	;Function to check if a row has vowels or not
	CheckVowel PROC uses AX BX DX CX
		mov CX, 4
		mov di, offset Vowelset ; Moving offset of subarray
		mov vowelcount, 0
		vowelcheck: 
			push CX
			mov CX, 5
			mov BX, offset Vowels
			inner: 
				mov al, [bx]
				mov dl, [di]
				cmp al, dl ; Checking if vowel or not
				jne notvowel
				inc vowelcount
				notvowel:
				inc bx
			LOOP inner
			inc di
			pop CX
		LOOP vowelcheck
		RET
	CheckVowel ENDP
	;Function to check 2 vowels in a row/col
	CheckRowsCols PROC  uses AX BX CX DX ; Procedure For use in part 2
		mov colscount, 0
		mov CX, 4 ; Moving size into counter
		mov si, offset Matrix ; Moving address of matrix
		Outer: 
			push CX
			mov CX, 4
			mov vowelcount, 0
			mov di, offset Vowelset
			Inner1: ;Loop to check how many vowels
				push CX
				mov CX, 5
				mov al, [si]
				mov [di], al
				inc di
				mov bx, offset Vowels
				Inner2: 
				cmp al, [bx]
				jne notmatch
				inc vowelcount
				notmatch:
				inc bx
				LOOP Inner2
				pop CX
				add si, rowsorcols ;Changing address of si based on parameter
			LOOP Inner1
			cmp vowelcount, 2
			jb norow
			mov CX, 4
			mov di, offset Vowelset
			Inner3:  ;Printing if 2 vowels found
				mov dl, [di]
				mov AH, 02
				int 21h
				mov dl, ' '
				mov Ah, 02
				int 21h
				inc di
			LOOP Inner3
			mov DL, ','
			mov AH, 02
			int 21h
			norow:
			cmp rowsorcols, 4 ;Checking if rows mode or cols
			jne addrow
			mov si, offset Matrix
			add si, colscount
			inc colscount
			addrow:
			pop CX 
		LOOP Outer	

		RET
	CheckRowsCols ENDP
delay proc uses ax bx cx dx
mov cx,1000
mydelay:
mov bx,150     ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
mydelay1:
dec bx
jnz mydelay1
loop mydelay
ret
delay endp
    end start
	end start	