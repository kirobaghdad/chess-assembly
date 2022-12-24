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
namePrompt db 'Please enter your name'
namePromptLength db $-namePrompt
enterPrompt db "Please enter key to continue!"
enterPromptLength db $-enterPrompt
f1 equ 3bh
f2 equ 3ch
f3 equ 3dh
f4 equ 3eh
escape equ 1bh ;;Ascii
username db 15 dup('$')
welcomeMsg db "Hello, "
.code
start:
    mov ax, @data 
    mov ds, ax
    mov es, ax

    ; set text mode 80x25 16 color text mode  
    mov ah, 00d
    mov al, 03d
    int 10h

    getNameScreen:
    mov al, 1
    mov bh, 0
    mov bl, 1
    mov ch,0
    mov cl, namePromptLength
    mov dx, 0
    lea bp, namePrompt
    mov ah, 13h
    int 10h

    ;;Update cursor position
    mov ah, 2
    mov dh, 1
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    lea si, username

    getName:
    mov ah, 1
    int 16h
    jz getName

    ;;Pressed Enter
    cmp al, 13d
    je printEnterPrompt

    mov [si], al
    inc si

    mov ah, 2
    mov dl, al
    int 21h

    ;;Flushing the Buffer
    mov ah, 0ch
    int 21h

    jmp getName


    printEnterPrompt:
    ;;Flushing the Buffer
    mov ah, 0ch
    int 21h

    ; hide blinking text cursor: 
    mov ch, 32
    mov ah, 1
    int 10h

    ;; Printing the enterPrompt message
    mov al, 1
    mov bh, 0
    mov bl, 2 ;;Green
    mov ch, 0
    mov cl, enterPromptLength
    mov dl, 27d
    mov dh, 10d
    lea bp, enterPrompt
    mov ah, 13h
    int 10h

    pressEnter:
    mov ah, 1
    int 16h
    jz pressEnter

    cmp al, 13d
    je main

    ;;Flushing the Buffer
    mov ah, 0ch
    int 21h

    jmp pressEnter

    main:
    ; Set text mode 80x25 16 color text mode  
    mov ah, 00d
    mov al, 03d
    int 10h


    ;; Select Page (0)
    mov ah, 05h
    mov al, 0
    int 10h

    ; Hide blinking text cursor: 
    mov ch, 32
    mov ah, 1
    int 10h

    ;; Print the welcome message
    mov al, 1
    mov bh, 0
    mov bl, 2 ;;Green
    mov ch, 0
    mov cl, 7d
    mov dl, 1
    mov dh, 1
    lea bp, welcomeMsg
    mov ah, 13h
    int 10h

    ;; Print Username
    mov ah, 9
    lea dx, username
    int 21h


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
    cmp al, escape
    jne getInputLoop
    jmp near ptr toClose

    ; chatting page ah = f1 (scancode)
    movToChattingMode:
        ;;Make Cursor Visible
        ; show standard blinking text cursor: 
     	mov ch, 6
     	mov cl, 7
     	mov ah, 1
     	int 10h

        ;;Set active page (1)
        mov ah, 05h
        mov al, 1
        int 10h
        printString inChatStr

        c0:
        ;;printString inChatStr
        getInputAsync
        flushKeyboardBuffer
        cmp ah, F3
        jne c0
        jmp main
        


    ; game page ah = f2 (scancode)
    toGameMode: 
        ;;Make Cursor Visible
        ; show standard blinking text cursor: 
     	mov ch, 6
     	mov cl, 7
     	mov ah, 1
     	int 10h

        ;;Set active page (2)
        mov ah, 05h
        mov al, 2
        int 10h
        printString inGameStr
        gameLoop:
        getInputAsync
        flushKeyboardBuffer
        cmp ah, f4
        jne gameLoop
        jmp near ptr main
        

    toClose: 
        ; is ESC
        ; close for now 
        ; show standard blinking text cursor: 
     	mov ch, 6
     	mov cl, 7
     	mov ah, 1
     	int 10h

        mov ah, 04ch
        int 21h

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
    mov dl, 27d
    mov ah, 02d
    int 10h
    popAll
    ret
end start    
.end