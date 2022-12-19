.model large
.stack 64
.data


curr_marked_x_val dw 1
curr_marked_y_val dw 2


cell_clicked_source_x dw -1
cell_clicked_source_y dw -1

cell_clicked_dist_x dw ?
cell_clicked_dist_y dw ?


position_in_grid  dw ?

grid db "br","bn","bb","bq","bk","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wq","wk","wb","wn","wr"
                                  

grid_time_seconds   db 0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0
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

mov ax, curr_marked_x_val
mov cx, curr_marked_y_val

mov cell_clicked_dist_x, ax 
mov cell_clicked_dist_y, cx 

get_position_in_grid cell_clicked_dist_x, cell_clicked_dist_y
mov cx, position_in_grid
mov bx , offset grid_time_seconds
mov di, offset grid_time_minutes

mov cell_clicked_source_x, -1
mov cell_clicked_source_y, -1 

add bx,cx
add di,cx

mov [bx],dl
mov [di],dh

greater_than_3:
popa
endm


.code
start:                                                    

MOV AX , @DATA
MOV DS , AX



;Down arrow       E0 50
;Left arrow       E0 4B
;Right arrow      E0 4D
;Up arrow         E0 48
  
game:

mov ah,0
int 16h


cmp al,'q'         ; source
jnz m5
mov dx, curr_marked_x_val
mov cx, curr_marked_y_val

mov ax, cell_clicked_source_x 
mov bx, cell_clicked_source_y 

cmp ax, -1

jnz there_is_no_source

mov cell_clicked_source_x, dx
mov cell_clicked_source_y, cx 
jmp game
there_is_no_source:

check_set_time


m5:
cmp al,'d'     ;move right
jnz m1
inc curr_marked_x_val
m1:
cmp al,'w'
jnz m2
dec curr_marked_y_val
m2:
cmp al,'s'
jnz m3
inc curr_marked_y_val
m3:
cmp al,'a'
jnz m4           ;move left
dec curr_marked_x_val
m4:
cmp al,'9'
jz l
jmp game
l:

mov ax,4c00h

int 21h

end start



.end
ret




