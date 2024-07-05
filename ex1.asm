.section .text
.global _start
_start:
    # Check if length is zero or negative
    movq length, %rax
    testq %rax, %rax
    jz Not_Legal_HW1 
    js Not_Legal_HW1

    # Check if Index is negative
    movq Index, %rax
    testq %rax, %rax
    js Not_Legal_HW1

    # Check high 32 bits of length
    movq length, %rbx   
    shrq $32, %rbx        
    testl %ebx, %ebx      
    jne Not_Legal_HW1   

    # Check high 32 bits of Index
    movq Index, %rbx   
    shrq $32, %rbx        
    testl %ebx, %ebx      
    jne Not_Legal_HW1   

    # Check if Index < length
    movq length, %rbx
    cmpq %rbx, Index
    jae Not_Legal_HW1

    # Check if Address is non-null
    movq Adress, %rbx
    testq %rbx, %rbx
    jz Not_Legal_HW1

    # Access array and set num
    movl Index, %ecx
    movl (%rbx,%rcx,4), %eax  
    movl %eax, num
    movb $1, Legal
    jmp End_HW1

Not_Legal_HW1:
    movb $0, Legal

End_HW1:
