; Створіть визначення функції НСД(алгоритм Евкліда),
; де AX містить перше число, BX містить друге число,
; та результат (найбільший спільний дільник) зберігається в AX.
.model small
.data
.code
main proc
    mov ax, 15
    mov bx, 6

    ; НСД 15 і 6 це 3
    call euclid
main endp

euclid proc
    main_loop:
        ; якщо числа рівні то НСД обраховано і записане в ax, закінчити функцію, 
        cmp ax, bx
        je finish
        ja a_above_b

        ; якщо b більше a, відняти a від b
        sub bx, ax
        jmp main_loop

        ; якщо a більше b, відянти b від a
        a_above_b:
        sub ax, bx
        jmp main_loop
    finish:
        ret
euclid endp

end main