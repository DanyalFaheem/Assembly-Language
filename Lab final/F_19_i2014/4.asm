.model small
.stack 100h
.data ;Initializing all data and messages
vowel db 'a', 'e', 'i', 'o' , 'u'
vowel2 db 'A', 'E', 'I', 'O', 'U'
filename db "story.txt", '$'
msgcarry db "Carry flag activated. Error in file opening. Value in AL is: ", '$'
buffer byte 1000 dup('$')
str2 byte 100 dup('$')
charmsg byte "Character in line " , '$'
charmsg2 byte " is " , '$'
vowelmsg byte "Number of vowels are ", '$'
wordmsg byte "Number of words starting with vowels are ", '$'
vowelcount dw ?
wordcount dw ?
charcount dw ?
.code

start:
mov ax, @data
mov ds, ax

mov dx, offset filename
mov al, 0
mov ah, 3dh ; Opening file-
int 21h
jc ed ;Checking for file error through carry flag

mov bx, ax
mov dx, offset buffer
mov ah, 3fh ;Reading file
int 21h

;calling procedures
call countchar
call countvowels
call worddcount

mov dx, offset buffer
mov ah, 09
int 21h

mov ah, 3eh ; Closing file
int 21h

ed:
push ax
mov dx, offset msgcarry
mov ah, 09 
int 21h
pop ax
mov ah, 0
call display
mov ah, 4ch ;Calling end
int 21h


countchar proc uses ax bx cx dx ;Procedure to count characters in each line
mov si, offset buffer
mov cl, 26
mov bl, 1
l2:
	mov charcount, 0
	l1:
		mov al, [si]
		cmp al, 10 ;Checking for endline
		je endline
		inc charcount 
		inc si
		jmp l1
	endline:
		mov dx, offset charmsg
		mov ah, 09
		int 21h
		mov ah, 02
		mov al, bl
		mov ah, 0
		call display ;Displaying value and messages
		inc bl
		mov dx, offset charmsg2
		mov ah, 09
		int 21h
		mov ax, charcount
		call display
		mov dl, 10
		mov ah, 02
		int 21h
loop l2
ret
countchar endp

countvowels proc uses ax bx cx dx ; Procedure to count number of vowels present in entire file
mov vowelcount, 0
mov si, offset buffer
l1:
		mov al, [si]
		cmp al, 10
		je endline
		mov cl, 5 ;Checking for lowecase vowels
		mov di, offset vowel
			l2:
				mov bl, [di]
				cmp al, bl
				jne again
				inc vowelcount
				again:
					inc di
				loop l2	
		mov cl, 5 ;Checking for uppercase vowels
		mov di, offset vowel2
			l3:
				mov bl, [di]
				cmp al, bl
				jne agin
				inc vowelcount
				agin:
					inc di
				loop l3			
		jmp l1
endline:
	mov dx, offset vowelmsg ;Printing value and messag
	mov ah, 09 
	int 21h
	mov ax, vowelcount
	call display
countvowels endp

worddcount proc uses ax bx cx dx ; Procedure to count number of words starting with vowels
mov wordcount, 0
mov si, offset buffer
l1:
		mov al, [si]
		cmp al, 10
		je endline
		mov cl, 5
		mov di, offset vowel2 ;Checking for uppercase vowels on start of line
			l2:
				mov bl, [di]
				cmp al, bl
				jne again
				inc wordcount
				again:
					inc di
				loop l2	
	endline:
	mov dx, offset wordmsg
	mov ah, 09 
	int 21h
	mov ax, wordcount
	call display
worddcount endp



display proc uses ax bx cx dx ; Procedur to display multidigit values ;Prints whatever value is in AX
	mov bx, 10
	mov cx, 0
	mov dx, 0
	
	L1:
		mov dx, 0
		div bx ;Dividing by 10 to get remainder
		push dx ;Pushing remainder onto stack
		inc cx
		cmp ax, 0 ;Checking if value is 0 to break
		jne L1
	
	L2:
		pop dx ;Popping remainders in opposite
		add dx, 48
		mov ah, 02
		int 21h
		loop L2
	Ret
	display endp   
	end start
