.global _start
.section .text
_start:

	#getting and checkning the size
    movl size, %eax         # Load size of the series into %eax (32-bit)
    cmp $3, %eax            # Compare size with 2
    jl seconddegree_HW1     # Jump to end_HW1 if size < 2 (i.e., size <= 1)

	#getting and checking the beginning of the original series
    mov $series, %r14       # Load address of series into %r14
    testq %r14, %r14        # Test if series address is zero
    je Not_seconddegree_HW1 # Jump to Not_seconddegree_HW1 if series address is zero

	#i for loop
    movq $0, %r8            # Set loop counter i = 0



	# case 1: series of diffrences is an arithmethic series

checkSeries_DiffX2_HW1:
	#getting next two values to be compared, the sub result in edx
    movl (%r14,%r8,4), %ebx      # Load current element of series into %ebx
    addl $1, %r8d                 # Increment loop counter
    cmpl %r8d, %eax               # Compare loop counter with size
    je seconddegree_HW1           # Jump to seconddegree_HW1 if equal
    movl (%r14,%r8,4), %edx      # Load next element of series into %edx
    subl %ebx, %edx               # Calculate difference between current and next elements
	
	#if it is the first element (no prev diff)
    cmp $0x1, %r8d                # Compare %rdi with 1
    je continue1_DiffX2_HW1       # Jump to continue1_DiffX2_HW1 if equal

	#calc the diff of diff's
    movl %edx, %r10d              # Store current difference in %r10d
    subl %r9d, %r10d              # Calculate difference of differences
    movl %edx, %r9d               # Update previous difference

	#if we dont have yet prev diff of diff's we need to set the one to be compared
    cmp $0x2, %r8d                # Compare %rdi with 2
    jne continue2_DiffX2_HW1      # Jump to continue2_DiffX2_HW1 if not equal
    movl %r10d, %r12d             # Store current difference of differences in %r12d
    jmp checkSeries_DiffX2_HW1

continue2_DiffX2_HW1:
    cmp %r10d, %r12d              # Compare current difference of differences with stored value
    jne checkSeries_DiffXRatio_HW1   # Jump to checkSeries_DiffXRatio_HW1 if not equal
    jmp checkSeries_DiffX2_HW1    # Jump back to checkSeries_DiffX2_HW1

continue1_DiffX2_HW1:
    movl %edx, %r9d               # Update previous difference with current difference
    jmp checkSeries_DiffX2_HW1    # Jump back to checkSeries_DiffX2_HW1

#######################################################################################

	# case 2: series of diffrences is a geometric series

	#initialzations
checkSeries_DiffXRatio_HW1:
    movl $0, %r8d                 # Initialize loop counter to 0
    movl size, %esi               # Load size of the series into %esi

	#get the values of the elements in the array
Loop_DiffXRatio_HW1:
    movl (%r14,%r8,4), %ebx      # Load current element of series into %ebx
    addl $1, %r8d                 # Increment loop counter
    cmp %r8d , %esi               # Compare loop counter with size
    je seconddegree_HW1           # Jump if not equal, continue loop
    movl (%r14,%r8,4), %ecx      # Load next element of series into %edx
    subl %ebx ,%ecx               # Calculate difference between current and next elements

	#first two elements, we have only one diff at hand
    cmp $0x1, %r8d                # Compare %rdi with 1
    je continue1_DiffXRatio_HW1   # Jump if not equal, continue to handle first element case

	#dont devide by 0
    testl %ecx, %ecx               # Test if %edx (difference) is zero
    je checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if zero

	#calc the devision
    movl %ecx, %eax               # Move %edx (difference) to %eax (for division)
    cdq                           # Sign extend %eax into %edx
    idivl %r9d                    # Divide %eax by %r9d (quotient in %eax, remainder in %edx)
    movl %ecx, %r9d               # Update %r9d with current difference

	#if this is the first quotient calculated, save it
    cmp $0x2, %r8d                # Compare %rdi with 2
    jne continue2_DiffXRatio_HW1  # Jump if not equal, continue loop
    movl %eax, %r12d              # Move quotient to %r12d (for comparison)
    jmp Loop_DiffXRatio_HW1       # Jump back to Loop_DiffXRatio_HW1

continue2_DiffXRatio_HW1:
    cmp %eax, %r12d               # Compare quotient with stored value in %r12d
    je Loop_DiffXRatio_HW1        # Jump back to Loop_DiffXRatio_HW1 if equal
    jmp checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if not equal

continue1_DiffXRatio_HW1:
    testl %ecx, %ecx              # Test if %edx (difference) is zero
    je checkSeries_RatioXRatio_HW1 # Jump to checkSeries_RatioXRatio_HW1 if zero
    movl %ecx, %r9d               # Update %r9d with current difference
    jmp Loop_DiffXRatio_HW1       # Jump back to Loop_DiffXRatio_HW1

#######################################################################################

	# case 3: series of quotients is a geometric series

checkSeries_RatioXRatio_HW1:
    movl $0, %r8d                 # Initialize loop counter r8d to 0

	#get the next two elements, first should not be 0
