.global _start

.section .text
_start:

    xor %rax, %rax
    xor %rcx, %rcx

    mov root(%rip), %rdi
    test %rdi, %rdi
    jz traverse_complete

level1:
    inc %rax
    movq 0(%rdi), %rsi
    test %rsi, %rsi
    je check_leaf1

level2:
    inc %rax
    movq 0(%rsi), %r8
    test %r8, %r8
    je check_leaf2

level3:
    inc %rax
    movq 0(%r8), %r9
    test %r9, %r9
    je check_leaf3

level4:
    inc %rax
    movq 0(%r9), %r10
    test %r10, %r10
    je check_leaf4

level5:
    inc %rax
    movq 0(%r10), %r11
    test %r11, %r11
    je check_leaf5

level6:
    inc %rax
    movq 0(%r11), %r12
    test %r12, %r12
    je check_leaf6

    inc %rax
    jmp next_sibling6

check_leaf6:
    inc %rcx

next_sibling6:
    add $8, %r11
    movq 0(%r11), %r12
    test %r12, %r12
    jnz level6
    jmp next_sibling5

check_leaf5:
    inc %rcx

next_sibling5:
    add $8, %r10
    movq 0(%r10), %r11
    test %r11, %r11
    jnz level5
    jmp next_sibling4

check_leaf4:
    inc %rcx

next_sibling4:
    add $8, %r9
    movq 0(%r9), %r10
    test %r10, %r10
    jnz level4
    jmp next_sibling3

check_leaf3:
    inc %rcx

next_sibling3:
    add $8, %r8
    movq 0(%r8), %r9
    test %r9, %r9
    jnz level3
    jmp next_sibling2

check_leaf2:
    inc %rcx

next_sibling2:
    add $8, %rsi
    movq 0(%rsi), %r8
    test %r8, %r8
    jnz level2
    jmp next_sibling1

check_leaf1:
    inc %rcx

next_sibling1:
    add $8, %rdi
    movq 0(%rdi), %rsi
    test %rsi, %rsi
    jnz level1
    jmp traverse_complete

traverse_complete:
    
    xor %rdx, %rdx
    div %rcx
    cmp $3, %rax
    jg Not_Rich
    je Equal_Rich
    jmp Rich

Not_Rich:
    movb $0, rich
    jmp End

Rich:
    movb $1, rich
    jmp End

Equal_Rich:
    cmp $0, %rdx
    je Rich
    jmp Not_Rich

End:
