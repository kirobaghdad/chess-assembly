.186
extrn chezz:far
extrn Chat:far
public receivedRequest
public Name1
public Name2 
public sprtr

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

flushKeyboardBuffer MACRO
    pusha
    mov al, 0 
    mov ah, 0ch
    int 21h
    popa
ENDM

getInputAsync MACRO
    mov ah, 1
    int 16h 

    flushKeyboardBuffer
ENDM


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
receivedRequest db 0
Name1 db "Walled", '$'
Name2 db "Kiro", '$'
sprtr db " ", '$'

allowedName db 0
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start Communication ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

startCommunication proc far
    pusha
    ; initinalize COM
    ;Set Divisor Latch Access Bit
    mov dx,3fbh 			; Line Control Register
    mov al,10000000b		;Set Divisor Latch Access Bit
    out dx,al				;Out it
    ;Set LSB byte of the Baud Rate Divisor Latch register.
    mov dx,3f8h			
    mov al,0ch			
    out dx,al

    ;Set MSB byte of the Baud Rate Divisor Latch register.
    mov dx,3f9h
    mov al,00h
    out dx,al

    ;Set port configuration
    mov dx,3fbh
    mov al,00011011b
    out dx,al
    popa
    ret
startCommunication endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; validate Name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
validateName proc far
    pusha
    mov dl, username[0]

    cmp dl, 'A'
    jae c330
    mov allowedName, 0
    jmp c331

    c330:
    cmp dl, 'Z'
    ja c332
    mov allowedName, 1
    jmp c331

    c332:
    cmp dl, 'a'
    jb c331
    mov allowedName, 1

    c331:
    popa
    ret
validateName endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; clear Name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

clearName proc far

    mov bx, 0

    c240:
    cmp username[bx], '$'
    je c241
    mov username[bx], '$'
    inc bx
    jmp c240

    c241:
    ret
clearName endp

start:
    mov ax, @data 
    mov ds, ax
    mov es, ax


    call startCommunication

    getNameScreen:
    mov allowedName, 0
    ; set text mode 80x25 16 color text mode  
    mov ah, 00d
    mov al, 03d
    int 10h

    call clearName

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
    je validate

    mov [si], al
    inc si

    mov ah, 2
    mov dl, al
    int 21h

    ;;Flushing the Buffer
    mov ah, 0ch
    int 21h

    jmp getName

    validate:
    ;;Flushing the Buffer
    mov ah, 0ch
    int 21h
    
    call validateName

    cmp allowedName, 1
    jne getNameScreen


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

    mov dh, 0
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    c251:
    ;;Receive
    pusha
    mov dx, 3fdh

    in al, dx
    and al, 1
    jz c250

    ;;Get Data
    mov dx, 3f8h
    in al, dx

    cmp al, 2 ;; Request
    je c255
    jmp c256

    c255:
    popa 
    jmp toGameMode

    c256:
    pusha
    mov dh, 0
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h

    mov dl, al
    add dl, 48d
    mov ah, 2
    int 21h
    popa

    mov receivedRequest, al

    c250:
    popa

    ; navigation to another page
    getInputLoop: 

    getInputAsync

    ; is f1
    cmp ah, f1
    je movToChattingMode
    ; is f2 
    cmp ah, f2
    je sendRequest
    ; is esc
    cmp al, escape
    jne c252
    jmp toClose
    c252:
    jmp c251

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
        ; printString inChatStr
        call Chat

        ; c0:
        ; ;;printString inChatStr
        ; getInputAsync
        ; flushKeyboardBuffer
        ; cmp ah, F3
        ; jne c0
        jmp main
        
    sendRequest:

        pusha
        mov dh, 0
        mov dl, 7
        mov bh, 0
        mov ah, 2
        int 10h

        mov dl, receivedRequest
        add dl, 48d
        mov ah, 2
        int 21h
        popa
 
        pusha
        mov dx , 3F8H
        cmp receivedRequest, 1 ;; Send Confiramtion
        je c253
        mov ax, 1  ;; Send Request
        jmp c254
        c253:
        mov ax, 2 ;; Send Confiramtion
        c254:
        out dx , al
        popa

        ;; Sending a Request
        cmp receivedRequest, 1
        je toGameMode

        jmp c251


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
        ;printString inGameStr

        ; gameLoop:
        ; getInputAsync
        ; flushKeyboardBuffer
        ; cmp ah, f4
        ; jne gameLoop
        ; jmp near ptr main

        call chezz
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
    mov dl, 27d
    mov ah, 02d
    int 10h
    popa
    ret
end start    
.end