data segment
    msg1 db 10,13, "Enter your choice: $"
    msg2 db 10,13, "1.Addition $"
    msg3 db 10,13, "2.Subtraction $"
    msg4 db 10,13, "3.Exit $"
    msg51 db 10,13, "Enter first number: $"
    msg52 db 10,13, "Enter second number: $"
    msg6 db 10,13, "The result is: $"
    msg7 db 10,13, "$"

    result db ?
    choice db ?
    n1 db ?
    n2 db ?
data ends
code segment
    assume cs:code,ds:data
    start:
        mov ax,data
        mov ds, ax

    loop1:
        call display1
        jnz check
        
    exit:
        mov ah, 4ch
        int 21h

    check:
        cmp choice,01h
        jz add1
        mov bl,n1
        mov cl,n2
        sub bl,cl
        mov result,bl
        jmp print

    add1:
        mov bl,n1
        mov cl,n2
        add bl,cl
        mov result,bl

    print:
        mov ah,09h
        mov dx, offset msg6
        int 21h

        and bl,0F0h
        ror bl,04h
        call output

        mov bl,result
        and bl,0Fh
        call output
        
        jmp loop1

     display1 proc
        mov ah,09h
        mov dx, offset msg1
        int 21h

        mov ah,09h
        mov dx, offset msg2
        int 21h

        mov ah,09h
        mov dx, offset msg3
        int 21h

        mov ah,09h
        mov dx, offset msg4
        int 21h
        endp
        
        mov ah,09h
        mov dx, offset msg7
        int 21h

        call input
        mov choice,al
        
        cmp choice,03h
        jz exit

        mov ah,09h
        mov dx, offset msg51
        int 21h

        call input
        mov bl,al           
        rol bl, 04h
        call input
        add bl,al 
        mov n1,bl

        mov ah,09h
        mov dx, offset msg52
        int 21h

        call input
        mov bl,al           
        rol bl, 04h
        call input
        add bl,al 
        mov n2,bl

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
