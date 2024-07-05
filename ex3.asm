.global _start

.section .text
_start:
    movq root(%rip), %rdi          # מצביע לשורש של העץ
    xor %rax, %rax           # איפוס מונה הצמתים
    xor %rcx, %rcx           # איפוס מונה העלים

traverse_tree_HW1:
    inc %rax
    movq 0(%rdi), %r9   
    test %r9, %r9      
    jz count_leaf_HW1       
    movq %r9, %rdi      
    jmp traverse_tree_HW1   

count_leaf_HW1:
    inc %rcx
    movq (%rdi), %rdi   
    cmp root, %rdi
    jne traverse_tree_HW1 

End_Scan_HW1:
    xor %rdx, %rdx          
    div %rcx              
    cmp $3, %rax
    jg Not_Rich_HW1
    je Equal_HW1        
    jmp Rich_HW1
Not_Rich_HW1:
    movb $0,rich
    jmp End_HW1
Rich_HW1:
    movb $1, rich
    jmp End_HW1
Equal_HW1: 
    cmp $0, %rdx
    je Rich_HW1
    jmp Not_Rich_HW1
    
End_HW1:
