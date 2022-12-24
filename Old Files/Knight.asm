
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

addToMovesKnight macro
push bx
push cx

mov cx, ax
inc cl 
inc ch

mov bx,0
mov bl,count 


mov moves[bx],cx
add count, 2

pop cx 
pop bx
endm addToMovesKnight

.model large
.stack 64
.data
grid db "br","bn","bb","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","wn","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","--","wb","wk","wq","wb","wn","wr"
                                  
moves dw 100 dup('$')
count db 0
  
  
.code


;Given the knight position in the board, this procedure returns the available moves of this knight
knightMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 


; base 1
mov ah, 4h
mov al, 4h

; base 0

; maintain original position
mov dx,ax

pushAll

dec ah
dec al


convertToTile ax


cmp grid[bx], "w"
je whiteKnight
jmp blackKnight


whiteKnight:
mov dl,"w"
mov dh,"b"
jmp m1
blackKnight:
mov dl,"b"
mov dh,"w"


; done
; row = row - 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m1:
pushAll
dec ah 
dec ah 
dec al

cmp ah, 7h
ja m2
cmp ah, 0h
jb m2
; out of bound
cmp al, 7h     
ja m2
cmp al, 0h
jb m2


convertToTile ax

cmp grid[bx],dl
jz m2
addToMovesKnight

; done
; row = row - 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m2:
popAll
pushAll
dec ah 
dec al
dec al

cmp ah, 7h
ja m3
cmp ah, 0h
jb m3
; out of bound
cmp al, 7h     
ja m3
cmp al, 0h
jb m3


convertToTile ax

cmp grid[bx],dl
jz m3

addToMovesKnight; done




; row = row + 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m3:
popAll
pushAll
inc ah 
dec al
dec al

cmp ah, 7h
ja m4
cmp ah, 0h
jb m4
; out of bound
cmp al, 7h     
ja m4
cmp al, 0h
jb m4


convertToTile ax

cmp grid[bx],dl
jz m5

addToMovesKnight

; row = row + 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m4:
popAll
pushAll
inc ah 
inc ah 
dec al

cmp ah, 7h
ja m5
cmp ah, 0h
jb m5
; out of bound
cmp al, 7h     
ja m5
cmp al, 0h
jb m5


convertToTile ax

cmp grid[bx],dl
jz m5

addToMovesKnight

; row = row + 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m5:
popAll
pushAll
inc ah 
inc ah 
inc al

cmp ah, 7h
ja m6
cmp ah, 0h
jb m6
; out of bound
cmp al, 7h     
ja m6
cmp al, 0h
jb m6


convertToTile ax

cmp grid[bx],dl
jz m6
addToMovesKnight
; row = row + 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m6:
popAll
pushAll
inc ah 
inc al
inc al
cmp ah, 7h
ja m7
cmp ah, 0h
jb m7
; out of bound
cmp al, 7h     
ja m7
cmp al, 0h
jb m7
convertToTile ax
cmp grid[bx],dl
jz m7
addToMovesKnight

; row = row - 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m7:
popAll
pushAll
dec ah 
inc al
inc al
cmp ah, 7h
ja m8
cmp ah, 0h
jb m8
; out of bound
cmp al, 7h     
ja m8
cmp al, 0h
jb m8

convertToTile ax

cmp grid[bx],dl
jz m8
addToMovesKnight

; row = row - 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m8:
popAll
pushAll
dec ah 
dec ah 
inc al
cmp ah, 7h
ja cont
cmp ah, 0h
jb cont
; out of bound
cmp al, 7h     
ja cont
cmp al, 0h
jb cont
convertToTile ax
cmp grid[bx],dl
jz cont
addToMovesKnight

cont: 
popAll
popAll

ret

knightMoves endp



start:
mov ax, @data
mov ds, ax

call knightMoves
hlt

end start

.end




END