
; extrn grid:byte

;Moves format: sourceRow SourceCol, destRow DestCol    
macro convertToTile position
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

endm

macro pushAll 
push ax
push bx
push cx
push dx
push di
push si
endm pushAll

macro popAll
pop si
pop di
pop dx
pop cx
pop bx
pop ax 
endm popAlls

.model large
.stack 64
.data
grid db "br","bn","bb","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","wb","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","--","wk","wq","wb","wn","wr"
                                  
moves dw 100 dup('$')
count db 0
  
  
.code


;Given the bishop position in the board, this procedure returns the available moves of this pawn
bishopMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 



mov ah, 5h
mov al, 4h

dec ah
dec al

mov dx,ax



convertToTile ax



cmp grid[bx], "w"




pushAll

; decremnt row, increment col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalRightUp: 
dec ah
inc al
convertToTile ax
; if black
cmp grid[bx], "b"
jz diagonalRightUpLast
; if empty
cmp grid[bx], "-"
jnz diagonalLeftUpA
; out of bound
cmp bx, 128D
ja diagonalLeftUpA
; out of bound
cmp bx, 0D
jb diagonalLeftUpA
; add to moves 
diagonalRightUpLast:
push bx
push cx
mov cx, 0

mov cx, ax

mov bh, 0
mov bl, count
mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop cx
pop bx
cmp grid[bx],"b"
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
convertToTile ax
; if black
cmp grid[bx], "b"
jz diagonalLeftUpLast
; if empty
cmp grid[bx], "-"
jnz diagonalRightDownA
; out of bound
cmp bx, 128D
ja diagonalRightDownA
; out of bound
cmp bx, 0D
jb diagonalRightDownA
; add to moves 
diagonalLeftUpLast:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop cx
pop bx
cmp grid[bx],"b"
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
convertToTile ax
; if black
cmp grid[bx], "b"
jz diagonalRightDownLast
; if empty
cmp grid[bx], "-"
jnz diagonalLeftDownA
; out of bound
cmp bx, 128D
ja diagonalLeftDownA
; out of bound
cmp bx, 0D
jb diagonalLeftDownA
; add to moves 
diagonalRightDownLast:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop cx
pop bx
cmp grid[bx],"b"
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
convertToTile ax
; if black
cmp grid[bx], "b"
jz diagonalLeftDownLast
; if empty
cmp grid[bx], "-"
jnz continue
; out of bound
cmp bx, 128D
ja continue
; out of bound
cmp bx, 0D
jb continue
; add to moves 
diagonalLeftDownLast:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop cx
pop bx
cmp grid[bx],"b"
jz continue 
jmp diagonalLeftDown

continue:
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