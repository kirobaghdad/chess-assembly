
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

;;Gets the index in BX (Given the pos in AX (0-indexed))


.model large
.stack 64
.data
grid db "br","bn","bb","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","wb"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wk","wq","wb","wn","wr"
                                  
moves dw 100 dup('$')
count db 0          
.code







addMove proc
mov bh, 0
mov bl, count

mov moves[bx], cx
add count, 2

ret

addMove endp

;Given the bishop position in the board, this procedure returns the available moves of this pawn
bishopMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 


pushAll

dec ah
dec al

mov dx,ax



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
convertToTile ax
cmp grid[bx], dh
je LastdiagonalRightUp
; if empty
cmp grid[bx], "-"
jnz diagonalLeftUpA
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
convertToTile ax
cmp grid[bx],dh
je LastdiagonalLeftUp
; if empty
cmp grid[bx], "-"
jnz diagonalRightDownA

cmp ah, 7h
ja diagonalRightDownA
; out of bound
cmp ah, 0h
jb diagonalRightDownA

; out of bound
cmp al, 7h
ja diagonalRightDownA

cmp al, 0h
jb diagonalRightDownA

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
convertToTile ax
cmp grid[bx], dh
je LastdiagonalRightDown
; if empty
cmp grid[bx], "-"
jnz diagonalLeftDownA
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
convertToTile ax
; if empty
cmp grid[bx], dh
je LastdiagonalLeftDown

cmp grid[bx], "-"
jnz continue
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




RockMoves proc 
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


;Given the bishop position in the board, this procedure returns the available moves of this pawn
queenMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays


    mov ah, 8h
    mov al, 5h
    push ax
    call bishopMoves
    pop ax
    call RockMoves

ret

queenMoves endp



start:
mov ax, @data
mov ds, ax

call queenMoves
hlt

end start

.end
END