.global _start
.section .text
_start:

    movl size, %eax         # Load size of the series into %eax (32-bit)
    testl %eax, %eax        # Test if size is zero
    jz Not_seconddegree_HW1 # Jump to Not_seconddegree_HW1 if size is zero
    js Not_seconddegree_HW1 # Jump to Not_seconddegree_HW1 if size is negative
    cmp $2, %eax            # Compare size with 2
    jl end_HW1              # Jump to end_HW1 if size < 2 (i.e., size <= 1)

    mov $series, %r14       # Load address of series into %r14
    testq %r14, %r14        # Test if series address is zero
    je Not_seconddegree_HW1 # Jump to Not_seconddegree_HW1 if series address is zero

    movl $0, %r8d           # Set loop counter i = 0

checkSeries_DiffX2_HW1:
    movl 0(%r14,%rdi,4), %ebx   # Load current element of series into %ebx

    addq $1, %r8                 # Increment loop counter
    cmp %r8d, %eax               # Compare loop counter with size
    jne continue3_DiffX2_HW1
    jmp seconddegree_HW1          # Jump to seconddegree_HW1 if equal
continue3_DiffX2_HW1:
    movl 0(%r14,%rdi,4), %edx     # Load next element of series into %edx
    subl %ebx, %edx              # Calculate difference between current and next elements

    cmp $1, %rdi                 # Compare %rdi with 1
    je continue1_DiffX2_HW1      # Jump to continue1_DiffX2_HW1 if equal

    movl %edx, %r10d             # Store current difference in %r10d
    subl %r9d, %r10d             # Calculate difference of differences
    movl %edx, %r9d             # Update previous difference

    cmp $2, %rdi                 # Compare %rdi with 2
    jne continue2_DiffX2_HW1     # Jump to continue2_DiffX2_HW1 if not equal
    movl %r10d, %r12d           # Store current difference of differences in %r12d
    jmp checkSeries_DiffX2_HW1
continue2_DiffX2_HW1:
    cmp %r10d, %r12d             # Compare current difference of differences with stored value
    jne checkSeries_DiffXRatio_HW1   # Jump to checkSeries_DiffXRatio_HW1 if not equal
    jmp checkSeries_DiffX2_HW1   # Jump back to checkSeries_DiffX2_HW1

continue1_DiffX2_HW1:
    movl %edx, %r9d              # Update previous difference with current difference
    jmp checkSeries_DiffX2_HW1   # Jump back to checkSeries_DiffX2_HW1
#######################################################################################
checkSeries_DiffXRatio_HW1:
    movl $0, %r8d 
    movl size, %esi
Loop_DiffXRatio_HW1:
    movl 0(%r14,%rdi,4) ,%ebx

    addq $1, %r8
    cmp %r8d , %esi
    jne continue3_DiffXRatio_HW1
    jmp seconddegree_HW1
continue3_DiffXRatio_HW1:
    movl 0(%r14,%rdi,4) ,%edx
    subl %ebx ,%edx
## maybe should check if edx is not zero
    cmp $1, %rdi
    je continue1_DiffXRatio_HW1
    testl %edx, %edx
    je checkSeries_RatioXRatio_HW1
    movl %ebx, %eax
    movl %edx, %ebx
    movl %edx, %eax
    cdq
    idivl %r9d #we can assume that there is no remainder

    movl %ebx, %r9d
         
    cmp $2, %rdi 
    jne  continue2_DiffXRatio_HW1
    movl %eax, %r12d
    jmp Loop_DiffXRatio_HW1
continue2_DiffXRatio_HW1:
    cmp %eax, %r12d
    je Loop_DiffXRatio_HW1
    jmp checkSeries_RatioXRatio_HW1
continue1_DiffXRatio_HW1:
     testl %edx, %edx
    je checkSeries_RatioXRatio_HW1
    movl %edx, %r9d
    jmp Loop_DiffXRatio_HW1 
#######################################################################################
checkSeries_RatioXRatio_HW1:
    movl $0, %r8d 
Loop_RatioXRatio_HW1:
    movl 0(%r14,%rdi,4) ,%ebx
    cmpl $0, %ebx
    je checkSeries_RatioXDiff_HW1

    addq $1, %r8
    cmp %r8d , %esi
    jne continue3_RatioXRatio_HW1
    jmp seconddegree_HW1
continue3_RatioXRatio_HW1:
    movl 0(%r14,%rdi,4) ,%eax
    cmpl $0, %eax
    je checkSeries_RatioXDiff_HW1
    cdq
    idivl %ebx
    cmpl $0 , %edx
    jne checkSeries_RatioXDiff_HW1
    
    cmp $1, %rdi
    je continue1_RatioXRatio_HW1
    movl %eax, %r10d
    cdq
    idivl %r9d #we can assume that there is no remainder
    cmpl $0 , %edx
    jne checkSeries_RatioXDiff_HW1
    movl %r10d, %r9d

    cmp $2, %rdi 
    jne  continue2_RatioXRatio_HW1
    movl %eax, %r12d
    jmp Loop_RatioXRatio_HW1
continue2_RatioXRatio_HW1:
    cmp %eax, %r12d
    je Loop_RatioXRatio_HW1
    jmp checkSeries_RatioXDiff_HW1
continue1_RatioXRatio_HW1:
    movl %eax, %r9d
    jmp Loop_RatioXRatio_HW1 
#######################################################################################
checkSeries_RatioXDiff_HW1:
    movl $0, %r8d 
Loop_RatioXDiff_HW1:
    movl 0(%r14,%rdi,4) ,%ebx
    cmpl $0, %ebx
    je Not_seconddegree_HW1

    addq $1, %r8
    cmp %r8d , %esi
    jne continue3_RatioXDiff_HW1
    jmp seconddegree_HW1
continue3_RatioXDiff_HW1:
    movl 0(%r14,%rdi,4) ,%eax
    cmpl $0, %eax
    je Not_seconddegree_HW1
    cdq
    idivl %ebx
    cmpl $0 , %edx
    jne Not_seconddegree_HW1
    
    cmp $1, %rdi
    je continue1_RatioXDiff_HW1
    movl %eax, %r10d
    sub %r9d, %r10d
    movl %eax, %r9d
    
    cmp $2, %rdi 
    jne  continue2_RatioXDiff_HW1
    movl %r10d, %r12d
    jmp Loop_RatioXDiff_HW1
continue2_RatioXDiff_HW1:
    cmp %r10d, %r12d
    je Loop_RatioXDiff_HW1
    jmp Not_seconddegree_HW1

continue1_RatioXDiff_HW1:
    movl %eax, %r9d
    jmp Loop_RatioXDiff_HW1 

Not_seconddegree_HW1:
    movb $0, seconddegree        # Set seconddegree to 0
    jmp End_HW1                  # Jump to End_HW1

seconddegree_HW1:
    movb $1, seconddegree        # Set seconddegree to 1

End_HW1:
