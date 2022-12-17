
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
endm popAlls

.model large
.stack 64
.data
grid db "br","bn","--","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","bb","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wk","wq","wb","wn","wr"
                                  
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


mov dx,ax

pushAll


convertToTile ax



cmp grid[bx], "w"
jz diagonalRightUp
jmp near ptr black




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
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
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
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
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
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
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
jz bx1
jmp near ptr continue
bx1:
; out of bound
cmp bx, 128D ; check if equal works
jb bbx2
jmp near ptr continue
bbx2:
; out of bound
cmp bx, 0D ; check if equal works
ja bbx3
jmp near ptr continue
bbx3:
; add to moves 
diagonalLeftDownLast:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
add count, 4

pop cx
pop bx
cmp grid[bx],"b"
jnz bx4
jmp near ptr continue
bx4:
jmp diagonalLeftDown

; --------------------------------------------black---------------------------------------------

black: 

diagonalRightUpB: 
dec ah
inc al
convertToTile ax
; if black
cmp grid[bx], "w"
jz diagonalRightUpLastB
; if empty
cmp grid[bx], "-"
jnz diagonalLeftUpAB
; out of bound
cmp bx, 128D
ja diagonalLeftUpAB
; out of bound
cmp bx, 0D
jb diagonalLeftUpAB
; add to moves 
diagonalRightUpLastB:
push bx
push cx
mov cx, 0

mov cx, ax

mov bh, 0
mov bl, count
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
add count, 4

pop cx
pop bx
cmp grid[bx],"w"
jz diagonalLeftUpAB 
jmp diagonalRightUpB

diagonalLeftUpAB:
popAll

pushAll

; decrement row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalLeftUpB: 
dec ah
dec al
convertToTile ax
; if black
cmp grid[bx], "w"
jz diagonalLeftUpLastB
; if empty
cmp grid[bx], "-"
jnz diagonalRightDownAB
; out of bound
cmp bx, 128D
ja diagonalRightDownAB
; out of bound
cmp bx, 0D
jb diagonalRightDownAB
; add to moves 
diagonalLeftUpLastB:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
add count, 4

pop cx
pop bx
cmp grid[bx],"w"
jz diagonalRightDownAB 
jmp diagonalLeftUpB

diagonalRightDownAB:
popAll

pushAll
; increment row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalRightDownB: 
inc ah
inc al
convertToTile ax
; if black
cmp grid[bx], "w"
jz diagonalRightDownLastB
; if empty
cmp grid[bx], "-"
jnz diagonalLeftDownAB
; out of bound
cmp bx, 128D
ja diagonalLeftDownAB
; out of bound
cmp bx, 0D
jb diagonalLeftDownAB
; add to moves 
diagonalRightDownLastB:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
add count, 4

pop cx
pop bx
cmp grid[bx],"w"
jz diagonalLeftDownAB 
jmp diagonalRightDownB

diagonalLeftDownAB:
popAll



pushAll
; increment row, col
; convert to tile 
; if it's empty and not out of bound 
; add to moves 
diagonalLeftDownB: 
inc ah
dec al
convertToTile ax
; if black
cmp grid[bx], "w"
jz diagonalLeftDownLastB
; if empty
cmp grid[bx], "-"
jnz continue
; out of bound
cmp bx, 128D ; check if equal works
ja continue
; out of bound
cmp bx, 0D ; check if equal works
jb continue
; add to moves 
diagonalLeftDownLastB:
push bx
push cx
mov cx, 0

mov cx, ax



mov bh, 0
mov bl, count
push cx
push dx
inc dl 
inc dh
inc cl
inc ch
mov moves[bx], dx
mov moves[bx + 2], cx
pop dx
pop cx
add count, 4

pop cx
pop bx
cmp grid[bx],"w"
jz continue 
jmp diagonalLeftDownB

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