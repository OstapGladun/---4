.model small

.data

.code
main PROC
    MOV ax, 0
    MOV bx, 255  
    MOV cx, 8
    MOV dx, 1
    
    @count:
    MOV dx, 1
    AND dx, bx
    ADD ax, dx
    SHR bx, 1

    LOOP @count

main endp
end main