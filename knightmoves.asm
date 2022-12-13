
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
     db "--","--","--","wn","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","--","wb","wk","wq","wb","wn","wr"
                                  
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


; base 1
mov ah, 4h
mov al, 4h

; base 0
dec ah
dec al

; maintain original position
mov dx,ax

pushAll


convertToTile ax



cmp grid[bx], "w"
jne black
; done
; row = row - 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m1:
mov ax, dx
dec ah 
dec ah 
dec al
convertToTile ax

cmp grid[bx],'w'
jz m2

cmp bx, 128D
ja m2

cmp bx, 0D
jb m2 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4
; done
; row = row - 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m2:
mov ax, dx

dec ah 
dec al
dec al

convertToTile ax

cmp grid[bx],'w'
jz m3

cmp bx, 128D
ja m3

cmp bx, 0D
jb m3 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4
; done
; row = row + 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m3:
mov ax, dx

inc ah 
dec al
dec al

convertToTile ax

cmp grid[bx],'w'
jz m4

cmp bx, 128D
ja m4

cmp bx, 0D
jb m4 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4

; row = row + 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m4:
mov ax, dx

inc ah 
inc ah 
dec al
convertToTile ax

cmp grid[bx],'w'
jz m5

cmp bx, 128D
ja m5

cmp bx, 0D
jb m5 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4

; row = row + 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m5:
mov ax, dx

inc ah 
inc ah 
inc al

convertToTile ax

cmp grid[bx],'w'
jz m6

cmp bx, 128D
ja m6

cmp bx, 0D
jb m6 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4

; row = row + 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m6:
mov ax, dx

inc ah 
inc al
inc al

convertToTile ax

cmp grid[bx],'w'
jz m7

cmp bx, 128D
ja m7

cmp bx, 0D
jb m7 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4

; row = row - 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m7:
mov ax, dx

dec ah 
inc al
inc al
convertToTile ax

cmp grid[bx],'w'
jz m8

cmp bx, 128D
ja m8

cmp bx, 0D
jb m8 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4

; row = row - 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m8:
mov ax, dx

dec ah 
dec ah 
inc al
convertToTile ax

cmp grid[bx],'w'
jz cont

cmp bx, 128D
ja cont

cmp bx, 0D
jb cont 

mov bx,0
mov bl,count 
mov moves[bx],dx
mov moves[bx+2],ax
add count, 4






black:


cont: 
popAll
hlt 
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