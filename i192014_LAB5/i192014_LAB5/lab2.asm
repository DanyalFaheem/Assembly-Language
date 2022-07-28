.model small
.stack 100h
.data
VAR DB ?
VAR2 DB ?
.code
start:

mov AH, 01
int 21H

mov VAR, AL

mov DL, '-'
mov AH, 02
int 21h

mov DL, VAR

add DL, 48


mov AH, 01
int 21H

mov VAR, DL

mov VAR2, AL
mov DL, '='
mov AH, 02
int 21h

mov DL, VAR
sub DL, VAR2


mov AH, 02
int 21H


mov AH,4CH
int 21H
end start 

