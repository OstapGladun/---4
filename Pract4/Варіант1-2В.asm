; Скопіювати модифікований код задачі 1B. Винести код розрахунку Y-Y*X 
; у окрему функцію, що повертає результат у AX. Код запису слова
; у елемент X:Y масиву - у процедуру, використовуючи BX і DX для координат
; і AX для значення. (практичне 4.1 задача 2В)
.model small

.data
    array dw 12*12 dup(0)
    
    ; коли починається цикл array_cols (всередині циклу array_rows),
    ; лічильник cx, який індикує поточний рядок треба зберегти в row_counter
    ; щоб використати для циклу array_cols, а по закінченню array_cols, завантажити назад
    row_counter dw 0  

.code
main proc

    ;лічильник циклу, який також слугує як лічільник рядків(йде від 12 до 0)
    mov cx, 12

    @array_rows:

        ;запам'ятати на якому рядку ми закінчили
        mov row_counter, cx    
        ;встановити лічильник циклу, який також слугує рахує стовпці (йде від 12 до 0)
        mov cx, 12 

        @array_cols:            
            ;bx і dx для координат X та Y
            call set_bx
            call set_dx
            call write_to_array
            loop @array_cols

        ;повернути запам'ятований лічильник рядків
        mov cx, row_counter
        ;повторювати поки лічильник не дійде до 0-го рядка
        loop @array_rows

    ; масив заповнено, закінити пронраму
    mov ah, 4Ch
    int 21h
main endp

;задати bx значення X (номер поточного рядка)
set_bx proc
    mov bx, cx
    dec bx ; тому що координати рахуються починаючи з нуля
    ret
set_bx endp

;задати dx значення Y (номер поточного стовпця)
set_dx proc
    mov dx, row_counter
    dec dx
    ret
set_dx endp

;знайти індекс комірки та вписати в неї Y-Y*X
write_to_array proc 
    ;зберегти загальну кількість стовпців
    mov ax, 12 
    ;помножити лічильник рядка на загальну кількість стовпців
    mul dx
    ;повернути dx початкове значення, адже mul записує 0 в dx
    call set_dx
    ;додати лічільник стовпців
    add ax, bx
    ;зберегти результат
    mov si, ax
    ;порахувати значення і вписати в комірку
    call calculate
    mov [array + si], ax
    ret
write_to_array endp

;обчислити Y-Y*X(dx - dx * bx) і зберегти в ax
calculate proc
    mov ax, dx ; ax = Y 
    mul bx ; ax=ax*bx | Y*X
    call set_dx ; повернути dx початкове значення, адже mul записує 0 в dx
    sub dx, ax ; dx-ax | Y-Y*X
    mov ax, dx; ax = Y-Y*X
    ret
calculate endp

end main