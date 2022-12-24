public RockMoves
extrn grid:byte
extrn moves:word
extrn count:byte 
.model large
.stack 64
.data
.code

convertToTile macro position
push ax
mov ax, position

mov bx, 0 
mov bl, 16d

mov cl, al

mov al, ah
mov ah, 0

mul bl

mov ch, al
mov al, cl
mov bl, 2d
mul bl

add al, ch
mov bx, ax
pop ax

endm convertToTile

addMove proc far
mov bh, 0
mov bl, count

mov moves[bx], cx
add count, 2

ret

addMove endp

RockMoves proc far
;Assuming rock position is (5,4)
; mov ah, 5
; mov al, 4

mov dx, ax

dec ah
dec al
; ah = 7 ;;Row
; al = 0 ;;Col

;Getting the index of the piece in the grid
convertToTile ax


cmp grid[bx], 'w'
mov ah, 'w'
mov al, 'b'
je c11
mov ah, 'b'
mov al, 'w'

c11:
;;Moving Right
push bx ;;Because bx will be updated

mov cx, dx

c12:
cmp cl, 8
je c13 ;;Cannot Move Right Again
cmp grid[bx + 2], al
jne c14

;;Add move
inc cl
call addMove
jmp c13

c14:
cmp grid[bx + 2], ah
je c13

;;Add move
push bx
inc cl
call addMove
pop bx

add bx, 2
jmp c12


c13:
pop bx
;;Moving Left
push bx ;;Because bx will be updated

mov cx, dx

c15:
cmp cl, 1
je c18 ;;Cannot Move Left Again

cmp grid[bx - 2], al
jne c17

;;Add move
dec cl
call addMove
jmp c18

c17:
cmp grid[bx - 2], ah
je c18

;;Add move
push bx
dec cl
call addMove
pop bx

sub bx, 2
jmp c15

c18:
pop bx
;;Moving Up
push bx ;;Because bx will be updated

mov cx, dx

c23:
cmp ch, 1
je c22 ;;Cannot Move Up Again

cmp grid[bx - 16d], al
jne c21

;;Add move
dec ch
call addMove
jmp c22

c21:
cmp grid[bx - 16d], ah
je c22

;;Add move
push bx
dec ch
call addMove
pop bx

sub bx, 16
jmp c23



c22:
pop bx
;;Moving Down
push bx ;;Because bx will be updated

mov cx, dx

c27:
cmp ch, 8
je c26 ;;Cannot Move Down Again

cmp grid[bx + 16d], al
jne c25

;;Add move
inc ch
call addMove
jmp c26

c25:
cmp grid[bx + 16d], ah
je c26

;;Add move
push bx
inc ch
call addMove
pop bx

add bx, 16
jmp c27

c26:
pop bx

ret

RockMoves endp

END