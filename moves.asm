
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

main proc
mov ax, @data
mov ds, ax

call PawnMoves

main endp


;Given the pawn position in the board, this procedure returns the available moves of this pawn
PawnMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax


mov ah, 2h
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
;;Assuming (7,2)     
; ah = 6
; al = 1


;Check if there is a piece in front of it
;8 * (ah - 1) + al = 82D
cmp grid[bx - 16d], "-"
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
je c3
jmp cont

c3:

push bx

mov bh, 0
mov bl, count

mov cx, dx
inc cl
dec ch

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx

jmp cont


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Black Pawn ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Black Pawn
black:
;Check if it is its first move
;;Assuming (2,2)     

mov dx, ax

dec ah
dec al

;ah = 1
;al = 1

;;Getting the index of the piece in the grid
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

;;bx = 18d

;Check if there is a piece in front of it
;8 * (ah - 1) + al = 82D
cmp grid[bx + 16d], "-"
jne RL_B


;Updating cx (The Destination)
mov cx, dx

inc ch

push bx

mov bh, 0
mov bl, count

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx

;Check if it is its first move
cmp ah, 2
jne RL_B


cmp grid[bx + 32d], "-"
jne RL_B

push bx
mov bh, 0
mov bl, count

mov cx, dx

;The ch = 5
add ch, 2

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx


;Right and Left Moves
RL_B:
;;Left Move
cmp al, 0
je R_B

cmp grid[bx + 16d - 2d], 'w'
jne R_B

push bx

mov cx, dx
dec cl ;; Col
inc ch ;; Row

mov bh, 0
mov bl, count

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

pop bx

R_B:
;;Right Move
cmp grid[bx + 16d + 2d], 'w'
jne cont

push bx

mov bh, 0
mov bl, count

mov cx, dx
inc cl ;; Col
inc ch ;; Row

mov moves[bx], dx
mov moves[bx + 2], cx
add count, 4

jmp cont


pop bx

cont:

ret

PawnMoves endp



END