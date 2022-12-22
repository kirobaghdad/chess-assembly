public PawnMoves
public RockMoves
public KingMoves
public getIndex
public moves
public makeMove
public ClearMoves
public knightMoves
public bishopMoves

extrn grid:byte


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

add bx, 2
jmp l


c42:

mov count, 0
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
jmp c5

c16:
cmp grid[bx - 16d + 2d], 'b'
je c3
jmp c5

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

; mov al, grid[33]
; mov bh, 0
; mov bl, 0F0h
; mov cx, 1
; mov ah, 09h
; int 10h


pop ax


ret
makeMove endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Knight Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Given the bishop position in the board, this procedure returns the available moves of this pawn
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

sub ax, 0101h
; maintain original position (0-indexed) in dx
mov dx,ax

pushAll
convertToTile ax

cmp grid[bx], "w"
je m1
jmp near ptr black
; done
; row = row - 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m1:
mov ax, dx

cmp ah, 1
jle m2
cmp al, 0
je m2

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
mov moves[bx],ax
add count, 2
; done
; row = row - 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m2:
mov ax, dx

cmp ah, 0
je m3
cmp al, 1
jle m3

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
mov moves[bx],ax
add count, 2
; done
; row = row + 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m3:
mov ax, dx

cmp ah, 7
je m4
cmp al, 1
jle m4

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
mov moves[bx],ax
add count, 2

; row = row + 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m4:
mov ax, dx

cmp ah, 6
jge m5
cmp al, 0
je m5

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
mov moves[bx],ax
add count, 2

; row = row + 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m5:
mov ax, dx

cmp ah, 6
jge m6
cmp al, 7
je m6

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
mov moves[bx],ax
add count, 2

; row = row + 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m6:
mov ax, dx

cmp ah, 7
je m7
cmp al, 6
jge m7


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
mov moves[bx],ax
add count, 2

; row = row - 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m7:
mov ax, dx

cmp ah, 0
je m8
cmp al, 6
jge m8

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
mov moves[bx],ax
add count, 2

; row = row - 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m8:
mov ax, dx

cmp ah, 1
jg c44
jmp cont

c44:
cmp al, 7
jne c45
jmp cont

c45:
dec ah 
dec ah 
inc al
convertToTile ax

cmp grid[bx],'w'
jnz x1n
jmp near ptr cont
x1n:
cmp bx, 128D
jb x2n
jmp near ptr cont
x2n:
cmp bx, 0D
ja x3n
jmp near ptr cont
x3n: 

mov bx,0
mov bl,count 
mov moves[bx],ax
add count, 2


black:

m1b:
mov ax, dx
cmp al, 0
je m2b
cmp ah, 1
jle m2b

dec ah 
dec ah 
dec al

convertToTile ax

cmp grid[bx],'b'
jz m2b

cmp bx, 128D
ja m2b

cmp bx, 0D
jb m2b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2
; done
; row = row - 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m2b:
mov ax, dx

cmp al, 1
jle m3b
cmp ah, 0
je m3b

dec ah 
dec al
dec al

convertToTile ax

cmp grid[bx],'b'
jz m3b

cmp bx, 128D
ja m3b

cmp bx, 0D
jb m3b 

mov bx,0
mov bl,count 
add ax, 0101h 
mov moves[bx],ax
add count, 2
; done
; row = row + 1, col = col - 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m3b:
mov ax, dx

cmp al, 1
jle m4b
cmp ah, 7
je m4b

inc ah 
dec al
dec al

convertToTile ax

cmp grid[bx],'b'
jz m4b

cmp bx, 128D
ja m4b

cmp bx, 0D
jb m4b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2

; row = row + 2, col = col - 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m4b:
mov ax, dx

cmp al, 0
je m5b
cmp ah, 6
jge m5b

inc ah 
inc ah 
dec al
convertToTile ax

cmp grid[bx],'b'
jz m5b

cmp bx, 128D
ja m5b

cmp bx, 0D
jb m5b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2

; row = row + 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m5b:
mov ax, dx

cmp al, 7
je m6b
cmp ah, 6
jge m6b

inc ah 
inc ah 
inc al

;; (Debugging)
; push ax

; add ah, 48
; mov al, ah
; mov bh, 0
; mov bl, 0F0h
; mov cx, 1
; mov ah, 09h
; int 10h

; pop ax


convertToTile ax

cmp grid[bx],'b'
jz m6b

cmp bx, 128D
ja m6b

cmp bx, 0D
jb m6b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2

; row = row + 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m6b:
mov ax, dx

cmp al, 6
jge m7b
cmp ah, 7
je m7b

inc ah 
inc al
inc al

convertToTile ax

cmp grid[bx],'b'
jz m7b

cmp bx, 128D
ja m7b

cmp bx, 0D
jb m7b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2

; row = row - 1, col = col + 2
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m7b:
mov ax, dx

cmp al, 6
jge m8b
cmp ah, 0
je m8b

dec ah 
inc al
inc al

convertToTile ax

cmp grid[bx],'b'
jz m8b

cmp bx, 128D
ja m8b

cmp bx, 0D
jb m8b 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2

; row = row - 2, col = col + 1
; ax -> desired position
; bx -> index on the grid
; dx -> original index base 0
m8b:
mov ax, dx

cmp al, 7
je cont
cmp ah, 1
jle cont

dec ah 
dec ah 
inc al
convertToTile ax

cmp grid[bx],'b'
jz cont

cmp bx, 128D
ja cont

cmp bx, 0D
jb cont 

mov bx,0
mov bl,count
add ax, 0101h 
mov moves[bx],ax
add count, 2


cont: 
popAll 
ret

knightMoves endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bishop Moves ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Given the bishop position in the board, this procedure returns the available moves of this pawn
bishopMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays

;pop ax
;;Assuming (8,3) 



; mov ah, 5h
; mov al, 4h

pushAll

sub ax, 0101h

mov dx,ax

convertToTile ax

cmp grid[bx], "w"
jz diagonalRightUp
jmp near ptr black2


; decrement row, increment col
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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

pop cx
pop bx
cmp grid[bx],"b"
jnz bx4
jmp near ptr continue
bx4:
jmp diagonalLeftDown

; --------------------------------------------black---------------------------------------------

black2: 

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

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
mov moves[bx], cx
pop dx
pop cx
add count, 2

pop cx
pop bx
cmp grid[bx],"w"
jz continue 
jmp diagonalLeftDownB

continue:
popAll


ret

bishopMoves endp



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