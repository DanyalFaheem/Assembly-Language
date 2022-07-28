.model small
.stack 100h
.data
A db 2
B db 4
.code
start:

mov AH, A
mov AL, B
mov BH, A
sub AH, BH
sub AL, BH 
mov A, AH
add A, AL

mov DL, A
add DL, 48
mov AH, 02
int 21h


mov AH, 4CH
int 21h

end start
