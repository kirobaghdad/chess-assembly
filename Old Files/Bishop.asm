extrn grid:byte 
extrn moves:word
extrn count:byte
public bishopMoves
; extrn grid:byte
;Moves format: sourceRow SourceCol, destRow DestCol    
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

pushAll macro  
push ax
push bx
push cx
push dx
push di
push si
endm pushAll

popAll macro 
pop si
pop di
pop dx
pop cx
pop bx
pop ax 
endm popAll

.model large
.stack 64
.data
.code


;Given the bishop position in the board, this procedure returns the available moves of this pawn
bishopMoves proc far
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 




mov dx,ax

pushAll

dec ah
dec al

convertToTile ax



cmp grid[bx], "w"
je whiteBishop
jmp blackBishop




whiteBishop:
mov dl,"w"
mov dh,"b"
jmp bishopBegin
blackBishop:
mov dl,"b"
mov dh,"w"

bishopBegin:
pushAll
; decremnt row, increment col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalRightUp: 
dec ah
inc al

; out of bound
cmp ah, 7h
ja diagonalLeftUpA
cmp ah, 0h
jb diagonalLeftUpA
; out of bound
cmp al, 7h     
ja diagonalLeftUpA
cmp al, 0h
jb diagonalLeftUpA


convertToTile ax
cmp grid[bx], dh
je LastdiagonalRightUp
; if empty
cmp grid[bx], "-"
jnz diagonalLeftUpA
; add to moves 
LastdiagonalRightUp:
push bx ; moves
push cx ; actual move 
mov cx, 0
mov cx, ax
mov bh, 0
mov bl, count
inc cl
inc ch
mov moves[bx], cx
pop cx
pop bx
add count, 2
cmp grid[bx],dh
jz diagonalLeftUpA
jmp diagonalRightUp
diagonalLeftUpA:

popAll

pushAll

; decrement row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalLeftUp: 
dec ah
dec al
; out of bound
cmp ah, 7h
ja diagonalRightDownA
cmp ah, 0h
jb diagonalRightDownA

; out of bound
cmp al, 7h
ja diagonalRightDownA

cmp al, 0h
jb diagonalRightDownA

convertToTile ax
cmp grid[bx],dh
je LastdiagonalLeftUp
; if empty
cmp grid[bx], "-"
jnz diagonalRightDownA


; add to moves 
LastdiagonalLeftUp:
push bx ; moves
push cx ; actual move 
mov cx, 0
mov cx, ax
mov bh, 0
mov bl, count
inc cl
inc ch
mov moves[bx], cx
pop cx
pop bx
add count, 2
cmp grid[bx],dh
jz diagonalRightDownA 
jmp diagonalLeftUp

diagonalRightDownA:
popAll

pushAll
; increment row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalRightDown: 
inc ah
inc al
; out of bound
cmp ah, 7h
ja diagonalLeftDownA
cmp ah, 0h
jb diagonalLeftDownA
; out of bound
cmp al, 7h
ja diagonalLeftDownA
cmp al, 0h
jb diagonalLeftDownA

convertToTile ax
cmp grid[bx], dh
je LastdiagonalRightDown
; if empty
cmp grid[bx], "-"
jnz diagonalLeftDownA
; add to moves 
LastdiagonalRightDown:
push bx ; moves
push cx ; actual move 
mov cx, 0
mov cx, ax
mov bh, 0
mov bl, count
inc cl
inc ch
mov moves[bx], cx
pop cx
pop bx
add count, 2
cmp grid[bx],dh
jz diagonalLeftDownA 
jmp diagonalRightDown

diagonalLeftDownA:
popAll



pushAll
; increment row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalLeftDown: 
inc ah
dec al

; out of bound
cmp ah, 7h ; check if equal works
ja continue
cmp ah, 0h ; check if equal works
jb continue
; out of bound
cmp al, 7h ; check if equal works
ja continue
cmp al, 0h ; check if equal works
jb continue


convertToTile ax

cmp grid[bx], dh
je LastdiagonalLeftDown

; if empty
cmp grid[bx], "-"
jnz continue

; add to moves 
LastdiagonalLeftDown:
push bx ; moves
push cx ; actual move 
mov cx, 0
mov cx, ax
mov bh, 0
mov bl, count
inc cl
inc ch
mov moves[bx], cx
pop cx
pop bx
add count, 2
cmp grid[bx],dh
je continue
jmp diagonalLeftDown

continue:
popAll
popAll

ret

bishopMoves endp



start:
mov ax, @data
mov ds, ax

call bishopMoves
hlt

end start

.end
END