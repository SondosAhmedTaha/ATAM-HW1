.global _start

.section .text
_start:
#your code here
    xor %rax, %rax       # Clear rax (node counter)
    xor %rcx, %rcx       # Clear rcx (leaf counter)


    # Start traversal from root
    mov $root, %r10
level1:
    addq $1, %rax
    cmpq $0, (%r10)
    jne level1_loop
    addq $1, %racx
    jmp traverse_complete

level1_loop:
    movq (%r10), %r11
    cmpq $0, %r11
    je check_leaf1
    addq $1, %rax

level2_loop:
    movq (%r11), %r12
    cmpq $0, %r12
    je check_leaf2
    addq $1, %rax

level3_loop:
    movq (%r12), %r13
    cmpq $0, %r13
    je check_leaf3
    addq $1, %rax

level4_loop:
    movq (%r13), %r14
    cmpq $0, %r14
    je check_leaf4
    addq $1, %rax

level5_loop:
    movq (%r14), %r15
    cmpq $0, %r15
    je check_leaf5
    addq $1, %rax

level6:
    addq $1, %rax
    addq $1, %racx
    addq $8, %r15

level5_next:
    addq $8, %r14
    jmp level5_loop

level4_next:
    addq $8, %r13
    jmp level4_loop

level3_next:
    addq $8, %r12
    jmp level3_loop

level2_next:
    addq $8, %r11
    jmp level2_loop

level1_next:
    addq $8, %r10
    jmp level1_loop

check_leaf1:
    cmpq (root), %r10
    jne traverse_complete
    addq $1, %racx
    jmp traverse_complete

check_leaf2:
    cmpq (%r10), %r11
    jne level1_next
    addq $1, %racx
    jmp level1_next

check_leaf3:
    cmpq (%r11), %r12
    jne level2_next
    addq $1, %racx
    jmp level2_next 

check_leaf4:
    cmpq (%r12), %r13
    jne level2_next
    addq $1, %racx
    jmp level3_next

check_leaf5:
    cmpq (%r13), %r14
    jne level2_next
    addq $1, %racx
    jmp level4_next

traverse_complete:
    test %rcx, %rcx      # Check if there are any leaves
    jz Not_Rich          # If no leaves, tree is not rich

    xor %rdx, %rdx       # Clear rdx for division
    div %rcx             # Divide total nodes by total leaves
    cmp $3, %rax         # Compare the quotient with 3
    jg Not_Rich          # If quotient > 3, not rich
    je Equal_Rich        # If quotient == 3, check remainder
    jmp Rich             # Else, rich

Not_Rich:
    movb $0, rich  # Set rich to 0
    jmp End

Rich:
    movb $1, rich  # Set rich to 1
    jmp End

Equal_Rich:
    cmp $0, %rdx         # Check if remainder is 0
    je Rich              # If 0, rich
    jmp Not_Rich         # Else, not rich

End:



