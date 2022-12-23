.186
;; Pieces File
extrn black_bishop:byte
extrn black_king:byte
extrn black_knight:byte
extrn black_pawn:byte
extrn black_queen:byte
extrn black_rock:byte
extrn white_bishop:byte
extrn white_king:byte
extrn white_knight:byte
extrn white_pawn:byte
extrn white_queen:byte
extrn white_rock:byte
extrn green_dot:byte


;; Moves File
extrn PawnMoves:far
extrn KingMoves:far
extrn RockMoves:far
extrn knightMoves:far
extrn bishopMoves:far

extrn getIndex:far
extrn moves:word
extrn makeMove:far
extrn ClearMoves:far

;; Validate File
extrn validateMove:far
extrn allowed:byte


public grid

.model large
.stack 64
.data

position_in_grid  dw ?

grid db "br","bn","bb","bq","bk","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wq","wk","wb","wn","wr"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Check    Time   Macros and data   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                 

                                
grid_time_seconds   db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0

grid_time_minutes   db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0

grid_time_hourse    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0


get_position_in_grid macro x, y
pusha

mov ax, y
dec ax
mov cx,8

mul cx

add ax, x
dec ax

mov position_in_grid , ax

popa
endm

check_set_time macro
pusha

get_position_in_grid cell_clicked_source_x, cell_clicked_source_y 

mov cx, position_in_grid

mov bx , offset grid_time_seconds
mov di, offset grid_time_minutes

add bx,cx
add di,cx

mov ah,2ch
int 21h

mov al,dh
mov ah, cl

mov dx,ax

mov ch, [di]
mov cl, [bx] 

sub ax, cx
 
cmp ax, 3
jl greater_than_3

get_position_in_grid curr_cell_marked_val_x, curr_cell_marked_val_y 
mov cx, position_in_grid
mov bx , offset grid_time_seconds
mov di, offset grid_time_minutes

add bx,cx
add di,cx

mov [bx],dl
mov [di],dh

greater_than_3:

popa
endm
pieceWidth EQU 20
pieceHeight EQU 20

x0 dw 0
y0 dw 0
x1 dw 0
y1 dw 0

N dw 8
x dw ?
y dw ?

get_cell_x dw ?
get_cell_y dw ?

;;To be Updated (Board Position)
curr_marked_x_pixel dw 138
curr_marked_y_pixel dw 34
;;;;;;;

curr_marked_x_val dw 4
curr_marked_y_val dw 2

curr_marked_x_pixel_p2 dw 138
curr_marked_y_pixel_p2 dw 144
;;;;;;;

curr_marked_x_val_p2 dw 4
curr_marked_y_val_p2 dw 7


draw_piece_x dw  ?
draw_piece_y dw  ?


cell_clicked_x dw 0
cell_clicked_y dw 0 

cell_clicked_x_p2 dw 0
cell_clicked_y_p2 dw 0 



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


DrawRectangleMark macro x_0, y_0, x_1, y_1
local border, row, l, m, c1, notColored
pusha

mov ah, 0ch
mov dx, y_0

border:
mov cx, x_0

row:
push ax
mov ah, 0dh
int 10h

cmp al, 12h
je notColored
cmp al, 0fh
je notColored

pop ax
int 10h
jmp c1

notColored:
pop ax

c1:
inc cx
cmp cx, x_1
jne row

inc dx
cmp dx, y_1
jne border

popa
endm


ToggleColor macro c
local white, cont

cmp c, 8 ;Dark Grey
je white

mov c, 8
jmp cont

white:
mov c, 07h
cont: 

endm
 
Draw macro draw_x , draw_y , z;, x_r,y_c
local drawloop, jumb_if_black, l, m
; Drawing loop

pusha
mov cx,draw_x
mov dx,draw_y
mov bx,z
mov di,cx
add di, pieceWidth
mov si, dx
add si, pieceHeight

mov draw_piece_x , di
mov draw_piece_y , si

MOV AH,0ch