Loop_RatioXRatio_HW1:
    movl (%r14,%r8,4), %ebx      # Load current element of the series into ebx
    cmpl $0, %ebx                 # Compare ebx to 0
    je checkSeries_RatioXDiff_HW1 # If ebx is 0, jump to checkSeries_RatioXDiff_HW1

    addl $1, %r8d                 # Increment loop counter r8
    cmp %r8d, %esi                # Compare loop counter r8d with size esi
    je seconddegree_HW1           # If equal, jump to seconddegree_HW1

    movl (%r14,%r8,4), %eax      # Load next element of the series into eax
    cmpl $0, %eax                 # Compare eax to 0
    je checkSeries_RatioXDiff_HW1 # If eax is 0, jump to checkSeries_RatioXDiff_HW1

	#calculate
    cdq                           # Sign-extend eax into edx:eax
    idivl %ebx                    # Divide edx:eax by ebx; eax gets the quotient, edx gets the remainder
    cmpl $0, %edx                 # Compare remainder edx to 0
    jne checkSeries_RatioXDiff_HW1 # If not equal (i.e., there is a remainder), jump to checkSeries_RatioXDiff_HW1

    cmp $1, %r8d                  # Compare rdi to 1
    je continue1_RatioXRatio_HW1  # If equal, jump to continue1_RatioXRatio_HW1

    movl %eax, %r10d              # Store quotient in r10d
    cdq                           # Sign-extend eax into edx:eax
    idivl %r9d                    # Divide edx:eax by r9d; eax gets the quotient, edx gets the remainder
    cmpl $0, %edx                 # Compare remainder edx to 0
    jne checkSeries_RatioXDiff_HW1 # If not equal (i.e., there is a remainder), jump to checkSeries_RatioXDiff_HW1
    movl %r10d, %r9d              # Update r9d with the quotient

    cmp $2, %r8d                  # Compare rdi to 2
    jne continue2_RatioXRatio_HW1 # If not equal, jump to continue2_RatioXRatio_HW1
    movl %eax, %r12d              # Store quotient in r12d
    jmp Loop_RatioXRatio_HW1      # Jump back to Loop_RatioXRatio_HW1

continue2_RatioXRatio_HW1:
    cmp %eax, %r12d               # Compare current quotient to stored quotient
    je Loop_RatioXRatio_HW1       # If equal, jump back to Loop_RatioXRatio_HW1
    jmp checkSeries_RatioXDiff_HW1 # Otherwise, jump to checkSeries_RatioXDiff_HW1

continue1_RatioXRatio_HW1:
    movl %eax, %r9d               # Update r9d with current quotient
    jmp Loop_RatioXRatio_HW1      # Jump back to Loop_RatioXRatio_HW1

#######################################################################################

	# case 3: series of quotients is an arithmetic series

checkSeries_RatioXDiff_HW1:
    movl $0, %r8d                # Initialize loop counter r8d to 0

	#get the next two elements, not 0
Loop_RatioXDiff_HW1:
    movl (%r14,%r8,4), %ebx     # Load current element of series into %ebx
    cmpl $0, %ebx                # Compare %ebx with 0 (check for zero element)
    je Not_seconddegree_HW1      # Jump to Not_seconddegree_HW1 if zero element found

    addl $1, %r8d                #Increment loop counter
    cmp %r8d, %esi               # Compare loop counter with size (esi)
    je seconddegree_HW1          # Jump to seconddegree_HW1 if end of series reached

    movl (%r14,%r8,4), %eax     # Load next element of series into %eax
    cmpl $0, %eax                # Compare %eax with 0 (check for zero element)
    je Not_seconddegree_HW1      # Jump to Not_seconddegree_HW1 if zero element found

	#calculate
    cdq                          # Sign-extend %eax into %edx:%eax
    idivl %ebx                   # Divide %edx:%eax by %ebx (calculate quotient in %eax, remainder in %edx)
    cmpl $0, %edx                # Compare remainder with 0
    jne Not_seconddegree_HW1     # Jump to Not_seconddegree_HW1 if remainder is not zero

	#if it is the first devision
    cmpl $1, %r8d                #Compare %rdi with 1 (check if first element)
    je continue1_RatioXDiff_HW1  # Jump to continue1_RatioXDiff_HW1 if first element

    movl %eax, %r10d             # Store quotient in %r10d
    sub %r9d, %r10d              # Subtract previous quotient from current quotient
    movl %eax, %r9d              # Update previous quotient

    cmp $2, %r8d                 # Compare %rdi with 2 (check if second element)
    jne continue2_RatioXDiff_HW1 # Jump to continue2_RatioXDiff_HW1 if not second element
    movl %r10d, %r12d            # Store current quotient difference in %r12d
    jmp Loop_RatioXDiff_HW1      # Jump back to Loop_RatioXDiff_HW1

continue2_RatioXDiff_HW1:
    cmp %r10d, %r12d             # Compare current quotient difference with stored value
    je Loop_RatioXDiff_HW1       # Jump back to Loop_RatioXDiff_HW1 if they are equal
    jmp Not_seconddegree_HW1     # Jump to Not_seconddegree_HW1 if they are not equal

continue1_RatioXDiff_HW1:
    movl %eax, %r9d              # Update previous quotient with current quotient
    jmp Loop_RatioXDiff_HW1      # Jump back to Loop_RatioXDiff_HW1



	#update the seconddegree label, and finish

Not_seconddegree_HW1:
    movb $0, seconddegree        # Set seconddegree to 0
    jmp End_5_HW1                  # Jump to End_HW1

seconddegree_HW1:
    movb $1, seconddegree        # Set seconddegree to 1

End_5_HW1:
