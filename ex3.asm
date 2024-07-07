.section .text
_start:
    xor %rax, %rax       # Clear rax (node counter)
    xor %rcx, %rcx       # Clear rcx (leaf counter)

    movq root(%rip), %rdi
    cmpq $0, (%rdi)
    je Not_Rich_HW1

height1_HW1:
    addq $1, %rax
    cmpq $0, (%rdi)
    jne height1_loop_HW1
    addq $1, %rcx
    jmp traverse_complete_HW1

height1_loop_HW1:
    movq (%rdi), %r8
    cmpq $0, %r8
    je Is_leaf1_HW1
    addq $1, %rax

height2_loop_HW1:
    movq (%r8), %r9
    cmpq $0, %r9
    je Is_leaf2_HW1
    addq $1, %rax

height3_loop_HW1:
    movq (%r9), %r10
    cmpq $0, %r10
    je Is_leaf3_HW1
    addq $1, %rax

height4_loop_HW1:
    movq (%r10), %r11
    cmpq $0, %r11
    je Is_leaf4_HW1
    addq $1, %rax

height5_loop_HW1:
    movq (%r11), %r12
    cmpq $0, %r12
    je Is_leaf5_HW1
    addq $1, %rax

height6_HW1:
    addq $1, %rax
    addq $1, %rcx
    addq $8, %r12

height5_next_HW1:
    addq $8, %r11
    jmp height5_loop_HW1

height4_next_HW1:
    addq $8, %r10
    jmp height4_loop_HW1

height3_next_HW1:
    addq $8, %r9
    jmp height3_loop_HW1

height2_next_HW1:
    addq $8, %r8
    jmp height2_loop_HW1

height1_next_HW1:
    addq $8, %rdi
    jmp height1_loop_HW1

Is_leaf1_HW1:
    cmpq (root), %rdi
    jne traverse_complete_HW1
    addq $1, %rcx
    jmp traverse_complete_HW1

Is_leaf2_HW1:
    cmpq (%rdi), %r8
    jne height1_next_HW1
    addq $1, %rcx
    jmp height1_next_HW1

Is_leaf3_HW1:
    cmpq (%r8), %r9
    jne height2_next_HW1
    addq $1, %rcx
    jmp height2_next_HW1 

Is_leaf4_HW1:
    cmpq (%r9), %r10
    jne height2_next_HW1
    addq $1, %rcx
    jmp height3_next_HW1

Is_leaf5_HW1:
    cmpq (%r10), %r11
    jne height2_next_HW1
    addq $1, %rcx
    jmp height4_next_HW1

traverse_complete_HW1:
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
