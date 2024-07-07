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
    je seconddegree_HW1          # Jump to seconddegree_HW1 if equal

    movl 0(%r14,%r8,4), %edx     # Load next element of series into %edx
    subl %ebx, %edx              # Calculate difference between current and next elements

    cmp $1, %rdi                 # Compare %rdi with 1
    je continue1_DiffX2_HW1      # Jump to continue1_DiffX2_HW1 if equal

    movl %edx, %r10d             # Store current difference in %r10d
    subl %r9d, %r10d             # Calculate difference of differences
    movl %r10d, %r11d            # Store the result in %r11d
    movl %r11d, %r9d             # Update previous difference

    cmp $2, %rdi                 # Compare %rdi with 2
    jne continue2_DiffX2_HW1     # Jump to continue2_DiffX2_HW1 if not equal
    movl %r10d, %r12dd           # Store current difference of differences in %r12d

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
Loop_DiffXRatio_HW1:
    movl 0(%r14,%rdi,4) ,%ebx

    addq $1, %r8
    cmp %r8d , %eax
    je seconddegree_HW1
    movl 0(%r14,%rdi,4) ,%edx
    subl %ebx ,%edx
## maybe should check if edx is not zero
    cmp $1, %rdi
    je continue1_DiffXRatio_HW1
    movl %edx, %r10d        
    sub %r9d, %r10d           
    movl %r10d, %r11d          
    movl %r11d, %r9d          

    cmp $2, %rdi 
    jne  continue2_DiffX2_HW1
    movl %r10d, %r12dd
  
continue2_DiffX2_HW1:
    cmp %r10d, %r12d
    jne checkSeries_DiffXRatio_HW1
    jmp checkSeries_DiffX2_HW1
continue1_DiffXRatio_HW1:
    movl %edx, %r9d
    jmp Loop_DiffXRatio_HW 
#######################################################################################
checkSeries_RatioXRatio_HW1:
    movl $0, %r8d 
Loop_RatioXRatio_HW1:
#######################################################################################
checkSeries_DiffXDiff_HW1:
    movl $0, %r8d 
Loop_DiffXDiff_HW1:


Not_seconddegree_HW1:
    movb $0, seconddegree        # Set seconddegree to 0
    jmp End_HW1                  # Jump to End_HW1

seconddegree_HW1:
    movb $1, seconddegree        # Set seconddegree to 1

End_HW1:
