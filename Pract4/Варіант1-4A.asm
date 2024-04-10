;(4A: 1 бал) Скопіювати модифікований код задачі 3A. Додати до функції код, який:
;перед виконанням функції зберігає у стек регістри, які функція змінює;
;після завершення виконання функції витягує ці регістри назад із стеку.
;Мета: забезпечити, що функція не впливає на стан регістрів викликаючого коду.
.model small

.data
    result dw 0
.code
main PROC
    mov ax, 9
    mov bx, 1
    push ax
    push bx
    call smaller_number
    mov result, ax
    pop bx
    pop ax
main endp

smaller_number proc
    push ax
    cmp ax, bx
    jle ax_is_smaller
    mov ax, bx
    pop ax
    ret
    ax_is_smaller:
    pop ax
    ret
smaller_number endp

end main