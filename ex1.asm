.section .text
.global _start
_start:
    test length, length
    jz Not_Legal_HW1 
    js Not_Legal_HW1
    test Index, Index
    js Not_Legal_HW1

    movq length, %rbx   
    shrq $32, %rbx        
    test %ebx, %ebx      
    jne Not_Legal_HW1   
  
    movq Index, %rbx   
    shrq $32, %rbx        
    test %ebx, %ebx      
    jne Not_Legal_HW1
   
    # Check if Index < length
    movq length, %rbx
    cmpq %rbx, Index
    jae Not_Legal_HW1

    # Check if Address is non-null
    movq Address, %rbx
    test %rbx, %rbx
    jz Not_Legal_HW1

    # Check alignment (optional, if required)
    # test $0x3, %rbx    # Check for 4-byte alignment, for example
    # jnz Not_Legal_HW1

    # Access array and set num
    movl Index, %ecx
    movl (%rbx,%rcx,4), %eax  
    movl %eax, num
    movb $1, Legal
    jmp End_HW1

Not_Legal_HW1:
    movb $0, Legal

End_HW1:
    nop
