.model small

.data

.code
main PROC
    MOV AX, 0
    MOV BX, 1
    MOV CX, 5

    @sum:
    ADD AX, BX
    INC BX

    LOOP @sum

main endp
end main