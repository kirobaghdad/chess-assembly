; convertToTile macro position
; push ax
; mov ax, position

; mov bx, 0 
; mov bl, 16d

; mov cl, al

; mov al, ah
; mov ah, 0

; mul bl

; mov ch, al
; mov al, cl
; mov bl, 2d
; mul bl

; add al, ch
; mov bx, ax
; pop ax

; endm convertToTile

; pushAll macro  
; push ax
; push bx
; push cx
; push dx
; push di
; push si
; endm pushAll 

; popAll macro 
; pop si
; pop di
; pop dx
; pop cx
; pop bx
; pop ax 
; endm popAll

extrn moves:word
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


public validateMove
public allowed

.model large
.data
; grid db "br","bn","bb","bk","bq","bb","bn","br"
;      db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
;      db "--","--","--","--","--","--","--","--"
;      db "--","--","--","wn","--","--","--","--"
;      db "--","--","--","--","--","--","--","--"
;      db "--","--","--","--","--","--","--","--"
;      db "wp","wp","wp","wp","wp","wp","wp","wp"  
;      db "wr","--","wb","wk","wq","wb","wn","wr"
                                  
; moves dw 100 dup('$')

count db 0
allowed db 0
iterator db 0

.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Validate Move ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

validateMove PROC far
    ;; Bx = Destination
    mov iterator,0
    pushAll
    mov dx, bx
    check: 
    
    mov bx,0
    mov bl,iterator 

    ;;;Wrong (2nd comparison overwrites the zf)
    cmp moves[bx],dx

    jnz breakCondition 
    mov allowed, 1
    jmp done
    breakCondition:
    
    add iterator, 2
    cmp moves[bx], '$'
    jnz check 
    done: 
    popAll
    ret
validateMove ENDP


END


; start:
; mov ax, @data
; mov ds, ax

; ; source
; mov ax, 0404h
; call knightMoves
; ; destination 
; mov bx, 0203h

; call validateMove

; cmp allowed, 1
; jne c0

; ;call makeMove

; c0:

; hlt

; end start

; .end


; knightMoves proc
; ; (AH AL) = (row, col)
; ; CX is used to assign the destination in the moves
; ; DX is equal to the initial AX (It is never changed)
; ; BX is used for accessing the arrays

; ;pop ax
; ;;Assuming (8,3) 


; ; base 1

; ; base 0

; ; maintain original position
; mov dx,ax

; pushAll


; convertToTile ax

; mov dl, grid[bx]  ;;;;;;;;;;;;;;;;;For Testing;;;;;;;;;;;;;;;;;;;;;;;Error: dl = 2D(-) After executing this line

; cmp grid[bx], "w"
; je m1
; jmp near ptr black
; ; done
; ; row = row - 2, col = col - 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m1:
; mov ax, dx
; dec ah 
; dec ah 
; dec al
; convertToTile ax

; cmp grid[bx],'w'
; jz m2

; cmp bx, 128D
; ja m2

; cmp bx, 0D
; jb m2 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4
; ; done
; ; row = row - 1, col = col - 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m2:
; mov ax, dx

; dec ah 
; dec al
; dec al

; convertToTile ax

; cmp grid[bx],'w'
; jz m3

; cmp bx, 128D
; ja m3

; cmp bx, 0D
; jb m3 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4
; ; done
; ; row = row + 1, col = col - 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m3:
; mov ax, dx

; inc ah 
; dec al
; dec al

; convertToTile ax

; cmp grid[bx],'w'
; jz m4

; cmp bx, 128D
; ja m4

; cmp bx, 0D
; jb m4 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 2, col = col - 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m4:
; mov ax, dx

; inc ah 
; inc ah 
; dec al
; convertToTile ax

; cmp grid[bx],'w'
; jz m5

; cmp bx, 128D
; ja m5

; cmp bx, 0D
; jb m5 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 2, col = col + 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m5:
; mov ax, dx

; inc ah 
; inc ah 
; inc al

; convertToTile ax

; cmp grid[bx],'w'
; jz m6

; cmp bx, 128D
; ja m6

; cmp bx, 0D
; jb m6 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 1, col = col + 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m6:
; mov ax, dx

; inc ah 
; inc al
; inc al

; convertToTile ax

; cmp grid[bx],'w'
; jz m7

; cmp bx, 128D
; ja m7

; cmp bx, 0D
; jb m7 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row - 1, col = col + 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m7:
; mov ax, dx

; dec ah 
; inc al
; inc al
; convertToTile ax

; cmp grid[bx],'w'
; jz m8

; cmp bx, 128D
; ja m8

; cmp bx, 0D
; jb m8 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row - 2, col = col + 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m8:
; mov ax, dx

; dec ah 
; dec ah 
; inc al
; convertToTile ax

; cmp grid[bx],'w'
; jnz x1n
; jmp near ptr cont
; x1n:
; cmp bx, 128D
; jb x2n
; jmp near ptr cont
; x2n:
; cmp bx, 0D
; ja x3n
; jmp near ptr cont
; x3n: 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4






; black:

; m1b:
; mov ax, dx
; dec ah 
; dec ah 
; dec al
; convertToTile ax

; cmp grid[bx],'b'
; jz m2b

; cmp bx, 128D
; ja m2b

; cmp bx, 0D
; jb m2b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4
; ; done
; ; row = row - 1, col = col - 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m2b:
; mov ax, dx

; dec ah 
; dec al
; dec al

; convertToTile ax

; cmp grid[bx],'b'
; jz m3b

; cmp bx, 128D
; ja m3b

; cmp bx, 0D
; jb m3b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4
; ; done
; ; row = row + 1, col = col - 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m3b:
; mov ax, dx

; inc ah 
; dec al
; dec al

; convertToTile ax

; cmp grid[bx],'b'
; jz m4b

; cmp bx, 128D
; ja m4b

; cmp bx, 0D
; jb m4b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 2, col = col - 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m4b:
; mov ax, dx

; inc ah 
; inc ah 
; dec al
; convertToTile ax

; cmp grid[bx],'b'
; jz m5b

; cmp bx, 128D
; ja m5b

; cmp bx, 0D
; jb m5b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 2, col = col + 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m5b:
; mov ax, dx

; inc ah 
; inc ah 
; inc al

; convertToTile ax

; cmp grid[bx],'b'
; jz m6b

; cmp bx, 128D
; ja m6b

; cmp bx, 0D
; jb m6b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row + 1, col = col + 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m6b:
; mov ax, dx

; inc ah 
; inc al
; inc al

; convertToTile ax

; cmp grid[bx],'b'
; jz m7b

; cmp bx, 128D
; ja m7b

; cmp bx, 0D
; jb m7b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row - 1, col = col + 2
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m7b:
; mov ax, dx

; dec ah 
; inc al
; inc al
; convertToTile ax

; cmp grid[bx],'b'
; jz m8b

; cmp bx, 128D
; ja m8b

; cmp bx, 0D
; jb m8b 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4

; ; row = row - 2, col = col + 1
; ; ax -> desired position
; ; bx -> index on the grid
; ; dx -> original index base 0
; m8b:
; mov ax, dx

; dec ah 
; dec ah 
; inc al
; convertToTile ax

; cmp grid[bx],'b'
; jz cont

; cmp bx, 128D
; ja cont

; cmp bx, 0D
; jb cont 

; mov bx,0
; mov bl,count 
; mov moves[bx],dx
; mov moves[bx+2],ax
; add count, 4


; cont: 
; popAll
; ret

; knightMoves endp
;description
; ax <- source 
; bx <- destination 

