.global _start

.section .text
_start:
#your code here
    xor %rax, %rax  //vertec counter    
    xor %rcx, %rcx  //leaves counter 

    movq root(%rip), %rdi
    cmpq $0, (%rdi)
    je Not_Rich_HW1
hight1_HW1:
    addq $1, %rax
    cmpq $0, (%rdi)
    jne hight1_loop
    addq $1, %rcx
    jmp Scan_Done_HW1

hight1_loop:
    movq (%rdi), %r8
    cmpq $0, %r8
    je Is_leaf1
    addq $1, %rax
hight1_next:
    addq $8, %rdi
    jmp hight1_loop

Is_leaf1:
    cmpq (root), %rdi
    jne Scan_Done_HW1
    addq $1, %rcx
    jmp Scan_Done_HW1

hight2_loop:
    movq (%r8), %r9
    cmpq $0, %r9
    je Is_leaf2
    addq $1, %rax
hight2_next:
    addq $8, %r8
    jmp hight2_loop

Is_leaf2:
    cmpq (%rdi), %r8
    jne hight1_next
    addq $1, %rcx
    jmp hight1_next


hight3_loop:
    movq (%r9), %r11
    cmpq $0, %r11
    je Is_leaf3
    addq $1, %rax

hight3_next:
    addq $8, %r9
    jmp hight3_loop

Is_leaf3:
    cmpq (%r8), %r9
    jne hight2_next
    addq $1, %rcx
    jmp hight2_next 

hight4_loop:
    movq (%r11), %r10
    cmpq $0, %r10
    je Is_leaf4
    addq $1, %rax

hight4_next:
    addq $8, %r11
    jmp hight4_loop

Is_leaf4:
    cmpq (%r9), %r11
    jne hight2_next
    addq $1, %rcx
    jmp hight3_next

hight5_loop:
    movq (%r10), %r12
    cmpq $0, %r12
    je Is_leaf5
    addq $1, %rax

hight5_next:
    addq $8, %r10
    jmp hight5_loop

Is_leaf5:
    cmpq (%r11), %r10
    jne hight2_next
    addq $1, %rcx
    jmp hight4_next

hight6:
    addq $1, %rax
    addq $1, %rcx
    addq $8, %r12

Scan_Done_HW1:
    test %rcx, %rcx      # Check if there are any leaves
    jz Not_Rich_HW1          # If no leaves, tree is not rich

    xor %rdx, %rdx       # Clear rdx for division
    div %rcx             # Divide total nodes by total leaves
    cmp $3, %rax         # Compare the quotient with 3
    jg Not_Rich_HW1          # If quotient > 3, not rich
    je Equal_Rich_HW1        # If quotient == 3, check remainder
    jmp Rich_HW1             # Else, rich

Not_Rich_HW1:
    movb $0, rich  # Set rich to 0
    jmp End_HW1

Rich_HW1:
    movb $1, rich  # Set rich to 1
    jmp End_HW1

Equal_Rich_HW1:
    cmp $0, %rdx         # Check if remainder is 0
    je Rich_HW1              # If 0, rich
    jmp Not_Rich_HW1         # Else, not rich

End_HW1_:
