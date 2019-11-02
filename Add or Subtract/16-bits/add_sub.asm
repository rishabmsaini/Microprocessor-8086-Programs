data segment
    msg1 db 10,13, "Enter your choice: $"
    msg2 db 10,13, "1.Addition $"
    msg3 db 10,13, "2.Subtraction $"
    msg4 db 10,13, "3.Exit $"
    msg51 db 10,13, "Enter first number: $"
    msg52 db 10,13, "Enter second number: $"
    msg6 db 10,13, "The result is: $"

    result dw ?
    choice db ?
    n1 dw ?
    n2 dw ?
data ends
code segment
    assume cs:code,ds:data
    start:
        mov ax,data
        mov ds, ax

    loop1:
        call display1
        jmp check
        
    exit:
        mov ah, 4ch
        int 21h

    check:
        cmp choice,03h
        jz exit
    next:
        call display2
        mov bx,n1
        mov cx,n2
        cmp choice,01h
        jz add1
        sub bx,cx
        mov result,bx
        jmp print

    add1:
        add bx,cx
        mov result,bx

    print:
        mov ah,09h
        mov dx, offset msg6
        int 21h

        and bx,0F000h
        ror bx,0ch
        call output

        mov bx,result
        and bx,0F00h
        ror bx,08h
        call output
        
        mov bx,result
        and bx,00F0h
        ror bx,04h
        call output
        
        mov bx,result
        and bx,000Fh
        call output
        
        jmp loop1
        
      display1 proc
        mov ah,09h
        mov dx, offset msg2
        int 21h

        mov ah,09h
        mov dx, offset msg3
        int 21h

        mov ah,09h
        mov dx, offset msg4
        int 21h

        mov ah,09h
        mov dx, offset msg1
        int 21h

        call input
        mov choice,al 
        ret
        endp 
       
      display2 proc
        mov ah,09h
        mov dx, offset msg51
        int 21h

        call input
        and ax,000FH
        mov bx,ax           
        rol bx,0Ch
        call input
        and ax,000FH
        mov cx,ax       
        rol cx,08h
        add bx,cx
        call input
        and ax,000FH 
        mov cx,ax       
        rol cx,04h
        add bx,cx
        call input
        and ax,000FH
        mov cx,ax
        add bx,cx 
        mov n2,bx
        mov n1,bx

        mov ah,09h
        mov dx, offset msg52
        int 21h

        call input
        and ax,000FH
        mov bx,ax           
        rol bx,0Ch
        call input
        and ax,000FH
        mov cx,ax       
        rol cx,08h
        add bx,cx
        call input
        and ax,000FH 
        mov cx,ax       
        rol cx,04h
        add bx,cx
        call input
        and ax,000FH
        mov cx,ax
        add bx,cx 
        mov n2,bx
        ret
        endp

    input proc
        mov ah,01h
        int 21h

        cmp al,41h
        jc A
        sub al, 07h
        A: sub al,30h
        ret
        endp

    output proc
        cmp bl,0ah
        jc B
        add bl,07h
        B: add bl,30h
        
        mov ah,02h
        mov dl,bl
        int 21h
        ret
        endp

code ends
end start
