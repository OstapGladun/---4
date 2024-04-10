.model small

.data

.code
main PROC
    mov ax, 7
    mov bx, 2
    call smaller_number

    mov ah, 4Ch
    int 21h
main endp

smaller_number proc
    cmp ax,bx
    jle ax_is_smaller
    mov ax, bx
    ret
    ax_is_smaller:
    ret
smaller_number endp
end main