extrn myname:byte
extrn myP:far

.model small
.stack 64
.data
.code

start:
mov ax, @data
mov ds, ax

lea dx, myname
mov ah, 9
int 21h

call myP

mov dx, 0

mov ah, 4ch
int 21h

end start

END