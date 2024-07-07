.section .text
_start:
    # Initialize node and leaf counters
    movq $0, %rax       # Node counter
    movq $0, %rcx       # Leaf counter

    # Set root node address
    mov $root, %rdi
    cmpq $0, (%rdi)
    je Not_Rich_HW1

# Traverse and count nodes and leaves
height1_HW1:
    inc %rax             # Increment node counter
    cmpq $0, (%rdi)
    jne loop1_HW1
    inc %rcx             # Increment leaf counter
    jmp Scan_Done_HW1

loop1_HW1:
    movq (%rdi), %r8
    testq %r8, %r8
    je Is_leaf1_HW1
    inc %rax             # Increment node counter

loop2_HW1:
    movq (%r8), %r9
    testq %r9, %r9
    je Is_leaf2_HW1
    inc %rax             # Increment node counter

loop3_HW1:
    movq (%r9), %r10
    testq %r10, %r10
    je Is_leaf3_HW1
    inc %rax             # Increment node counter

loop4_HW1:
    movq (%r10), %r11
    testq %r11, %r11
    je Is_leaf4_HW1
    inc %rax             # Increment node counter

loop5_HW1:
    movq (%r11), %r12
    testq %r12, %r12
    je Is_leaf5_HW1
    inc %rax             # Increment node counter

height6_HW1:
    inc %rax             # Increment node counter
    inc %rcx             # Increment leaf counter
    lea 8(%r12), %r12    # Move to next sibling

sibling5_HW1:
    lea 8(%r11), %r11
    jmp loop5_HW1

Is_leaf1_HW1:
    cmpq $root, %rdi
    jne Scan_Done_HW1
    inc %rcx             # Increment leaf counter
    jmp Scan_Done_HW1

sibling1_HW1:
    lea 8(%rdi), %rdi
    jmp loop1_HW1

Is_leaf2_HW1:
    cmpq (%rdi), %r8
    jne sibling1_HW1
    inc %rcx             # Increment leaf counter
    jmp sibling1_HW1

sibling2_HW1:
    lea 8(%r8), %r8
    jmp loop2_HW1

Is_leaf3_HW1:
    cmpq (%r8), %r9
    jne sibling2_HW1
    inc %rcx             # Increment leaf counter
    jmp sibling2_HW1

sibling3_HW1:
    lea 8(%r9), %r9
    jmp loop3_HW1

Is_leaf4_HW1:
    cmpq (%r9), %r10
    jne sibling2_HW1
    inc %rcx             # Increment leaf counter
    jmp sibling3_HW1

sibling4_HW1:
    lea 8(%r10), %r10
    jmp loop4_HW1

Is_leaf5_HW1:
    cmpq (%r10), %r11
    jne sibling2_HW1
    inc %rcx             # Increment leaf counter
    jmp sibling4_HW1

Scan_Done_HW1:
    test %rcx, %rcx      # Check if there are any leaves
    jz Not_Rich_HW1      # If no leaves, tree is not rich

    # Calculate and compare node-to-leaf ratio
    xor %rdx, %rdx       # Clear rdx for division
    div %rcx             # Divide total nodes by total leaves
    cmp $3, %rax         # Compare the quotient with 3
    jg Not_Rich_HW1      # If quotient > 3, not rich
    je Equal_Rich_HW1    # If quotient == 3, check remainder
    jmp Rich_HW1         # Else, rich

Not_Rich_HW1:
    movb $0, rich        # Set rich to 0
    jmp End_HW1

Rich_HW1:
    movb $1, rich        # Set rich to 1
    jmp End_HW1

Equal_Rich_HW1:
    test %rdx, %rdx      # Check if remainder is 0
    je Rich_HW1          # If 0, rich
    jmp Not_Rich_HW1     # Else, not rich

End_HW1:
