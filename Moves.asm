.186
;; getMoves Procedures
public PawnMoves
public RockMoves
public KingMoves
public knightMoves
public bishopMoves
public queenMoves

public ClearMoves
public getIndex
public makeMove
public moves
public moves_p2

public player_no
public winner 

extrn grid:byte
extrn get_cell_x:word
extrn get_cell_y:word
extrn drawHighlight:far
extrn time:byte
extrn capturedPiece:word
extrn white_king_pos:word
extrn black_king_pos:word

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (Debugging)
DrawRectangle macro x_0, y_0, x_1, y_1
local border, row, l, m
pusha

;;;;;;;;;;;Draw highlight at first position

; mov di,x_0
; mov si,y_0

; cmp di,curr_marked_x_pixel
; jnz l
; cmp si,curr_marked_y_pixel
; jnz m

; mov al,0Ch

l:
m:
mov ah, 0ch
mov dx, y_0

border:
mov cx, x_0

row:
int 10h
inc cx
cmp cx, x_1
jne row

inc dx
cmp dx, y_1
jne border

popa
endm


convertToTile macro position ;; ax is 0-indexed

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
local c64, c65
push bx
push cx

mov cx, ax
inc cl 
inc ch

cmp player_no, 2
je c64
mov bx,0
mov bl,count 
mov moves[bx],cx
add count, 2
jmp c65

c64:
mov bx,0
mov bl,count_p2 
mov moves_p2[bx],cx
add count_p2, 2

c65:
pop cx 
pop bx
endm addToMovesKnight

get_cell macro row_x,col_y
local add_square_val , add_square_val_2   

pusha

;(Board Position);;;;;;;;;;;
mov cx,50
mov dx,-22

mov si,row_x
mov di,col_y

add_square_val:

add cx,22

dec si
jnz add_square_val

add_square_val_2:

add dx,22

dec di
jnz add_square_val_2

mov get_cell_x, cx
mov get_cell_y, dx


popa
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
moves_p2 dw 100 dup('$')
count db 0
count_p2 db 0

player_no db 0
winner db 0  ;; 1 means black and 2 means white

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Play Sound ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

playMoveSound proc far

    mov ax, 03efh

    mov cx, 1
    mov dx, 024f8h

    pusha        
    mov bx, ax   
    mov al, 182  
    out 43h, al  
    mov ax, bx   
    out 42h, al  
    mov al, ah   
    out 42h, al  
    in al, 61h   
    or al, 03h   
    out 61h, al  
    mov ah, 86h  
    int 15h      
    in al, 61h   
    and al, 0fch 
    out 61h, al  
    popa         
    ret          

playMoveSound endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Clear Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ClearMoves proc far

mov si, 0 ;; Counter

l:
cmp player_no, 2
je c66

mov cx, moves[si]
jmp c67

c66:
mov cx, moves_p2[si]

c67:
; mov dl, cl
; add dl, 48d
; mov ah, 2
; int 21h

cmp cl,'$'
jne c50
jmp c42

c50:
push si


mov ax, 0
mov al, cl

mov bx, 0
mov bl, ch

get_cell ax, bx

push cx 
mov cx, get_cell_x
mov dx, get_cell_y

mov ah, 0dh
int 10h

pop cx

; mov ax, 0
; mov al, cl
; add al, ch



; mov bl, 2
; div bl

; cmp ah, 1 ;; Dark (Odd)
; je dark5
; ;; Light
; mov al, 7
; jmp c46
; dark5:
; mov al, 8



c46:
push ax  ;; To maintain al

;;X (AX)
mov ax, cx
and ax, 00FFh


;;Y (BX)
mov bx, cx
and bx, 0FF00h
shr bx, 8

; mov dl, bl
; add dl, 48d
; mov ah, 2
; int 21h


get_cell ax, bx

; ; (Debugging)
; mov si, get_cell_x
; add si, 22
; mov di, get_cell_y
; add di, 22
; mov al, 5
; DrawRectangle get_cell_x, get_cell_y, si, di 
; ; (Debugging);;;;;;;
pop ax

mov cx, get_cell_x
mov dx, get_cell_y

mov si, get_cell_x
add si, 22  ;;X end

mov di, get_cell_y
add di, 22  ;; Y end

col0:

r00:
push ax

; mov dl, count
; add dl, 48
; mov ah, 2
; int 21h

mov ah, 0dh
int 10h

cmp al, 02
je draw
cmp al, 0ah
je draw
jmp c47

draw:
pop ax

mov ah, 0ch
int 10h

jmp c48

c47:
pop ax

c48: ;;;(not poping again)
inc cx
cmp cx, si

jne r00

mov cx, get_cell_x

inc dx
cmp dx, di

jne col0 

c49:

pop si

cmp player_no, 2
je c68
mov moves[si], '$$'
jmp c69
c68:
mov moves_p2[si], '$$'

c69:

add si, 2
jmp l

c42:

cmp player_no, 2
je c70
mov count, 0
jmp c71
c70:
mov count_p2, 0


c71:

; mov dx, moves[0]
; add dl, 48
; mov ah, 2
; int 21h


; mov dl, 'Z'
; mov ah, 2
; int 21h



ret

; mov bx, offset moves

; l:
; mov cx, [bx]
; cmp cl,'$'
; je c42

; mov [bx], '$$'

; add bx, 2
; jmp l


; c42:

; mov count, 0
; ret
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


push bx

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

mov ax, bx
mov cl, 2
div cl

mov bx, ax

mov time[bx], 3

mov al, grid[di]
mov grid[di], '-'
mov ah, grid[di+1]
mov grid[di+1], '-'

cmp grid[si+1], 'k'
jne c88
cmp grid[si], 'b'
jne c89
mov winner, 2
jmp c88

c89:
mov winner, 1

c88:

mov bh, grid[si]  
mov bl, grid[si+1] 

mov capturedPiece, bx

; push ax
; cmp capturedPiece, 'bp'
; jne c90
; mov dl, 48d
; mov ah, 2
; int 21h

; c90:
; pop ax

mov grid[si], al
mov grid[si+1], ah

pop bx

cmp ah, 'k'
jne c52
cmp al, 'w'
jne c51

mov white_king_pos, bx
jmp c52

c51:
cmp al, 'b'
jne c52

mov black_king_pos, bx

c52:
call playMoveSound

ret
makeMove endp

addMove proc far

cmp player_no, 2
je c
mov bh, 0
mov bl, count
mov moves[bx], cx
add count, 2
jmp d

c:
mov bh, 0
mov bl, count_p2
mov moves_p2[bx], cx
add count_p2, 2

d:


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
jmp c5

c0:
cmp ah, 8
jne c1
jmp c5

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
jmp black1

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
mov bl, count_p2


mov moves_p2[bx], cx
add count_p2, 2

pop bx

;Check if it is its first move
cmp ah, 6
jne RL


cmp grid[bx- 32d], "-"
jne RL

push bx
mov bh, 0
mov bl, count_p2

mov cx, dx

;The ch = 5
sub ch, 2

mov moves_p2[bx], cx
add count_p2, 2

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
mov bl, count_p2

mov moves_p2[bx], cx
add count_p2, 2

pop bx

R:
;;Right Move
cmp ah, 7
jne c16
jmp c5

c16:
cmp grid[bx - 16d + 2d], 'b'
je c3
jmp c5

c3:

push bx

mov bh, 0
mov bl, count_p2

mov cx, dx
inc cl
dec ch

mov moves_p2[bx], cx
add count_p2, 2

pop bx

jmp c5


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Black Pawn ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Black Pawn
black1:
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
je c5

cmp grid[bx + 16d + 2d], 'w'
jne c5

push bx

mov bh, 0
mov bl, count

mov cx, dx
inc cl ;; Col
inc ch ;; Row

mov moves[bx], cx
add count, 2

pop bx

jmp c5

c5:

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
mov ah, 'w' ;; me
mov al, 'b' ;; enemy
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


; push ax
; push dx
; mov dl, count_p2
; add dl, 48d

; mov ah, 2
; int 21h

; pop ax
; pop dx

ret

RockMoves endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Knight Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
knightMoves proc far
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 


; base 1
; mov ah, 4h
; mov al, 4h

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
jz m4

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bishop Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Given the bishop position in the board, this procedure returns the available moves of this bishop
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
mov dl,"w"  ;; me 
mov dh,"b"  ;; enemy
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
inc cl
inc ch

cmp player_no, 2
je c80
mov bl, count
mov moves[bx], cx
add count, 2
jmp c81
c80:
mov bl, count_p2
mov moves_p2[bx], cx 
add count_p2, 2
c81:

pop cx
pop bx
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
inc cl
inc ch

cmp player_no, 2
je c82
mov bl, count
mov moves[bx], cx
add count, 2
jmp c83
c82:
mov bl, count_p2
mov moves_p2[bx], cx
add count_p2, 2

c83:
pop cx
pop bx
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
inc cl
inc ch

cmp player_no, 2
je c84
mov bl, count
add count, 2
mov moves[bx], cx
jmp c85
c84:
mov bl, count_p2
add count_p2, 2
mov moves_p2[bx], cx

c85:

pop cx
pop bx
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
inc cl
inc ch

cmp player_no, 2
je c86
mov bl, count
mov moves[bx], cx
add count, 2
jmp c87
c86:
mov bl, count_p2
mov moves_p2[bx], cx
add count_p2, 2

c87:
pop cx
pop bx
cmp grid[bx],dh
je continue
jmp diagonalLeftDown

continue:
popAll
popAll

ret

bishopMoves endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Queen Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Given the bishop position in the board, this procedure returns the available moves of this queen
queenMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays


    ; mov ah, 8h
    ; mov al, 5h
    push ax
    call bishopMoves
    pop ax
    call RockMoves

ret

queenMoves endp

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