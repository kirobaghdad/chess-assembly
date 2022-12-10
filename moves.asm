
; extrn grid:byte

;Moves format: sourceRow SourceCol, destRow DestCol    

.model large
.stack 64
.data
grid db "br","bn","bb","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wk","wq","wb","wn","wr"
                                  
moves dw 100 dup('$')
count db 0
  
  
.code


;Given the pawn position in the board, this procedure returns the available moves of this pawn
PawnMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (7,2)     


mov ah, 7h
mov al, 2h

cmp ah, 1
jne c0
jmp cont

c0:

cmp ah, 8
jne c1
jmp cont

c1:

mov dx, ax


dec ah
dec al

;ah = 6
;al = 1


push ax
mov bx, 0
mov bl, 16d

mov cl, al ; Maintaining the al
mov al, ah

mul bl

mov ch, al

mov al, cl

mov bl,2d

mul bl

add al, ch

mov bx, ax

pop ax

cmp grid[bx], "w"
je c2
jmp black

c2:
;;White Pawn

;Check if there is a piece in front of it
;8 * (ah - 1) + al = 82D
cmp grid[bx - 16h], "-"
jne RL


;Updating cx (The Destination)
mov cx, dx
dec ch

push bx

mov bh, 0
mov bl, count

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx

;Check if it is its first move
cmp ah, 6
jne RL


cmp grid[bx- 32d], "-"
jne RL

push bx
mov bh, 0
mov bl, count

mov cx, dx

;The ch = 5
sub ch, 2

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx



;Right and Left Moves
RL:
;;Left Move
cmp al, 0
je R

cmp grid[bx - 16d - 2d], 'b'
jne R

push bx

mov cx, dx
dec cl
dec ch

mov bh, 0
mov bl, count

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx

R:
;;Right Move
cmp grid[bx - 16d + 2d], 'b'
jne cont



push bx

mov bh, 0
mov bl, count

mov cx, dx
inc cl
dec ch

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

jmp cont


pop bx


;;Black Pawn
black:
;Check if it is its first move
cmp ah, 0


cont:

ret

PawnMoves endp



start:
mov ax, @data
mov ds, ax

call PawnMoves


END