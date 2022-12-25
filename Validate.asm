;; Extrnal 
extrn player_no:byte
extrn moves:word
extrn moves_p2:word

;; Public
public validateMove
public allowed


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

.model large
.data
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

    cmp player_no, 2
    je c1
    cmp moves[bx],dx
    jmp c2
    c1:
    cmp moves_p2[bx],dx

    c2:

    jnz breakCondition 
    mov allowed, 1
    jmp done
    breakCondition:
    
    add iterator, 2

    cmp player_no, 2
    je c3
    cmp moves[bx], '$'
    jmp c4
    c3:
    cmp moves_p2[bx], '$'

    c4:

    jnz check 
    done: 
    popAll
    ret
validateMove ENDP

END