drawLoop:
    
    MOV AL,[bx]
    
    cmp al,0ffh
    jz jumb_if_black        
    INT 10h
    jumb_if_black: 
    
    INC CX
    INC BX
    CMP CX,draw_piece_x
JNE drawLoop 
	
    MOV CX , draw_x
    INC DX
    CMP DX , draw_piece_y
JNE drawLoop

popa
endm 

get_cell macro row_x,col_y
local add_square_val , add_square_val_2   

pusha

;(Board Position)
;; what are these numbers;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov cx,51
mov dx,-9

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

draw_grid macro
local row,col,con,con1

pusha

mov al, 6h ;Brown

DrawRectangle 0, 0, 320, 12

DrawRectangle 0, 12, 72, 188

DrawRectangle 248, 12, 320, 188

DrawRectangle 0, 188, 320, 200



mov y0, 12 
mov y1, 34

mov al, 07h ;light gray

col:
ToggleColor al
mov x0, 72 
mov x1, 94

row:
ToggleColor al

DrawRectangle x0, y0, x1, y1

add x0, 22
add x1, 22

cmp x0, 248

je con
jmp row
con:  

add y0, 22
add y1, 22

cmp y0, 188

je con1
jmp col
con1:    

popa
endm

draw_pieces_in_grid macro
local col,row,con,con1

pusha
mov bx, offset grid
mov x,1
mov y,1

col: 
row:
mov cx,[bx]
xchg ch,cl
cmp cx,"bb"
jnz not_black_bishop
get_cell x,y
mov di,offset black_bishop
draw get_cell_x , get_cell_y , di;, x, y
not_black_bishop:

cmp cx,"br"
jnz not_black_rock
get_cell x,y
mov di,offset black_rock
draw get_cell_x , get_cell_y , di;, x, y
not_black_rock:

cmp cx,"bn"
jnz not_black_knight
get_cell x,y
mov di,offset black_knight
draw get_cell_x , get_cell_y , di;, x, y
not_black_knight:

cmp cx,"bp"
jnz not_black_pawn
get_cell x,y
mov di,offset black_pawn
draw get_cell_x , get_cell_y , di;, x, y
not_black_pawn:

cmp cx,"bq"
jnz not_black_queen
get_cell x,y
mov di,offset black_queen
draw get_cell_x , get_cell_y , di;, x, y
not_black_queen:

cmp cx,"bk"
jnz not_black_king
get_cell x,y
mov di,offset black_king
draw get_cell_x , get_cell_y , di;, x, y
not_black_king:

cmp cx,"wb"
jnz not_white_bishop
get_cell x,y
mov di,offset white_bishop
draw get_cell_x , get_cell_y , di;, x, y
not_white_bishop:

cmp cx,"wr"
jnz not_white_rock
get_cell x,y
mov di,offset white_rock
draw get_cell_x , get_cell_y , di;, x, y
not_white_rock:

cmp cx,"wn"
jnz not_white_knight
get_cell x,y
mov di,offset white_knight
draw get_cell_x , get_cell_y , di;, x, y
not_white_knight:

cmp cx,"wp"
jnz not_white_pawn
get_cell x,y
mov di,offset white_pawn
draw get_cell_x , get_cell_y , di;, x, y
not_white_pawn:

cmp cx,"wq"
jnz not_white_queen
get_cell x,y
mov di,offset white_queen
draw get_cell_x , get_cell_y , di;, x, y
not_white_queen:

cmp cx,"wk"
jnz not_white_king
get_cell x,y
mov di,offset white_king
draw get_cell_x , get_cell_y , di;, x, y
not_white_king:

inc x
inc bx
inc bx
cmp x,9
jz con
jmp row
con:
mov x, 1
inc y
cmp y,9

jz con1
jmp col
con1:

popa
endm

.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw Highlight ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


drawHighlight proc far

mov si, offset moves

c43:
mov bx, [si]
cmp bl, '$'
jne c45
jmp c44


c45:
mov ax, [si]


;; Draw the highlight

mov di, offset green_dot


; mov get_cell_x, bx
; and get_cell_x, 00FFh

; mov get_cell_y, bx
; and get_cell_y, 0FF00h

mov bx, ax
and bx, 00FFh ;; X value

and ax, 0FF00h 

shr ax, 8  ;; Y Value

get_cell bx, ax
draw get_cell_x , get_cell_y , di;, x, y

add si, 2
jmp c43

c44:

ret
drawHighlight endp

start:

MOV AX , @DATA
MOV DS , AX

mov ah, 0
mov al, 13h
int 10h



draw_grid

;; Drawing the first player marker
mov al, 0ch
mov si, curr_marked_x_pixel
add si, 22

mov di, curr_marked_y_pixel
add di, 22

DrawRectangle curr_marked_x_pixel, curr_marked_y_pixel, si, di
  

;; Drawing the second player marker
mov al, 0bh
mov si, curr_marked_x_pixel_p2
add si, 22

mov di, curr_marked_y_pixel_p2
add di, 22

DrawRectangle curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, si, di
  
draw_pieces_in_grid 


;Down arrow       E0 50
;Left arrow       E0 4B
;Right arrow      E0 4D
;Up arrow         E0 48

game: 

mov ah,0
int 16h

cmp al,'d'     ;move right
jz c2
jmp m1

c2:
cmp curr_marked_x_val, 8
jne c10
jmp game

c10:
;; Update the Highlight position
mov dx,curr_marked_x_pixel
add dx, 22
mov curr_marked_x_pixel,dx


;; Update the Source Rect
mov ax, curr_marked_x_val
add ax, curr_marked_y_val

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark
mov al, 7h
jmp c3

dark:
mov al, 8

c3:
mov bp, curr_marked_x_pixel
sub bp, 22 

mov bx, curr_marked_y_pixel
add bx, 22

DrawRectangleMark bp, curr_marked_y_pixel, curr_marked_x_pixel, bx


;; Update the Destination Rect
inc curr_marked_x_val

add bp, 44

mov al, 0ch

DrawRectangleMark curr_marked_x_pixel, curr_marked_y_pixel, bp, bx

jmp game

m1:
cmp al,'w'  ;;;Move Up
jz c4
jmp m2

c4:
cmp curr_marked_y_val, 1
jne c11
jmp game

c11:
;; Update the Highlight position
mov dx,curr_marked_y_pixel
sub dx, 22
mov curr_marked_y_pixel,dx

;; Update the Source Rect
mov ax, curr_marked_x_val
add ax, curr_marked_y_val

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark1
mov al, 7h
jmp c5

dark1:
mov al, 8

c5:
mov bp, curr_marked_x_pixel
add bp, 22 

mov bx, curr_marked_y_pixel
add bx, 22

mov si, bx
add si, 22

DrawRectangleMark curr_marked_x_pixel, bx, bp, si


;; Update the Destination Rect
dec curr_marked_y_val

mov al, 0ch

DrawRectangleMark curr_marked_x_pixel, curr_marked_y_pixel, bp, bx

jmp game


m2:
cmp al,'s'
jz c7
jmp m3        ;move down

c7:
cmp curr_marked_y_val, 8
jne c12
jmp game

c12:
;; Update the Highlight position
mov dx,curr_marked_y_pixel
add dx, 22
mov curr_marked_y_pixel,dx

;; Update the Source Rect
mov ax, curr_marked_x_val
add ax, curr_marked_y_val

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark2
mov al, 7h
jmp c6

dark2:
mov al, 8

c6:
mov bp, curr_marked_x_pixel
add bp, 22 

mov bx, curr_marked_y_pixel
sub bx, 22

DrawRectangleMark curr_marked_x_pixel, bx, bp, curr_marked_y_pixel


;; Update the Destination Rect
inc curr_marked_y_val

add bx, 44

mov al, 0ch

DrawRectangleMark curr_marked_x_pixel, curr_marked_y_pixel, bp, bx

