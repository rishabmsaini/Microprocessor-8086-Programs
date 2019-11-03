data segment
    msg1 db 10,13, "Enter the length: $"
    msg2 db 10,13, "Enter the numbers: $"
    msg3 db 10,13, "The minimum number is: $"
    msg4 db 10,13, "$"
    
    len db ?
    res db ?
data ends
code segment
    assume cs:code, ds:data
    start:
        mov ax,data
        mov ds, ax
        
        mov ah,09h
        mov dx,offset msg1
        int 21h
        
        call input
        mov cl,al
        rol cl,04h
        and cl,0F0h
        call input
        add cl,al
        and ch,00h
        mov len,cl
        
        mov ah,09h
        mov dx,offset msg2
        int 21h
        mov ah,09h
        mov dx,offset msg4
        int 21h
        
        mov si,1000h
        back:
            call input
            mov bl,al
            rol bl,04h
            and bl,0F0h
            call input
            add bl,al
            mov [si],bl
            inc si
            mov ah,09h
            mov dx,offset msg4
            int 21h
            loop back
        
        mov bl,0FFH
        mov cl,len
        mov ch,00h
        mov si, 1000h
        loop2:
            mov al,[si]
            cmp al,bl
            jnc incsi
            mov bl,al
            incsi:
                inc si
                loop loop2
               
        mov ah,09h
        mov dx, offset msg3
        int 21h 
               
        mov res,bl
        ror bl,04h
        and bl,0FH
        call output
        mov bl,res
        and bl,0FH
        call output
        
        mov ah, 4ch
        int 21h
        
    input proc
        mov ah,01h
        int 21h
        cmp al,41h
        jc A
        sub al,07h
        A:sub al,30h
        ret
        endp
        
    output proc
        cmp bl,0ah
        jc B
        add bl,07h
        B:add bl,30h
        mov ah,02h
        mov dl,bl
        int 21h
        ret
        endp
code ends
end start
