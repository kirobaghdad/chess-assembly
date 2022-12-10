
global grid 

;Moves format: sourceRow SourceCol, destRow DestCol    
.data
moves dw 100 dup('$')
count db 0
  
  
call PawnMoves

  

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
je cont

cmp ah, 8
je cont


dec ah
dec al
dec ah

;ah = 5
;al = 1

push ax
mov bx, 0
mov bl, 8h

mov dl, al ; Maintaining the al
mov al, ah

mul bl

add al, dl


pop ax
               
mov dx, grid


mov dx, ax


;cmp grid[8 * ah + al], "w"
jne black

;;White Pawn


;Check if there is a piece in front of it
;cmp grid[8 * (ah - 1) + al], "--"
jne RL

mov cx, dx
dec ch

;mov moves[count], dx
;mov moves[count + 1], cx
add count, 2

;Check if it is its first move
cmp ah, 5
jne cont

;cmp grid[8 * (ah- 2) + al], "--"
jne RL

dec ch
;mov moves[count], dx
;mov moves[count + 1], cx
add count, 2

;Right and Left Moves
RL:
;;Left Move
cmp dl, 1
je R
;cmp grid[8 * (ah-1) + al - 1], 'b'
jne R

mov cx, dx
dec cl
dec ch

;mov moves[count], dx
;mov moves[count + 1], cx
add count, 2

R:
;cmp grid[8 * (ah-1) + al + 1], 'b'
jne cont

mov cx, dx
inc cl
dec ch

;mov moves[count], dx
;mov moves[count + 1], cx
add count, 2

jmp cont

;;Black Pawn
black:
;Check if it is its first move
cmp ah, 0


cont:


ret

END