jmp game

m3:
cmp al,'a'
jz c8         ;move left
jmp m4

c8:
cmp curr_marked_x_val, 1
jne c13
jmp game

c13:
;; Update the Highlight position
mov dx,curr_marked_x_pixel
sub dx, 22
mov curr_marked_x_pixel,dx


;; Update the Source Rect
mov ax, curr_marked_x_val
add ax, curr_marked_y_val

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark3
mov al, 7h
jmp c9

dark3:
mov al, 8

c9:
mov bp, curr_marked_x_pixel
add bp, 22 

mov bx, curr_marked_y_pixel
add bx, 22

mov si, bp
add si, 22

DrawRectangleMark bp, curr_marked_y_pixel, si, bx

;; Update the Destination Rect
dec curr_marked_x_val

mov al, 0ch

DrawRectangleMark curr_marked_x_pixel, curr_marked_y_pixel, bp, bx

jmp game

m4:


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




cmp al,'6'     ;move right
jz c20
jmp m11

c20:
cmp curr_marked_x_val_p2, 8
jne c100
jmp game

c100:
;; Update the Highlight position
mov dx,curr_marked_x_pixel_p2
add dx, 22
mov curr_marked_x_pixel_p2,dx


;; Update the Source Rect
mov ax, curr_marked_x_val_p2
add ax, curr_marked_y_val_p2

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark10
mov al, 7h
jmp c30

dark10:
mov al, 8

c30:
mov bp, curr_marked_x_pixel_p2
sub bp, 22 

mov bx, curr_marked_y_pixel_p2
add bx, 22

DrawRectangleMark bp, curr_marked_y_pixel_p2, curr_marked_x_pixel_p2, bx


;; Update the Destination Rect
inc curr_marked_x_val_p2

add bp, 44

mov al, 0bh

DrawRectangleMark curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, bp, bx

jmp game

m11:



cmp al,'8'  ;;;Move Up
jz c40
jmp m22

c40:
cmp curr_marked_y_val_p2, 1
jne c110
jmp game

c110:
;; Update the Highlight position
mov dx,curr_marked_y_pixel_p2
sub dx, 22
mov curr_marked_y_pixel_p2,dx

;; Update the Source Rect
mov ax, curr_marked_x_val_p2
add ax, curr_marked_y_val_p2

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark110
mov al, 7h
jmp c50

dark110:
mov al, 8

c50:
mov bp, curr_marked_x_pixel_p2
add bp, 22 

mov bx, curr_marked_y_pixel_p2
add bx, 22

mov si, bx
add si, 22

DrawRectangleMark curr_marked_x_pixel_p2, bx, bp, si
               

;; Update the Destination Rect
dec curr_marked_y_val_p2

mov al, 0bh

DrawRectangleMark curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, bp, bx

jmp game


m22:






cmp al,'5'
jz c70
jmp m33        ;move down

c70:
cmp curr_marked_y_val_p2, 8
jne c120
jmp game

c120:
;; Update the Highlight position
mov dx,curr_marked_y_pixel_p2
add dx, 22
mov curr_marked_y_pixel_p2 ,dx

;; Update the Source Rect
mov ax, curr_marked_x_val_p2
add ax, curr_marked_y_val_p2

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark120
mov al, 7h
jmp c60

dark120:
mov al, 8

c60:
mov bp, curr_marked_x_pixel_p2
add bp, 22 

mov bx, curr_marked_y_pixel_p2
sub bx, 22

DrawRectangleMark curr_marked_x_pixel_p2 , bx, bp, curr_marked_y_pixel_p2


;; Update the Destination Rect
inc curr_marked_y_val_p2

add bx, 44

mov al, 0bh

DrawRectangleMark curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, bp, bx

jmp game

m33:




cmp al,'4'
jz c88         ;move left
jmp m44

c88:
cmp curr_marked_x_val_p2, 1
jne c130
jmp game

c130:
;; Update the Highlight position
mov dx,curr_marked_x_pixel_p2
sub dx, 22
mov curr_marked_x_pixel_p2 ,dx


;; Update the Source Rect
mov ax, curr_marked_x_val_p2
add ax, curr_marked_y_val_p2

mov bl, 2
div bl
cmp ah, 1  ;; Odd (Dark)
je dark130
mov al, 7h
jmp c90

dark130:
mov al, 8

c90:
mov bp, curr_marked_x_pixel_p2
add bp, 22 

mov bx, curr_marked_y_pixel_p2
add bx, 22

mov si, bp
add si, 22

DrawRectangleMark bp, curr_marked_y_pixel_p2, si, bx

;; Update the Destination Rect
dec curr_marked_x_val_p2

mov al, 0bh

DrawRectangleMark curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, bp, bx

jmp game

m44:




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp al,'q'         ; source
jz c15
jmp m5
c15:
cmp cell_clicked_x, 0
jz c18
jmp c16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;check





c18:
mov dx, curr_marked_x_val
mov cx, curr_marked_y_val


mov cell_clicked_x,dx
mov cell_clicked_y,cx

; mov al, 0ch
; DrawRectangle 0,0,20,20

mov ax, curr_marked_y_val
dec ax
shl ax, 8

add ax, curr_marked_x_val
dec ax

; mov bx,ax
; mov bp, bx
; add bp, 20d

; mov al, 0h
; DrawRectangle bx,0,bp,20

push ax
call getIndex
pop ax

; mov bp, bx
; add bp, 20d
; mov al, 0h

; DrawRectangle bx,0,bp,20

add ax, 0101h  ;; Make it 1-indexed

cmp grid[bx+1], 'r'
jne c36
call RockMoves

c36:
cmp grid[bx+1], 'n'  ;;To be tested
jne c37
call knightMoves

c37:
cmp grid[bx+1], 'b'  ;;To be tested
jne c38
call bishopMoves

c38:
cmp grid[bx+1], 'k'
jne c39
call KingMoves

c39:
cmp grid[bx+1], 'q' ;;To be tested
jne c41
;call queenMoves

c41:
call PawnMoves

; Drawing the moves highlight

call drawHighlight


; mov bx, moves[0]
; mov bp, bx
; add bp, 20

; ;;Green
; mov al, 2
; DrawRectangle bx,0,bp,20

jmp game

;;Second Click
c16:
;;Blue
; mov al, 1
; DrawRectangle 0,0,20,20


; malek was here
; to check time less than 3 or not
get_position_in_grid cell_clicked_x, cell_clicked_y 
mov al,4
mov cx, position_in_grid

mov bx, offset grid_time_seconds
mov di, offset grid_time_minutes
mov si, offset grid_time_hourse

add bx,cx
add di,cx
add si, cx

mov ah,2ch
int 21h

cmp ch, [si] 
jge less_than_h ; check for hours
jmp game
less_than_h:
push cx

mov al,dh
mov ah, cl

mov dx,ax

mov ch, [di]
mov cl, [bx] 

sub ax, cx
 
cmp ax, 3
jg less_than_3 ; check for minutes and seconds
jmp game
less_than_3:

get_position_in_grid curr_marked_x_val, curr_marked_y_val
mov cx, position_in_grid
mov bx , offset grid_time_seconds
mov di, offset grid_time_minutes

add bx,cx
add di,cx
add si,cx
pop cx
mov [bx],dl
mov [di],dh
mov [si],ch


mov ax, cell_clicked_y
shl ax, 8

add ax, cell_clicked_x


mov bx, curr_marked_y_val
shl bx, 8

add bx, curr_marked_x_val


mov bp, bx
add bp, 20

;;Black
mov al, 0
DrawRectangle bx,0,bp,20


call validateMove

;;;;;;;;;;;; Check Allowed
cmp allowed, 1
jz c35
jmp c19

c35:
mov allowed, 0
;;;Allowed (Make Move)

