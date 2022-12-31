.186
;; Extrn Data
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
    extrn queenMoves:far

    extrn getIndex:far
    extrn makeMove:far
    extrn ClearMoves:far

    extrn moves:word
    extrn moves_p2:word
    extrn player_no:byte
    extrn winner:byte

    ;; Validate File
    extrn validateMove:far
    extrn allowed:byte
;;

;; Public Data
    public grid
    public get_cell_x
    public get_cell_y
    public drawHighlight
    public time
    public capturedPiece
    public white_king_pos
    public black_king_pos
    public chezz
;;
.model large
.stack 64
.data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    grid db "br","bn","bb","bq","bk","bb","bn","br"
         db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
         db "--","--","--","--","--","--","--","--"
         db "--","--","--","--","--","--","--","--"
         db "--","--","--","--","--","--","--","--"
         db "--","--","--","--","--","--","--","--"
         db "wp","wp","wp","wp","wp","wp","wp","wp"  
         db "wr","wn","wb","wq","wk","wb","wn","wr"
                                    
    time db 0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0                                    
         db 0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0
         db 0,0,0,0,0,0,0,0  
         db 0,0,0,0,0,0,0,0,'$'
 
    timer dw 0
    game_timer dw 0

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


    white_in_check db 0
    black_in_check db 0

    wMsg db "White ", '$'
    bMsg db "Black ", '$'

    checkedMsg db "is checked! ", '$'

    blackWins db "Black Wins!", '$'
    whiteWins db "White Wins!", '$'

    capturedPiece dw "--"

    white_captured_x dw 253d
    white_captured_y dw 12d

    black_captured_x dw 10d
    black_captured_y dw 12d

    white_king_pos dw 0805h
    black_king_pos dw 0105h
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
cmp al, 02
je notColored
cmp al, 0ah
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
; local drawloop, jumb_if_black, l, m, c52, c53, c54, c55, c56, c57, c58
; Drawing loop
pusha

mov cx, draw_x
mov dx, draw_y
mov bx, z

call draw_proc

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

;DrawRectangle 0, 188, 320, 200



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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Initilaize Vars ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

initializeVars proc far

mov bx, offset grid

mov [bx], 'rb'
mov [bx+2],'nb'
mov [bx+4], 'bb' 
mov [bx+6], 'qb' 
mov [bx+8], 'kb' 
mov [bx+10], 'bb' 
mov [bx+12], 'nb' 
mov [bx+14], 'rb'

mov [bx+16], 'pb'
mov [bx+18], 'pb'
mov [bx+20], 'pb' 
mov [bx+22], 'pb' 
mov [bx+24], 'pb' 
mov [bx+26], 'pb' 
mov [bx+28], 'pb' 
mov [bx+30], 'pb'

mov [bx+96], 'pw'
mov [bx+98], 'pw'
mov [bx+100], 'pw' 
mov [bx+102], 'pw' 
mov [bx+104], 'pw' 
mov [bx+106], 'pw' 
mov [bx+108], 'pw' 
mov [bx+110], 'pw'

mov [bx+112], 'rw'
mov [bx+114], 'nw'
mov [bx+116], 'bw' 
mov [bx+118], 'qw' 
mov [bx+120], 'kw' 
mov [bx+122], 'bw' 
mov [bx+124], 'nw' 
mov [bx+126], 'rw'


mov bx, 32

ll:
mov [bx], '--'

add bx, 2

cmp bx, 96
jne ll






ret
initializeVars endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw Status Bar ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawStatusBar proc far

mov dh, 24
mov dl, 0
mov bh, 0
mov ah, 2
int 10h

mov ah, 0eh
mov al, ' '
c155:
int 10h
add dl, 1

cmp dl, 39
je c156

jmp c155

c156:

mov dh, 24
mov dl, 0
mov bh, 0
mov ah, 2
int 10h


cmp winner, 1 ;;black
jne c203
mov dx, offset blackWins
mov ah, 9
int 21h
jmp c204

c203:
cmp winner, 2 ;;white
jne c204
mov dx, offset whiteWins
mov ah, 9
int 21h

c204:
cmp white_in_check, 1
jne c131
mov dx, offset wMsg
mov ah, 9
int 21h

mov dx, offset checkedMsg
mov ah, 9
int 21h

c131:
cmp black_in_check, 1
jne c132

mov dx, offset bMsg
mov ah, 9
int 21h

mov dx, offset checkedMsg
mov ah, 9
int 21h

c132:
ret

drawStatusBar endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Get Checks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

getChecks proc far
    mov white_in_check, 0
    mov black_in_check, 0

    ;; White King 
    ;; Moving to the right, left, up, down, up-right, up-left, down-right, and down-left
    ;; Direction Index 0      1    2    3      4          5        6               7

    mov cx, -1 ;; Direction Index

    c161:
    add cx, 1

    mov ax, white_king_pos
    sub ax, 0101h

    c152:
    cmp cx, 0
    jne c157
    add ax, 1
    jmp c158

    c157:
    cmp cx, 1
    jne c159
    sub ax, 1
    jmp c158

    c159:
    cmp cx, 2
    jne c164
    sub ax, 0100h
    jmp c158

    c164:
    cmp cx, 3
    jne c167
    add ax, 0100h
    jmp c158

    c167:
    cmp cx, 4
    jne c168
    sub ax, 0100h
    add ax, 1
    jmp c158

    c168:
    cmp cx, 5
    jne c169
    sub ax, 0100h
    sub ax, 1
    jmp c158

    c169:
    cmp cx, 6
    jne c170
    add ax, 0100h
    add ax, 1
    jmp c158

    c170:
    cmp cx, 7
    je c176
    jmp c165
    
    c176:
    add ax, 0100h
    sub ax, 1



    c158:
    cmp al, 0
    jl c161

    cmp ah, 0
    jl c161

    cmp al, 7
    jle c181
    jmp c161
    c181:
    cmp ah, 7
    jle c182
    jmp c161

    c182:

    pusha
    mov ah, 2
    mov dl, cl
    int 21h
    popa

    push ax
    push cx
    call getIndex
    pop cx
    pop ax

    cmp grid[bx], '-'
    jne c172
    jmp c152
    c172:

    cmp grid[bx], 'w'
    jne c173
    jmp c161
    c173:

    ;; Up right and Up left pawn (White King)
    cmp cx, 4
    je c175

    cmp cx, 5
    jne c174

    c175:
    cmp grid[bx+1], 'p'
    jne c174
    mov white_in_check, 1
    jmp c165


    c174:
    cmp cx, 3
    jg c171

    ;; Linear
    cmp grid[bx+1], 'r'
    jne c153
    mov white_in_check, 1
    jmp c165

    ;Diagonal
    c171:

    cmp grid[bx+1], 'b'
    jne c153

    mov white_in_check, 1
    jmp c165


    c153:  
    cmp grid[bx+1], 'q'
    jne c154

    mov white_in_check, 1
    jmp c165

    c154:
    cmp grid[bx+1], 'k'
    je c166
    jmp c161
    c166:
    mov white_in_check, 1
    jmp c165

    jmp c161


    c165:
    call drawStatusBar

    ret

getChecks endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw Proc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

draw_proc proc far
; mov cx,draw_x
; mov dx,draw_y
; mov bx,z

mov di,cx
add di, pieceWidth
mov si, dx
add si, pieceHeight

mov draw_piece_x , di
mov draw_piece_y , si

mov di, cx ;; Maintain cx (draw_x)
mov bp, bx ;; Maintain bx (Image Offset)

mov ah, 0dh
int 10h

; push ax
; push dx
; mov ah, 2
; mov dl, al
; add dl, 48d
; int 21h
; pop dx
; pop ax

MOV AH,0ch
mov si, ax

drawLoop:
    
    MOV AL,[bx]
    
    cmp al,0ffh
    jz jumb_if_black 
    ;; Check if green or light green
    cmp al, 0ah
    je c54

    c53:
    cmp al, 2
    jne c52

    ;; Check if white or black (Do not draw)
    c54:
    push ax
    mov ah, 0dh
    int 10h
    cmp al, 0fh ;; white piece
    je c55
    cmp al, 12h ;; black piece
    je c55

    jmp c56

    c55:
    pop ax
    jmp c71

    c56:
    pop ax
    c52:
    INT 10h
    jmp c71

    jumb_if_black: 
    
    cmp bp, offset green_dot
    je c71

    mov ax, si
    int 10h
    
    c71:
    INC CX
    INC BX
    CMP CX,draw_piece_x
jz c61
jmp drawloop

    c61:
	
    MOV CX , di
    INC DX
    CMP DX , draw_piece_y
JE c62
jmp drawloop

c62:

ret

draw_proc endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw Captured Piece ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawCapturedPiece proc far

    cmp capturedPiece, 'wr'
    jne c101
    mov di, offset white_rock
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102

    c101:
    cmp capturedPiece, 'wn'
    jne c103
    mov di, offset white_knight
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102

    c103:
    cmp capturedPiece, 'wb'
    jne c104
    mov di, offset white_bishop
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102

    c104:
    cmp capturedPiece, 'wq'
    jne c105
    mov di, offset white_queen
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102

    c105:
    cmp capturedPiece, 'wk'
    jne c106
    mov di, offset white_king
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102

    c106:
    cmp capturedPiece, 'wp'
    jne c107
    mov di, offset white_pawn
    draw white_captured_x, white_captured_y, di
    add white_captured_y, 22
    jmp c102



    c107:
    cmp capturedPiece, 'br'
    jne c108
    mov di, offset black_rock
    draw black_captured_x, black_captured_y, di
    add black_captured_y, 22
    jmp c102

    c108:
    cmp capturedPiece, 'bn'
    jne c109
    mov di, offset black_knight
    draw black_captured_x, black_captured_y, di
    add black_captured_y, 22
    jmp c102

    c109:
    cmp capturedPiece, 'bb'
    jne c114
    mov di, offset black_bishop
    draw black_captured_x, black_captured_y, di
    add black_captured_y, 22
    jmp c102

    c114:
    cmp capturedPiece, 'bq'
    jne c111
    mov di, offset black_queen
    draw black_captured_x, black_captured_y, di
    add black_captured_y, 22
    jmp c102

    c111:
    cmp capturedPiece, 'bk'
    jne c112
    mov di, offset black_king
    draw black_captured_x, black_captured_y, di
    add black_captured_y, 22
    jmp c102

    c112:
    cmp capturedPiece, 'bp'
    jne c113
    mov di, offset black_pawn
    draw black_captured_x, black_captured_y, di

    ; mov dl, 48d
    ; mov ah, 2
    ; int 21h

    add black_captured_y, 22
    jmp c102    

    c113:
    c102:

    mov capturedPiece, "--"
    cmp white_captured_y, 188d
    jne c115
    mov white_captured_y, 12d
    add white_captured_x, 22d

    c115:
    cmp black_captured_y, 188d
    jne c116
    mov black_captured_y, 12d
    add black_captured_x, 22d

    c116:
    ret
    drawCapturedPiece endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Print Game Timer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printGameTimer proc far

mov dh, 0   ;; Timer Rows
mov dl, 1   ;; Timer Column
mov bh, 0
mov ah, 2
int 10h

mov ax, game_timer
mov bl, 60d

div bl  ;;al = minutes and ah = seconds

push ax
mov bl, 10d
mov ah, 0

div bl  ;; ah = units digit of minutes an al = tenth digit of minutes

push ax
add al, 48d
mov cx, 1
mov ah, 0ah
int 10h

inc dl
mov ah, 2
int 10h

pop ax


mov al, ah
add al, 48d
mov ah, 0ah
int 10h

inc dl
mov ah, 2
int 10h

mov al, ':'
mov ah, 0ah
int 10h

inc dl
mov ah, 2
int 10h

pop ax
;; ah = seconds

mov al, ah
mov ah, 0

div bl  ;; al = tenth digit of seconds and ah = units digit of seconds

push ax

add al, 48d
mov ah, 0ah
int 10h

inc dl
mov ah, 2
int 10h

pop ax

;; ah = units of seconds

mov al, ah
mov ah, 0

add al, 48d
mov ah, 0ah
int 10h

ret

printGameTimer endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Change Time ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

changeTime proc
mov bx, 0


mov ch, 0

c94:
mov cl, time[bx]
cmp cl, '$'
je c95

cmp cl, 0
je c97

dec cl
mov time[bx], cl

c97:
inc bx
jmp c94


c95:
call printGameTimer

ret
changeTime endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Draw Highlight ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


drawHighlight proc far

cmp player_no, 2
je c72
mov si, offset moves
jmp c43
c72:
mov si, offset moves_p2

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Chezz ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

chezz proc far

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


call printGameTimer

game: 

;call drawStatusBar
mov ah, 86h
mov cx, 0
mov dx, 1
int 15h

cmp timer, 03e8h
je c96
add timer, 1
jmp c93
c96:
mov timer, 0

inc game_timer
call changeTime ;; No register must be maintained



c93:
mov ah,1
int 16h

jz game

;; Flush the buffer
push ax
mov ah, 0ch
int 21h
pop ax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Right (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Up (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Down (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Left (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Right (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    m4:
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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Up (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Down (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Left (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Move (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    m44:
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

    mov player_no, 1
    ; mov al, 0ch
    ; DrawRectangle 0,0,20,20

    mov ax, curr_marked_y_val
    dec ax
    shl ax, 8

    add ax, curr_marked_x_val
    dec ax

    push ax
    call getIndex
    pop ax

    cmp grid[bx], 'b'
    je c98
    jmp game

    c98:
    push ax
    mov ax, bx
    mov cl, 2
    div cl
    mov si, ax

    ; mov ah, 2
    ; mov dl, time[si]
    ; int 21h
    pop ax

    cmp time[si], 0
    je c59
    jmp game 


    c59:
    add ax, 0101h  ;; Make it 1-indexed

    mov dx, curr_marked_x_val
    mov cx, curr_marked_y_val


    mov cell_clicked_x,dx
    mov cell_clicked_y,cx


    cmp grid[bx+1], 'r'
    jne c36
    call RockMoves

    c36:
    cmp grid[bx+1], 'n'  
    jne c37
    call knightMoves

    c37:
    cmp grid[bx+1], 'b'  
    jne c38
    call bishopMoves

    c38:
    cmp grid[bx+1], 'k'
    jne c39
    call KingMoves

    c39:
    cmp grid[bx+1], 'q'
    jne c41
    call queenMoves

    c41:
    cmp grid[bx+1], 'p'
    jne c51
    call PawnMoves

    ; Drawing the moves highlight

    c51:

    mov dx, moves[0]

    cmp dl, '$'
    jne c82


    mov cell_clicked_x, 0
    mov cell_clicked_y, 0
    jmp c83

    c82:
    call drawHighlight

    c83:
    jmp game
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Second Click (First Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;;Second Click
    c16:

    mov player_no, 1



    mov ax, cell_clicked_y
    shl ax, 8

    add ax, cell_clicked_x


    mov bx, curr_marked_y_val
    shl bx, 8

    add bx, curr_marked_x_val


    ; mov bp, bx
    ; add bp, 20

    ; ;;Black
    ; mov al, 0
    ; DrawRectangle bx,0,bp,20


    call validateMove

    ;;;;;;;;;;;; Check Allowed
    cmp allowed, 1
    jz c35
    jmp c19

    c35:
    mov allowed, 0
    ;;;Allowed (Make Move)

    mov ax, cell_clicked_y
    shl ax, 8
    add ax, cell_clicked_x

    mov bx, curr_marked_y_val
    shl bx, 8
    add bx, curr_marked_x_val


    call makeMove  ;; Updating the grid

    call drawCapturedPiece

    call getChecks

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

    mov cx, [bx]
    xchg ch,cl

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
    ; cmp cx, "bp"
    ; jne c33
    mov di,offset black_pawn

    c33:
    ; ;; Update the Destination Rect

    get_cell curr_marked_x_val, curr_marked_y_val
    draw get_cell_x , get_cell_y , di;, x, y


    jmp c42

    c19:
    ; ;Red 
    ; mov al, 4
    ; DrawRectangle 0,0,20,20

    c42:

    ;; Reset cell_clicked_x and cell_clicked_y
    mov cell_clicked_x, 0
    mov cell_clicked_y, 0

    ;;Clearing the moves
    call ClearMoves

    cmp winner, 0
    je c91
    jmp l

    c91:
    jmp game
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Move (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    m5:
    cmp al,'p'         ; source
    jz c57
    jmp m6
    c57:

    ; mov ax, curr_marked_y_val_p2
    ; dec ax
    ; shl ax, 8

    ; add ax, curr_marked_x_val_p2
    ; dec ax

    ; call getIndex
    
    ; cmp grid[bx], 'w'
    ; je c150
    ; jmp game

    c150:
    cmp cell_clicked_x_p2, 0
    jz c180
    jmp c160
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;check

    c180:
    mov player_no, 2

    ; mov al, 0ch
    ; DrawRectangle 0,0,20,20

    mov ax, curr_marked_y_val_p2
    dec ax
    shl ax, 8

    add ax, curr_marked_x_val_p2
    dec ax

    push ax
    call getIndex
    pop ax

    cmp grid[bx], 'w'
    je c99
    jmp game

    c99:
    push ax
    mov ax, bx
    mov cl, 2
    div cl
    mov si, ax

    ; mov ah, 2
    ; mov dl, time[si]
    ; add dl, 48d
    ; int 21h
    pop ax

    cmp time[si], 0
    je c58
    jmp game 

    c58:
    add ax, 0101h  ;; Make it 1-indexed

    mov dx, curr_marked_x_val_p2
    mov cx, curr_marked_y_val_p2


    mov cell_clicked_x_p2,dx
    mov cell_clicked_y_p2,cx


    cmp grid[bx+1], 'r'
    jne c360
    call RockMoves

    c360:
    cmp grid[bx+1], 'n'  
    jne c370
    call knightMoves

    c370:
    cmp grid[bx+1], 'b'  
    jne c380
    call bishopMoves

    c380:
    cmp grid[bx+1], 'k'
    jne c390
    call KingMoves

    c390:
    cmp grid[bx+1], 'q'
    jne c410
    call queenMoves

    c410:
    cmp grid[bx+1], 'p'
    jne c510
    call PawnMoves

    c510:
    mov dx, moves_p2[0]

    cmp dl, '$'
    jne c84
    mov cell_clicked_x_p2, 0
    mov cell_clicked_y_p2, 0
    jmp c85

    c84:
    ; Drawing the moves highlight
    call drawHighlight

    c85:

    jmp game
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Second Click (Second Player) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;;Second Click
    c160:
    mov player_no, 2

    mov ax, cell_clicked_y_p2
    shl ax, 8

    add ax, cell_clicked_x_p2


    mov bx, curr_marked_y_val_p2
    shl bx, 8

    add bx, curr_marked_x_val_p2


    mov bp, bx
    add bp, 20

    ; ;;Black
    ; mov al, 0
    ; DrawRectangle bx,0,bp,20


    call validateMove

    ;;;;;;;;;;;; Check Allowed
    cmp allowed, 1
    jz c350
    jmp c190

    c350:
    mov allowed, 0
    ;;;Allowed (Make Move)

    mov ax, cell_clicked_y_p2
    shl ax, 8
    add ax, cell_clicked_x_p2

    mov bx, curr_marked_y_val_p2
    shl bx, 8
    add bx, curr_marked_x_val_p2


    call makeMove  ;; Updating the grid

    call drawCapturedPiece

    call getChecks
    ;; Updating the UI
    ;;Source Rect
    mov ax, cell_clicked_x_p2
    add ax, cell_clicked_y_p2

    mov bl, 2
    div bl

    cmp ah, 1  ;; Dark (Odd)

    je dark40
    mov al, 7h
    jmp c210

    dark40:
    mov al, 8

    c210:

    ;;To be updated (Board Position)
    push ax
    ; bx -> (X) start
    mov ax, cell_clicked_x_p2
    dec ax

    mov cl, 22
    mul cl

    add ax, 72 ;; (Board Position)
    mov bx, ax

    ; bp -> (X) end
    mov bp, bx
    add bp, 22

    ; si -> (Y) start
    mov ax, cell_clicked_y_p2
    dec ax

    mov cl, 22
    mul cl

    add ax, 12  ;; (Board Position)
    mov si, ax

    ; di -> (Y) end
    mov di, si
    add di, 22


    pop ax

    DrawRectangle bx, si, bp, di


    ;;Destination Rect
    ;;bx offest of the grid

    mov ax, curr_marked_y_val_p2
    shl ax, 8
    add ax, curr_marked_x_val_p2

    sub ax, 0101h

    call getIndex ;; 0-indexed


    ; mov bx, offset grid[bx]
    mov ax, offset grid
    add bx, ax
    ;add bx, 32d

    mov si, bx
    add si, 20

    mov cx, [bx]
    xchg ch,cl

    cmp cx, "wr"
    jne c280
    mov di,offset white_rock
    jmp c330
    c280:
    cmp cx, "wn"
    jne c290
    mov di,offset white_knight
    jmp c330
    c290: 
    cmp cx, "wb"
    jne c340
    mov di,offset white_bishop
    jmp c330
    c340:
    cmp cx, "wk"
    jne c310
    mov di,offset white_king
    jmp c330
    c310:
    cmp cx, "wq"
    jne c320
    mov di,offset white_queen
    jmp c330
    c320: 
    mov di,offset white_pawn

    c330:
    ; ;; Update the Destination Rect

    get_cell curr_marked_x_val_p2, curr_marked_y_val_p2
    draw get_cell_x , get_cell_y , di;, x, y


    jmp c420

    c190:
    ; ;Red 
    ; mov al, 4
    ; DrawRectangle 0,0,20,20

    c420:

    ;; Reset cell_clicked_x_p2 and cell_clicked_y_p2
    mov cell_clicked_x_p2, 0
    mov cell_clicked_y_p2, 0

    ;;Clearing the moves
    call ClearMoves

    cmp winner, 0
    je c92

    jmp l

    c92:
    jmp game
;;

m6:

cmp al,'9'
jz l
jmp game
l:

cmp winner, 1 ;;Black
jne c200
mov ah, 9
mov dx, offset blackWins
int 21h
jmp c201

c200:
cmp winner, 2 ;;white
jne c202
mov ah, 9
mov dx, offset whiteWins
int 21h

c201:

mov cx, 2Dh
mov dx, 0C6C0h

mov ah, 86h
int 15h

c202:

; pusha
; call initializeVars
; popa
ret

chezz endp



END