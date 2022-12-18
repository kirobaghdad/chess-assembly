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

flushKeyboardBuffer MACRO
    pushAll
    mov al, 0 
    mov ah, 0ch
    int 21h
    popAll
ENDM

getInputAsync MACRO
    local InputLoop
    InputLoop:
    mov ah, 1
    int 16h 
    jz InputLoop
    
    flushKeyboardBuffer
ENDM


printString MACRO strMsg
    pushAll
    mov ah, 9d
    mov dx, offset strMsg
    int 21h
    popAll
ENDM
newLine MACRO 
    pushAll
    mov ah, 02d
    mov dl, 0Ah
    int 21h
    popAll
ENDM

movecursor macro x, y
    pushAll
    mov ah, 02h
    mov bh, 0
    mov dh, x
    mov dl, y
    int 10h
    popAll    
endm movecursor

.model small
.stack 64
.data
StartChattingPrompt db '> To start chatting press F1','$'
StartGamePrompt db '> To start the game press F2','$'
EndProgramPrompt db '> To end the program press ESC','$'
inGameStr db 'We are in the Game mate','$'
inChatStr db 'We are in the Chat mate','$'
f1 equ 3bh
f2 equ 3ch
escape equ 01h
.code
start:
    mov ax, @data 
    mov ds, ax
    ; set text mode 80x25 16 color text mode  
    mov ah, 00d
    mov al, 03d
    int 10h
    
    call movCursorToMiddle
    printString StartChattingPrompt
    newLine
    
    call movCursorToMiddle
    printString StartGamePrompt
    newLine
    
    call movCursorToMiddle
    printString EndProgramPrompt 
    newLine
    ; navigation to another page
    getInputLoop: 

    getInputAsync

    flushKeyboardBuffer
    ; is f1
    cmp ah, f1
    je movToChattingMode
    ; is f2 
    cmp ah, f2
    je toGameMode
    ; is esc
    cmp ah, escape
    jne getInputLoop
    jmp near ptr toClose
    
    jmp getInputLoop

    ; chatting page ah = f1 (scancode)
    movToChattingMode:  
        mov ah, 05h
        mov al, 1
        int 10h
        printString inChatStr
        getInputAsync
        flushKeyboardBuffer
        cmp ah, F2
        je toGameMode

        ret
    ; game page ah = f2 (scancode)
    toGameMode: 
        mov ah, 05h
        mov al, 2
        int 10h
        printString inGameStr
        gameLoop:
        getInputAsync
        flushKeyboardBuffer
        cmp ah, f1
        jne gameLoop
        jmp near ptr movToChattingMode
        ret

    toClose: 
        ; is ESC
        ; close for now 
        ret

    movCursorToMiddle: 
    pushAll 
    ; dh : (row vertical) , dl : (column horizontal)
    mov ah, 03d
    mov bh, 00d 
    int 10h
    cmp dh, 0
    jne CHANGECOLUMN 
    ; moves to the middle row
    mov dh, 11d 
    CHANGECOLUMN: 
    mov dl, 30d
    mov ah, 02d
    int 10h
    popAll
    ret
end start    
.end