; ;Blue
; mov al, 1
; DrawRectangle 0,0,20,20

; mov bx, 

mov ax, cell_clicked_y
shl ax, 8
add ax, cell_clicked_x

mov bx, curr_marked_y_val
shl bx, 8
add bx, curr_marked_x_val


call makeMove  ;; Updating the grid


;; Updating the UI
;;Source Rect
mov ax, cell_clicked_x
add ax, cell_clicked_y

mov bl, 2
div bl

cmp ah, 1  ;; Dark (Odd)

je dark4
mov al, 7h
jmp c21

dark4:
mov al, 8

c21:

;;To be updated (Board Position)
push ax
; bx -> (X) start
mov ax, cell_clicked_x
dec ax

mov cl, 22
mul cl

add ax, 72 ;; (Board Position)
mov bx, ax

; bp -> (X) end
mov bp, bx
add bp, 22

; si -> (Y) start
mov ax, cell_clicked_y
dec ax

mov cl, 22
mul cl

add ax, 12  ;; (Board Position)
mov si, ax

; di -> (Y) end
mov di, si
add di, 22


pop ax
; mov bp, curr_marked_x_pixel_p2
; add bp, 22 

; mov bx, curr_marked_y_pixel_p2
; add bx, 22

; mov si, bp
; add si, 22

DrawRectangle bx, si, bp, di


;;Destination Rect

;;bx offest of the grid

mov ax, curr_marked_y_val
shl ax, 8
add ax, curr_marked_x_val

sub ax, 0101h

call getIndex ;; 0-indexed


; mov bx, offset grid[bx]
mov ax, offset grid
add bx, ax
;add bx, 32d

mov si, bx
add si, 20

; White
mov al, 0Fh
DrawRectangle bx,0,si,20


mov cx, [bx]
xchg ch,cl

; mov al, ch
; mov bh, 0
; mov bl, 0F0h
; mov cx, 1
; mov ah, 09h
; int 10h

cmp cx, "br"
jne c22
mov di,offset black_rock
jmp c33
c22:
cmp cx, "bn"
jne c23
mov di,offset black_knight
jmp c33
c23: 
cmp cx, "bb"
jne c24
mov di,offset black_bishop
jmp c33
c24:
cmp cx, "bk"
jne c25
mov di,offset black_king
jmp c33
c25:
cmp cx, "bq"
jne c26
mov di,offset black_queen
jmp c33
c26: 
cmp cx, "bp"
jne c27
mov di,offset black_pawn
jmp c33


c27:
cmp cx, "wr"
jne c28
mov di,offset white_rock
jmp c33
c28:
cmp cx, "wn"
jne c29
mov di,offset white_knight
jmp c33
c29: 
cmp cx, "wb"
jne c34
mov di,offset white_bishop
jmp c33
c34:
cmp cx, "wk"
jne c31
mov di,offset white_king
jmp c33
c31:
cmp cx, "wq"
jne c32
mov di,offset white_queen
jmp c33
c32: 
mov di,offset white_pawn

c33:

get_cell curr_marked_x_val, curr_marked_y_val
draw get_cell_x , get_cell_y , di;, x, y


; ;; Update the Destination Rect
; dec curr_marked_x_val_p2

; mov al, 0bh

; DrawRectangle curr_marked_x_pixel_p2, curr_marked_y_pixel_p2, bp, bx


jmp c42

c19:
;Red 
mov al, 4
DrawRectangle 0,0,20,20

c42:

;; Reset cell_clicked_x and cell_clicked_y
mov cell_clicked_x, 0
mov cell_clicked_y, 0

;;Clearing the moves
call ClearMoves


jmp game


m5:
cmp al,'p'         ; source
jnz m6
mov dx, curr_marked_x_val_p2
mov cx, curr_marked_y_val_p2

mov cell_clicked_x_p2,dx
mov cell_clicked_y_p2,cx
m6:


cmp al,'9'
jz l
jmp game
l:

mov ax,4c00h

int 21h

end start


.end
