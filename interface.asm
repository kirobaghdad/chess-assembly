printString MACRO strMsg
    pusha
    mov ah, 9d
    mov dx, offset strMsg
    int 21h
    popa
ENDM
newLine MACRO 
    pusha
    mov ah, 02d
    mov dl, 0Ah
    int 21h
    popa
ENDM
movecursor macro x, y
    pusha
    mov ah, 02h
    mov bh, 0
    mov dh, x
    mov dl, y
    int 10h
    popa    
endm movecursor
.286
.model small
.stack 64
.data
StartChattingPrompt db '> To start chatting press F1','$'
StartGamePrompt db '> To start the game press F2','$'
EndProgramPrompt db '> To end the program press ESC','$'
inGameStr db 'We are in the Game mate','$'
inChatStr db 'We are in the Chat mate','$'
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
    mov ah, 0
    int 16h 
    ; is f1
    cmp ah, 3bh
    je movToChattingMode
    ; is f2 
    cmp ah, 3ch
    je toGameMode
    cmp ah, 01h
    je toClose
    jmp getInputLoop
    ; chatting page ah = f1 (scancode)
    movToChattingMode:  
        mov ah, 05h
        mov al, 1
        int 10h
        jmp toChat
    ; game page ah = f2 (scancode)
    toGameMode: 
        mov ah, 05h
        mov al, 2
        int 10h
        jmp toGame
    toClose: 
        ; is ESC
        ; close for now 
        ret
    toGame: 
        printString inGameStr


        ret
    toChat: 
        printString inChatStr
        ret
    movCursorToMiddle: 
    pusha 
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
    popa
    ret
end start    
.end