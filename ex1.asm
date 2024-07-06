.global _start

.section .text
_start:
    xor %rax, %rax       # Counter for nodes
    xor %rcx, %rcx       # Counter for leaves

    mov root(%rip), %rdi # Load the root node
    testq %rdi, %rdi      # Check if root is null
    jz traverse_complete # If null, jump to completion

level1:
    inc %rax             # Increment node counter
    movq 0(%rdi), %rsi   # Load left child
    testq %rsi, %rsi      # Check if left child is null
    je check_leaf1       # If null, check if it's a leaf

level2:
    inc %rax             # Increment node counter
    movq 0(%rsi), %r8    # Load left child
    testq %r8, %r8        # Check if left child is null
    je check_leaf2       # If null, check if it's a leaf

level3:
    inc %rax             # Increment node counter
    movq 0(%r8), %r9     # Load left child
    testq %r9, %r9        # Check if left child is null
    je check_leaf3       # If null, check if it's a leaf

level4:
    inc %rax             # Increment node counter
    movq 0(%r9), %r10    # Load left child
    testq %r10, %r10      # Check if left child is null
    je check_leaf4       # If null, check if it's a leaf

level5:
    inc %rax             # Increment node counter
    movq 0(%r10), %r11   # Load left child
    testq %r11, %r11      # Check if left child is null
    je check_leaf5       # If null, check if it's a leaf

level6:
    inc %rax             # Increment node counter
    movq 0(%r11), %r12   # Load left child
    testq %r12, %r12      # Check if left child is null
    je check_leaf6       # If null, check if it's a leaf

    inc %rax             # Increment node counter
    jmp next_sibling6    # Go to next sibling

check_leaf6:
    inc %rcx             # Increment leaf counter

next_sibling6:
    add $8, %r11         # Move to right sibling
    movq 0(%r11), %r12   # Load right sibling
    testq %r12, %r12      # Check if right sibling is null
    jnz level6           # If not null, continue to level6
    jmp next_sibling5    # If null, go to next sibling level5

check_leaf5:
    inc %rcx             # Increment leaf counter

next_sibling5:
    add $8, %r10         # Move to right sibling
    movq 0(%r10), %r11   # Load right sibling
    testq %r11, %r11      # Check if right sibling is null
    jnz level5           # If not null, continue to level5
    jmp next_sibling4    # If null, go to next sibling level4

check_leaf4:
    inc %rcx             # Increment leaf counter

next_sibling4:
    add $8, %r9          # Move to right sibling
    movq 0(%r9), %r10    # Load right sibling
    testq %r10, %r10      # Check if right sibling is null
    jnz level4           # If not null, continue to level4
    jmp next_sibling3    # If null, go to next sibling level3

check_leaf3:
    inc %rcx             # Increment leaf counter

next_sibling3:
    add $8, %r8          # Move to right sibling
    movq 0(%r8), %r9     # Load right sibling
    testq %r9, %r9        # Check if right sibling is null
    jnz level3           # If not null, continue to level3
    jmp next_sibling2    # If null, go to next sibling level2

check_leaf2:
    inc %rcx             # Increment leaf counter

next_sibling2:
    add $8, %rsi         # Move to right sibling
    movq 0(%rsi), %r8    # Load right sibling
    testq %r8, %r8        # Check if right sibling is null
    jnz level2           # If not null, continue to level2
    jmp next_sibling1    # If null, go to next sibling level1

check_leaf1:
    inc %rcx             # Increment leaf counter

next_sibling1:
    add $8, %rdi         # Move to right sibling
    movq 0(%rdi), %rsi   # Load right sibling
    testq %rsi, %rsi      # Check if right sibling is null
    jnz level1           # If not null, continue to level1
    jmp traverse_complete # If null, traverse is complete

traverse_complete:
    xor %rdx, %rdx       # Clear rdx for division
    div %rcx             # Divide total nodes by total leaves
    cmp $3, %rax         # Compare the quotient with 3
    jg Not_Rich          # If quotient > 3, not rich
    je Equal_Rich        # If quotient == 3, check remainder
    jmp Rich             # Else, rich

Not_Rich:
    movb $0, rich        # Set rich to 0
    jmp End

Rich:
    movb $1, rich        # Set rich to 1
    jmp End

Equal_Rich:
    cmp $0, %rdx         # Check if remainder is 0
    je Rich              # If 0, rich
    jmp Not_Rich         # Else, not rich

End:
