;; Extrnal 
extrn moves:word

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


