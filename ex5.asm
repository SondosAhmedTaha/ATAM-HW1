.global _start
.section .text
_start:

  movl size, %ecx         # Load size of the series into %ecx (32-bit)
  testl %ecx, %ecx
  jz Not_seconddegree_HW1 
  js Not_seconddegree_HW1
  movq %rcx, %rbx         # Move %rcx to %rbx (64-bit), size is already in %ecx
  
  movq series(%rip), %rdi # Load address of series into %rdi
  testq %rdi, %rdi 
  je Not_seconddegree_HW1
  movl (%rdi), %eax       # Load first element of series into %eax (32-bit)
  
  movq %rax, %rbx         # Move %rax to %rbx (64-bit), first element in %eax
  shrq $32, %rbx          # Shift %rbx right by 32 bits
  
  movl 4(%rdi), %ebx      # Load second element of series into %ebx (32-bit)
  
  movq %rbx, %rdx         # Move %rbx to %rdx (64-bit)
  shrq $32, %rdx          # Shift %rdx right by 32 bits
  
  subl %ebx, %eax         # Subtract %ebx from %eax
  
  movl $1, %esi           # flag_arithmetic = 1
  movl $1, %edi           # flag_geometric = 1
  movl $1, %r8d           # Set loop counter i = 1
  movl %eax, %r9d         # Initialize previous_diff with first difference

checkSeries_Diff_HW1:
    cmpl %ecx, %r8d
    jge end_checkSeries_Diff_HW1

    movl (%rdi, %r8d, 4), %edx   # Load series[i] into %edx
    movl -4(%rdi, %r8d, 4), %ebx # Load series[i-1] into %ebx
    subl %ebx, %edx              # Calculate current_diff = series[i] - series[i-1]

    cmpl %r9d, %edx
    jne not_arithmeticDiff_HW1

    movl %ebx, %eax              # Load series[i-1] into %eax for geometric check
    testl %eax, %eax
    je skip_geometriCheckDiff_HW1

    movl (%rdi, %r8d, 4), %ebx   # Load series[i] into %ebx for geometric check
    cdq                           # Sign extend %eax to %edx:%eax for division
    idivl %ebx                    # Divide %edx:%eax by %ebx
    cmpl %ebx, %eax
    jne not_geometricDiff_HW1
    jmp continueCheck_Diff_HW1

not_arithmeticDiff_HW1:
    movl $0, %esi           # flag_arithmetic = 0

skip_geometriCheckDiff_HW1:
    jmp continueCheck_Diff_HW1

not_geometricDiff_HW1:
    movl $0, %edi           # flag_geometric = 0

continueCheck_Diff_HW1:
    addl $1, %r8d           # Increment loop counter
    movl %edx, %r9d         # previous_diff = current_diff
    cmpl %ecx, %r8d
    jl checkSeries_Diff_HW1

end_checkSeries_Diff_HW1:
    # Final check to decide the output based on flags
    testl %esi, %esi        # Check if flag_arithmetic is set
    jnz seconddegree_HW1

    testl %edi, %edi        # Check if flag_geometric is set
    jnz seconddegree_HW1

### CHECK IF The series of portions between its successive members are in themselves an arithmetic series or an geometric series

    movl size, %ecx        # Load size of the series into %ecx
    testl %ecx, %ecx       # Check if size is zero
    jz Not_seconddegree_HW1  # Jump to Not_seconddegree_HW1 if size is zero
    js Not_seconddegree_HW1  # Jump to Not_seconddegree_HW1 if size is negative

    movq series(%rip), %rdi  # Load address of series into %rdi
    testq %rdi, %rdi          # Check if series address is zero
    je Not_seconddegree_HW1   # Jump to Not_seconddegree_HW1 if series address is zero

    movl (%rdi), %eax         # Load first element of series into %eax
    cdq                        # Sign extend %eax to %edx:%eax for division

    movl $1, %esi             # flag_arithmetic = 1
    movl $1, %edi             # flag_geometric = 1
    movl $1, %r8d             # Set loop counter i = 1
    movl (%rdi), %eax         # Load the first element of the series into %eax
    cdq                       # Sign extend %eax to %edx:%eax for division

checkSeries_Ratio_HW1:
    cmpl %ecx, %r8d           # Compare loop counter with size
    jge end_checkSeries_Ratio_HW1  # Exit loop if i >= size

    movl (%rdi, %r8d, 4), %ebx   # Load series[i] into %ebx
    idivl %ebx                   # Divide %edx:%eax by %ebx to get the ratio
    movl %eax, %edx              # Save the ratio in %edx
    movl (%rdi, %r8d, 4), %eax   # Load series[i] into %eax for the next iteration

    testl %r8d, %r8d            # Check if i is zero (for arithmetic series)
    jz skip_arithmeticRatioCheck_HW1

    cmpl %edx, %r9d              # Compare current ratio with previous ratio
    jne not_arithmeticRatio_HW1

skip_arithmeticRatioCheck_HW1:
    jmp continueCheck_Ratio_HW1

not_arithmeticRatio_HW1:
    movl $0, %esi                # flag_arithmetic = 0

    movl (%rdi, %r8d, 4), %ebx   # Load series[i] into %ebx for geometric check
    testl %ebx, %ebx
    je skip_geometricRatioCheck_HW1

    cdq                           # Sign extend %eax to %edx:%eax for division
    idivl %edx                    # Divide %ebx by %edx to get the ratio of ratios
    cmpl %eax, %ebx
    jne not_geometricRatio_HW1
    jmp continueCheck_Ratio_HW1

skip_geometricRatioCheck_HW1:
    jmp continueCheck_Ratio_HW1

not_geometricRatio_HW1:
    movl $0, %edi                # flag_geometric = 0

continueCheck_Ratio_HW1:
    addl $1, %r8d                # Increment loop counter
    movl %edx, %r9d              # Save current ratio as previous ratio
    jmp checkSeries_Ratio_HW1    # Repeat loop for next element

end_checkSeries_Ratio_HW1:
    # Final check to decide the output based on flags
    testl %esi, %esi        # Check if flag_arithmetic is set
    jnz seconddegree_HW1    # Jump to seconddegree_HW1 if arithmetic flag is set

    testl %edi, %edi        # Check if flag_geometric is set
    jnz seconddegree_HW1    # Jump to seconddegree_HW1 if geometric flag is set

Not_seconddegree_HW1:
  movb $0, seconddegree

seconddegree_HW1:
  movb $1, seconddegree

End_HW1:
