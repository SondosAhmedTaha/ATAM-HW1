.section .text
_start:
    xor %rax, %rax       # node counter
    xor %rcx, %rcx       # leaf counter
    movq $root, %rdi
    cmpq $0, (%rdi)
    je Not_Rich_HW1

height1_HW1:
    inc %rax
    cmpq $0, (%rdi)
    jne loop1_HW1
    inc %rcx
    jmp Scan_Done_HW1

loop1_HW1:
    movq (%rdi), %r9
    cmpq $0, %r9
    je Is_leaf1_HW1
    inc %rax

loop2_HW1:
    movq (%r9), %r10
    cmpq $0, %r10
    je Is_leaf2_HW1
    inc %rax

loop3_HW1:
    movq (%r10), %r11
    cmpq $0, %r11
    je Is_leaf3_HW1
    inc %rax

loop4_HW1:
    movq (%r11), %r12
    cmpq $0, %r12
    je Is_leaf4_HW1
    inc %rax

loop5_HW1:
    movq (%r12), %r13
    cmpq $0, %r13
    je Is_leaf5_HW1
    inc %rax

height6_HW1:
    inc %rax
    inc %rcx
    addq $8, %r13

sibling5_HW1:
    addq $8, %r12
    jmp loop5_HW1

Is_leaf1_HW1:
    cmpq (root), %rdi
    jne Scan_Done_HW1
    inc %rcx
    jmp Scan_Done_HW1

sibling1_HW1:
    addq $8, %rdi
    jmp loop1_HW1

Is_leaf2_HW1:
    cmpq (%rdi), %r9
    jne sibling1_HW1
    inc %rcx
    jmp sibling1_HW1
sibling2_HW1:
    addq $8, %r9
    jmp loop2_HW1

Is_leaf3_HW1:
    cmpq (%r9), %r10
    jne sibling2_HW1
    inc %rcx
    jmp sibling2_HW1 
sibling3_HW1:
    addq $8, %r10
    jmp loop3_HW1


Is_leaf4_HW1:
    cmpq (%r10), %r11
    jne sibling2_HW1
    inc %rcx
    jmp sibling3_HW1
sibling4_HW1:
    addq $8, %r11
    jmp loop4_HW1

Is_leaf5_HW1:
    cmpq (%r11), %r12
    jne sibling2_HW1
    inc %rcx
    jmp sibling4_HW1

Scan_Done_HW1:
    test %rcx, %rcx      # Check if there are any leaves
    jz Not_Rich_HW1      # If no leaves, tree is not rich

    xor %rdx, %rdx       # Clear rdx for division
    div %rcx             # Divide total nodes by total leaves
    cmp $3, %rax         # Compare the quotient with 3
    jg Not_Rich_HW1      # If quotient > 3, not rich
    je Equal_Rich_HW1    # If quotient == 3, check remainder
    jmp Rich_HW1         # Else, rich

Not_Rich_HW1:
    movb $0, rich  # Set rich to 0
    jmp End_HW1

Rich_HW1:
    movb $1, rich  # Set rich to 1
    jmp End_HW1

Equal_Rich_HW1:
    cmp $0, %rdx         # Check if remainder is 0
    je Rich_HW1          # If 0, rich
    jmp Not_Rich_HW1     # Else, not rich

End_HW1:
