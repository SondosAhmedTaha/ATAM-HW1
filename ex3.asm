.section .text
.global _start

_start:
    movq root(%rip), %rdi          # מצביע לשורש של העץ
    xor %rbx, %rbx           # איפוס מונה הצמתים
    xor %rcx, %rcx           # איפוס מונה העלים
    xor %rdx, %rdx           # איפוס מונה העומק

traverse_tree_HW1:
    inc %rbx
    movq 0(%rdi), %r9   ; Load first child pointer
    test %r9, %r9       ; Check if it's NULL
    jz count_leaf       ; If NULL, it's a leaf
    movq %r9, %rdi      ; Move to the first child node
    jmp traverse_tree_HW1   ; Continue traversal

count_leaf_HW1:
    inc %rcx
    movq (%rdi), %rdi   
    cmp root, %rdi
    jne traverse_tree_HW1 
    
End_HW1:
