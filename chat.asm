.186
include MACROS.inc

PUBLIC Chat

Extrn Name1	    :Byte
Extrn Name2 	    :Byte
Extrn sprtr 	    :Byte

.model large 
.stack 64
.data
;;Constants
End_Of_My_Chat	    equ 0bh
End_Of_His_Chat	    equ 16h

MyChar		    db ?
HisChar		    db ?

MyCursorLoc	    dw 0200h
HisCursorLoc  dw 0d00h

;; Display Messages
QuitMsg		    db 'To end chatting press F3$'
ChatEndMsg	    db 'has exited the chat room$'


.code
ScrollMyChat	proc far
	push es
	push ds
	push di
	push si	

	; pusha
	; mov dl, 'A'
	; mov ah, 2
	; int 21h
	; popa

	
	mov ax, 0B800h
	mov es, ax
	mov ds, ax
    

	    mov si, 480	    ;; 3rd row or second chatting row
	    mov di, 320	    ;; first chatting row

	    mov cx, 1280
	    rep movsb
	    
	    

	mov cx, 80
	Loop1:
	    mov ah,2
	    mov dh,0ah
	    mov dl, cl
	    int 10h

	    mov dl, ' '
	    mov ah, 2
	    int 21h
	loop loop1
    

	mov dx, 0a00h
	
	pop si	
	pop di
	pop ds
	pop es

	ret
ScrollMyChat	endp

ScrollHisChat	proc

	push es
	push ds
	push di
	push si	

	; pusha
	; mov dl, 'A'
	; mov ah, 2
	; int 21h
	; popa

	
	mov ax, 0B800h
	mov es, ax
	mov ds, ax
    

	    mov si, 2240	    ;; 3rd row or second chatting row
	    mov di, 2080	    ;; first chatting row

	    mov cx, 1280
	    rep movsb
	    
	    

	mov cx, 80
	Loop2:
	    mov ah,2
	    mov dh,16h
	    mov dl, cl
	    int 10h

	    mov dl, ' '
	    mov ah, 2
	    int 21h

	loop loop2
    

	mov dx, 1600h

	pop si	
	pop di
	pop ds
	pop es

	ret
ScrollHisChat	endp

Chat proc far

	mov ax, 3h
	int 10h

	ChatScreen Name1,Name2,sprtr, QuitMsg

	ChatLoop:

	    Sending:
		mov ah, 1
		int 16h
		jz Receiving

		mov ah, 0
		int 16h
		
		mov MyChar, al
		
		cmp ah, 3dh		;; Check if F3 is pressed
		jnz ContinueChat

		jmp EndChat
		ContinueChat:

		cmp MyChar, 13d	
		jne c320
		mov dx, MyCursorLoc
		mov dl, 0
		inc dh
		mov MyCursorLoc, dx

		c320:
		MoveCursor MyCursorLoc
		mov dl, MyChar
		mov ah, 2
		int 21h
		
		mov dx, MyCursorLoc
		cmp dl, 78
		jl c325
		
		mov dl, 0 ;; Col
		inc dh ;;Row
		
		c325:
		cmp dh, End_Of_My_Chat
		jl NotEndOfline
		
		call ScrollMyChat
		jmp sendchar	    

		NotEndOfline:
		
		    inc dl
		
		sendchar:
		    mov MyCursorLoc, dx
	    
		WaitForSerialOutput
		
		mov dx , 3F8H ; Transmit data register
		mov al, MyChar
		out dx, al
		
	    
	    Receiving:
		CheckForSerialInput
		jz Sending

		mov dx , 03F8H
		in al , dx
		cmp al, 7
		jz ChatEnded

		mov HisChar, al
		cmp al, 13d
		jne c321
		mov dx, HisCursorLoc
		mov dl, 0
		inc dh
		mov HisCursorLoc, dx

		c321:
		MoveCursor HisCursorLoc
		mov dl, HisChar
		mov ah, 2
		int 21h
		
		mov dx, HisCursorLoc
		cmp dl, 78
		jl c326
		
		mov dl, 0
		inc dh

		c326:
		cmp dh, End_Of_His_Chat
		jl NotEndOfline2
		

		call ScrollHisChat

		mov dh, END_OF_His_Chat
		mov dl, 0

		jmp endreceive

		NotEndOfline2:
		
		    inc dl
		
		endreceive:
		    mov HisCursorLoc, dx

		jmp Sending

		



	EndChat:
	    WaitForSerialOutput
	    
	    mov dx , 3F8H ; Transmit data register
	    mov al, 7	    ;; 1 for chat mode
	    out dx , al
	    ret

	ChatEnded:
	    mov ah, 2
	    mov dx, 0C15h
	    int 10h
	    
	    mov ah, 9
	    mov dx, offset ChatEndMsg
	    int 21h
	    
	    mov ah, 0
	    int 16h



	ret
Chat	endp


END