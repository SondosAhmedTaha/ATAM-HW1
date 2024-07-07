.global _start
.section .text
_start:

movl size, %eax         # Load size of the series into %eax (32-bit)
testl %ecx, %eax
jz Not_seconddegree_HW1 
js Not_seconddegree_HW1
cmp $1, %eax
jle end_HW1             # checking that size > 1

mov $series, %r14      # Load address of series into %r14
testq %r14, %r14 
je Not_seconddegree_HW1

movl $0, %r8d           # Set loop counter i = 0

checkSeries_DiffX2_HW1:
    movl 0(%r14,%rdi,4) ,%ebx

    inc %r8d
    cmp %r8d , %eax
    je seconddegree_HW1
    movl 0(%r14,%rdi,4) ,%edx

    subl %ebx ,%edx

    cmp $1, %rdi

    je continue1_DiffX2_HW1
    movl %edx, %r10d        
    sub %r9d, %r10d           
    movl %r10d, %r11d          
    movl %r11d, %r9d          

    cmp $2, %rdi 
    je  continue2_DiffX2_HW1
    cmp %r10d, %r12d
    jne checkSeries_DiffXRatio_HW1
    jmp checkSeries_DiffX2_HW1
    
continue2_DiffX2_HW1:
    movl %r10d, %r12d
continue1_DiffX2_HW1:
    movl %edx, %r9d
    jmp checkSeries_DiffX2_HW1

checkSeries_DiffXRatio_HW1:

Not_seconddegree_HW1:
  movb $0, seconddegree
  jmp End_HW1

seconddegree_HW1:
  movb $1, seconddegree

End_HW1:
