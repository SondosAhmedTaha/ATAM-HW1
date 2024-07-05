.global _start

.section .text
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

    # Check if Address is a positive value
    testq %rbx, %rbx
    js Not_Legal_HW1

 

    # Check if accessing Address[Index] is within bounds (Address + Index*4 < Address + length*4)
    movq length, %rax
    shlq $2, %rax         # length * 4
    addq Adress, %rax     # Address + length * 4
    movq Index, %rcx
    shlq $2, %rcx         # Index * 4
    addq Adress, %rcx     # Address + Index * 4
    cmpq %rax, %rcx
    jae Not_Legal_HW1

    # Access array and set num
    movl Index, %ecx
    movl (%rbx,%rcx,4), %eax  
    movl %eax, num
    movb $1, legal
    jmp End_HW1

Not_Legal_HW1:
    movb $0, legal

End_HW1:
