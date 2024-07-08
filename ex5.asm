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
    movl $0, %r8d            # Initialize loop counter to 0
    movl size, %esi          # Load size of the series into %esi

Loop_DiffXRatio_HW1:
    movl 0(%r14,%rdi,4), %ebx  # Load current element of series into %ebx

    addq $1, %r8             # Increment loop counter
    cmp %r8d , %esi          # Compare loop counter with size
    jne continue3_DiffXRatio_HW1 # Jump if not equal, continue loop
    jmp seconddegree_HW1     # Jump to seconddegree_HW1 if equal

continue3_DiffXRatio_HW1:
    movl 0(%r14,%rdi,4), %edx # Load next element of series into %edx
    subl %ebx ,%edx           # Calculate difference between current and next elements

    cmp $1, %rdi             # Compare %rdi with 1
    je continue1_DiffXRatio_HW1 # Jump if equal, continue to handle first element case

    testl %edx, %edx         # Test if %edx (difference) is zero
    je checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if zero

    movl %ebx, %eax          # Move %ebx (current element) to %eax
    movl %edx, %ebx          # Move %edx (difference) to %ebx
    movl %edx, %eax          # Move %edx (difference) to %eax (for division)
    cdq                      # Sign extend %eax into %edx
    idivl %r9d               # Divide %eax by %r9d (quotient in %eax, remainder in %edx)
    movl %ebx, %r9d          # Update %r9d with current difference

    cmp $2, %rdi             # Compare %rdi with 2
    jne continue2_DiffXRatio_HW1 # Jump if not equal, continue loop
    movl %eax, %r12d         # Move quotient to %r12d (for comparison)
    jmp Loop_DiffXRatio_HW1  # Jump back to Loop_DiffXRatio_HW1

continue2_DiffXRatio_HW1:
    cmp %eax, %r12d          # Compare quotient with stored value in %r12d
    je Loop_DiffXRatio_HW1   # Jump back to Loop_DiffXRatio_HW1 if equal
    jmp checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if not equal

continue1_DiffXRatio_HW1:
    testl %edx, %edx         # Test if %edx (difference) is zero
    je checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if zero
    movl %edx, %r9d          # Update %r9d with current difference
    jmp Loop_DiffXRatio_HW1  # Jump back to Loop_DiffXRatio_HW1

#######################################################################################
checkSeries_RatioXRatio_HW1:
    movl $0, %r8d             # Initialize loop counter r8d to 0
Loop_RatioXRatio_HW1:
    movl 0(%r14,%rdi,4), %ebx  # Load current element of the series into ebx
    cmpl $0, %ebx             # Compare ebx to 0
    je checkSeries_RatioXDiff_HW1  # If ebx is 0, jump to checkSeries_RatioXDiff_HW1

    addq $1, %r8              # Increment loop counter r8
    cmp %r8d, %esi            # Compare loop counter r8d with size esi
    jne continue3_RatioXRatio_HW1  # If not equal, jump to continue3_RatioXRatio_HW1
    jmp seconddegree_HW1      # Otherwise, jump to seconddegree_HW1

continue3_RatioXRatio_HW1:
    movl 0(%r14,%rdi,4), %eax  # Load next element of the series into eax
    cmpl $0, %eax             # Compare eax to 0
    je checkSeries_RatioXDiff_HW1  # If eax is 0, jump to checkSeries_RatioXDiff_HW1

    cdq                       # Sign-extend eax into edx:eax
    idivl %ebx                # Divide edx:eax by ebx; eax gets the quotient, edx gets the remainder
    cmpl $0, %edx             # Compare remainder edx to 0
    jne checkSeries_RatioXDiff_HW1  # If not equal (i.e., there is a remainder), jump to checkSeries_RatioXDiff_HW1

    cmp $1, %rdi              # Compare rdi to 1
    je continue1_RatioXRatio_HW1  # If equal, jump to continue1_RatioXRatio_HW1

    movl %eax, %r10d          # Store quotient in r10d
    cdq                       # Sign-extend eax into edx:eax
    idivl %r9d                # Divide edx:eax by r9d; eax gets the quotient, edx gets the remainder
    cmpl $0, %edx             # Compare remainder edx to 0
    jne checkSeries_RatioXDiff_HW1  # If not equal (i.e., there is a remainder), jump to checkSeries_RatioXDiff_HW1
    movl %r10d, %r9d          # Update r9d with the quotient

    cmp $2, %rdi              # Compare rdi to 2
    jne continue2_RatioXRatio_HW1  # If not equal, jump to continue2_RatioXRatio_HW1
    movl %eax, %r12d          # Store quotient in r12d
    jmp Loop_RatioXRatio_HW1  # Jump back to Loop_RatioXRatio_HW1

continue2_RatioXRatio_HW1:
    cmp %eax, %r12d           # Compare current quotient to stored quotient
    je Loop_RatioXRatio_HW1   # If equal, jump back to Loop_RatioXRatio_HW1
    jmp checkSeries_RatioXDiff_HW1  # Otherwise, jump to checkSeries_RatioXDiff_HW1

continue1_RatioXRatio_HW1:
    movl %eax, %r9d           # Update r9d with current quotient
    jmp Loop_RatioXRatio_HW1   # Jump back to Loop_RatioXRatio_HW1

#######################################################################################
checkSeries_RatioXDiff_HW1:
    movl $0, %r8d            # Initialize loop counter r8d to 0
Loop_RatioXDiff_HW1:
    movl 0(%r14,%rdi,4), %ebx # Load current element of series into %ebx
    cmpl $0, %ebx            # Compare %ebx with 0 (check for zero element)
    je Not_seconddegree_HW1  # Jump to Not_seconddegree_HW1 if zero element found

    addq $1, %r8             #Increment loop counter
    cmp %r8d, %esi           # Compare loop counter with size (esi)
    jne continue3_RatioXDiff_HW1 # Jump to continue3_RatioXDiff_HW1 if not at end of series
    jmp seconddegree_HW1     # Jump to seconddegree_HW1 if end of series reached

continue3_RatioXDiff_HW1:
    movl 0(%r14,%rdi,4), %eax # Load next element of series into %eax
    cmpl $0, %eax            # Compare %eax with 0 (check for zero element)
    je Not_seconddegree_HW1  # Jump to Not_seconddegree_HW1 if zero element found
    cdq                       # Sign-extend %eax into %edx:%eax
    idivl %ebx               # Divide %edx:%eax by %ebx (calculate quotient in %eax, remainder in %edx)
    cmpl $0, %edx            # Compare remainder with 0
    jne Not_seconddegree_HW1  # Jump to Not_seconddegree_HW1 if remainder is not zero

    cmp $1, %rdi             #Compare %rdi with 1 (check if first element)
    je continue1_RatioXDiff_HW1 # Jump to continue1_RatioXDiff_HW1 if first element

    movl %eax, %r10d         # Store quotient in %r10d
    sub %r9d, %r10d          # Subtract previous quotient from current quotient
    movl %eax, %r9d          # Update previous quotient

    cmp $2, %rdi             # Compare %rdi with 2 (check if second element)
    jne continue2_RatioXDiff_HW1 # Jump to continue2_RatioXDiff_HW1 if not second element
    movl %r10d, %r12d        # Store current quotient difference in %r12d
    jmp Loop_RatioXDiff_HW1  # Jump back to Loop_RatioXDiff_HW1

continue2_RatioXDiff_HW1:
    cmp %r10d, %r12d         # Compare current quotient difference with stored value
    je Loop_RatioXDiff_HW1   # Jump back to Loop_RatioXDiff_HW1 if they are equal
    jmp Not_seconddegree_HW1 # Jump to Not_seconddegree_HW1 if they are not equal

continue1_RatioXDiff_HW1:
    movl %eax, %r9d          # Update previous quotient with current quotient
    jmp Loop_RatioXDiff_HW1  # Jump back to Loop_RatioXDiff_HW1

Not_seconddegree_HW1:
    movb $0, seconddegree        # Set seconddegree to 0
    jmp End_HW1                  # Jump to End_HW1

seconddegree_HW1:
    movb $1, seconddegree        # Set seconddegree to 1

End_HW1:
