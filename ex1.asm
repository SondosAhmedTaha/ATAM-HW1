.global _start

.section .text
_start:
   
    movq length, %rax
    testq %rax, %rax
    jz Not_Legal_HW1 
    js Not_Legal_HW1

  
    movq Index, %rax
    testq %rax, %rax
    js Not_Legal_HW1

  
    movq length, %rbx   
    shrq $32, %rbx        
    testl %ebx, %ebx      
    jne Not_Legal_HW1   

    movq Index, %rbx   
    shrq $32, %rbx        
    testl %ebx, %ebx      
    jne Not_Legal_HW1   

    movq length, %rbx
    cmpq %rbx, Index
    jae Not_Legal_HW1

    movq Adress, %rbx
    testq %rbx, %rbx
    jz Not_Legal_HW1

    testq %rbx, %rbx
    js Not_Legal_HW1

 
    movq length, %rax
    shlq $2, %rax       
    addq Adress, %rax     
    movq Index, %rcx
    shlq $2, %rcx       
    addq Adress, %rcx     
    cmpq %rax, %rcx
    jae Not_Legal_HW1

    movl Index, %ecx
    movl (%rbx,%rcx,4), %eax  
    movl %eax, num
    movb $1, Legal
    jmp End_HW1

Not_Legal_HW1:
    movb $0, Legal

End_HW1:
