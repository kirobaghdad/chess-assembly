DrawRectangle macro x_0, y_0, x_1, y_1
local border, row
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

endm


ToggleColor macro c
local white, cont

cmp c, 8 ;Dark Grey
je white

mov c, 8
jmp cont

white:
mov c, 0fh
cont:

endm


.model small
.stack 64
.data
x0 dw 0
y0 dw 0
x1 dw 0
y1 dw 0
.code
start:

mov ah, 0
mov al, 13h
int 10h

;Drawing outer border (Brown)

mov al, 6 ;Brown

DrawRectangle 0, 0, 320, 12

DrawRectangle 0, 12, 72, 188

DrawRectangle 248, 12, 320, 188

DrawRectangle 0, 188, 320, 200



mov y0, 12 
mov y1, 34

mov al, 0fh ;White

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
jne row  

add y0, 22
add y1, 22

cmp y0, 188

jne col




mov ax, 4c00h
int 21h


end start



.end



; border0:
; mov cx, 0

; row0:
; int 10h
; inc cx
; cmp cx, 320
; jne row0

; inc dx
; cmp dx, 15
; jne border0


; border1:
; mov cx, 0

; row1:
; int 10h
; inc cx
; cmp cx, 75
; jne row1

; inc dx
; cmp dx, 185

; jne border1




; mov dx, 185

; border2:
; mov cx, 0

; row2:
; int 10h
; inc cx
; cmp cx, 320
; jne row2

; inc dx
; cmp dx, 200
; jne border2


; mov x0, 0
; mov y0, 15
; mov x1, 15
; mov y1, 185

;DrawRectangle 0, 15, 15, 185


; mov ah, 0
; mov al, 03h
; int 10h
