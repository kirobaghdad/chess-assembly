extrn bishopMoves:far
extrn RockMoves:far
public grid
public count
public moves

; extrn grid:byte
;Moves format: sourceRow SourceCol, destRow DestCol    
convertToTile macro position
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
endm popAlls

;;Gets the index in BX (Given the pos in AX (0-indexed))


.model large
.stack 64
.data
grid db "br","bn","bb","bk","bq","bb","bn","br"
     db "bp","bp","bp","bp","bp","bp","bp","bp"                                    
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","wb"
     db "--","--","--","--","--","--","--","--"
     db "--","--","--","--","--","--","--","--"
     db "wp","wp","wp","wp","wp","wp","wp","wp"  
     db "wr","wn","wb","wk","wq","wb","wn","wr"
                                  
moves dw 100 dup('$')
count db 0          
.code

;Given the bishop position in the board, this procedure returns the available moves of this pawn
queenMoves proc
; (AH AL) = (row, col)
; CX is used to assign the destination in the moves
; DX is equal to the initial AX (It is never changed)
; BX is used for accessing the arrays


    mov ah, 8h
    mov al, 5h
    push ax
    call bishopMoves
    pop ax
    call RockMoves

ret

queenMoves endp



start:
mov ax, @data
mov ds, ax

call queenMoves
hlt

end start

.end
END