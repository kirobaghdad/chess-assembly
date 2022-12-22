public PawnMoves
public RockMoves
public KingMoves
public getIndex
public moves
public makeMove
public ClearMoves

extrn grid:byte


;Moves format: sourceRow SourceCol, destRow DestCol    

.model large
.data
;         ;1    2    3    4    5    6    7    8
; grid db "br","bn","bb","bq","bk","bb","bn","br" ; 1
;      db "bp","bp","bp","bp","bp","bp","bp","bp" ; 2                        
;      db "--","--","--","--","--","--","--","--" ; 3
;      db "--","--","--","--","--","--","--","--" ; 4
;      db "--","--","--","--","--","--","--","--" ; 5
;      db "--","--","--","--","--","--","--","--" ; 6
;      db "wp","wp","wp","wp","wp","wp","wp","wp" ; 7
;      db "wr","wn","wb","wq","wk","wb","wn","wr" ; 8
                                  
moves dw 100 dup('$')
count db 0
  

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Clear Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearMoves proc far

mov bx, offset moves

l:
mov cx, [bx]
cmp cl,'$'
je c42

mov [bx], '$$'

inc bx
jmp l

c42:

ret
ClearMoves endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Get Index  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Gets the index in BX (Given the pos in AX (0-indexed))
getIndex proc far
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

ret

getIndex endp




addMove proc
mov bh, 0
mov bl, count

mov moves[bx], cx
add count, 2

ret

addMove endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Pawn Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Given the pawn position in the board, this procedure returns the available moves of this pawn
PawnMoves proc far
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;Assuming that the pawn location is (6,7) (The board is 1-indexed)

; mov ah, 6h ;; Row
; mov al, 7h ;; Col


;;Checking if the pawn is in the first or the last row
cmp ah, 1
jne c0
jmp cont

c0:
cmp ah, 8
jne c1
jmp cont

;;;;;
c1:
mov dx, ax
dec ah
dec al

;Getting the index of the piece in the grid
push ax
call getIndex
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
push bx

mov cx, dx
dec ch

mov bh, 0
mov bl, count

mov moves[bx], cx
add count, 2

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

mov moves[bx], cx
add count, 2

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

mov moves[bx], cx
add count, 2

pop bx

R:
;;Right Move
cmp ah, 7
jne c16
jmp cont

c16:
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

mov moves[bx], cx
add count, 2

pop bx

jmp cont


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Black Pawn ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Black Pawn
black:
;Check if it is its first move
;;Assuming (2,2)     


;ah = 1
;al = 1


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

mov moves[bx], cx
add count, 2

pop bx

;Check if it is its first move
cmp ah, 1
jne RL_B


cmp grid[bx + 32d], "-"
jne RL_B

push bx
mov bh, 0
mov bl, count

mov cx, dx

add ch, 2

mov moves[bx], cx
add count, 2

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

mov moves[bx], cx
add count, 2

pop bx

R_B:
;;Right Move
cmp al, 7
je cont

cmp grid[bx + 16d + 2d], 'w'
jne cont

push bx

mov bh, 0
mov bl, count

mov cx, dx
inc cl ;; Col
inc ch ;; Row

mov moves[bx], cx
add count, 2

pop bx

jmp cont

cont:

ret

PawnMoves endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;King Moves;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KingMoves proc far

; ;;Assuming the king in pos (8,5)
; mov ah, 8
; mov al, 5

mov dx, ax

dec ah
dec al

;ax is 0-indexed
push ax
call getIndex
pop ax

cmp grid[bx], 'w'
mov ch, 'w'
je c10
mov ch, 'b'

c10:
;Right Move
cmp al, 7
je c00 ;Right is NOT valid 
cmp grid[bx + 2], ch
je c01

;;Adding the right move
push bx
push cx
mov cx, dx
inc  cl
call addMove
pop cx
pop bx

c01:

;;Up Right Move
cmp ah, 0
je c02 ;;Up is NOT Valid 
cmp grid[bx - 16d + 2d], ch
je c02

;Adding the up right move
push bx
push cx
mov cx, dx
inc cl
dec ch
call addMove
pop cx
pop bx

c02:

;;Down Right Move
cmp ah, 7
je c00 ;;Down is NOT Valid
cmp grid[bx + 16d + 2d], ch
je c00


;Adding the down right move
push bx
push cx
mov cx, dx
inc cl
inc ch
call addMove
pop cx
pop bx

;;Left Moves
c00:
cmp al, 0
je c06
cmp grid[bx - 2d], ch
je c04

;Adding the left move
push bx
push cx
mov cx, dx
dec cl
call addMove
pop cx
pop bx

;;Up Left Move
c04:
cmp ah, 0
je c05
cmp grid[bx -16d - 2d], ch
je c05

;Adding the up left move
push bx
push cx
mov cx, dx
dec cl
dec ch
call addMove
pop cx
pop bx

;;Down Left Move
c05:
cmp ah, 7
je c06
cmp grid[bx + 16d - 2d], ch
je c06

;Adding the up down move
push bx
push cx
mov cx, dx
dec cl
inc ch
call addMove
pop cx
pop bx

;Up and Down Moves
c06:
;;Up Move
cmp ah, 0
je c07 ;Up move is NOT Valid
cmp grid[bx - 16d], ch
je c07

;Adding the up move
push bx
push cx
mov cx, dx
dec ch
call addMove
pop cx
pop bx

c07:
;;Down move
cmp ah, 7
je cont0 ;;Down move is NOT Valid
cmp grid[bx + 16d], ch
je cont0

;Adding the down move
push bx
push cx
mov cx, dx
inc ch
call addMove
pop cx
pop bx

cont0:

ret
KingMoves endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Rock Moves;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
call getIndex


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Make Move ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

makeMove proc far
; Input
; ax -> source (1-indexed)
; bx -> destination (1-indexed)


;;;;;;;;;;;;;;;;
; di -> source index in grid
; si -> destination index in grid

dec al
dec ah
dec bl
dec bh

mov dx, bx ;Maintaining bx

call getIndex

mov di, bx
mov ax, dx

call getIndex

mov si, bx

mov al, grid[di]
mov grid[di], '-'
mov ah, grid[di+1]
mov grid[di+1], '-'

mov grid[si], al
mov grid[si+1], ah

push ax

mov al, grid[33]
mov bh, 0
mov bl, 0F0h
mov cx, 1
mov ah, 09h
int 10h


pop ax


ret
makeMove endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; start:
; ; main proc
; mov ax, @data
; mov ds, ax

; ; call RockMoves

; mov ax, 0204h
; mov bx, 0301h

; call makeMove
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; hlt;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; end start


END