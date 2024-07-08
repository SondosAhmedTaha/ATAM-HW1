.global _start

.section .text
_start:
#your code here

	#  rax for addresses of nodes, rbx for the current node from the array,
	# rcx counter for the array (0-2), rdx for flags (know the state of the series)
	# for rdx:  0 - equal, 1 - ascending, 2 - descinding, 3 - not monotonic

	#initializations
	movq $0x0, %rdx
	movq $nodes, %rax
	movb $0x0, result
	movq $0x0, %rcx

	#wrapping--------------------------------
check_first_part_HW1:
	#get the prev
	movq (%rax), %rbx
	testq %rbx, %rbx
	jz check_next_part_HW1
	#movq (%rbx), %rsi
	movzbl 8(%rbx), %esi
	jmp check_series_backwards_HW1

check_next_part_HW1:
	#get the value
	movq $0x0, %rdx
	movq (%rax), %rbx
	jmp check_series_onwards_HW1

end_check_HW1:
	cmpq $0x3, %rdx
	je continue_next_in_array_HW1
	incb result

continue_next_in_array_HW1:
	incq %rcx
	cmpq $0x3, %rcx
	je END_4_HW1
	leaq nodes(,%rcx,8), %rax
	movq $0x0, %rdx
	jmp check_first_part_HW1
	
	#--------------------------------------------

	#check monotonic series first part -------
check_series_backwards_HW1:
	#get the int values of the nodes that are going to be compared
	testq %rbx, %rbx
	jz check_next_part_HW1
	movq (%rbx), %rbx		#rbx has address for prev
	testq %rbx, %rbx
	jz check_next_part_HW1
	movl 8(%rbx), %r8d
	movq (%rbx), %r9
	testq %r9, %r9
	jz check_next_part_HW1
	movl 8(%r9), %r9d
	cmpl %r8d, %r9d
	je check_series_backwards_HW1
	jg ascend_backwards_HW1
	jl descend_backwards_HW1


ascend_backwards_HW1:
	cmpq $0x0, %rdx
	je change_to_ascending_series_1_HW1
	cmpq $0x1, %rdx
	je check_series_backwards_HW1
	jmp not_monotonic_HW1

descend_backwards_HW1:
	cmpq $0x0, %rdx
	je change_to_descending_series_1_HW1
	cmpq $0x2, %rdx
	je check_series_backwards_HW1
	jmp not_monotonic_HW1

	#--------------------------------------------


	#check monotonic series next part-------
check_series_onwards_HW1:
	#get the int values of the nodes that are going to be compared
	#value of first node in r8d
	testq %rbx, %rbx
	jz end_check_HW1
	movq 12(%rbx), %rbx
	testq %rbx, %rbx
	jz end_check_HW1
	movl 8(%rbx), %r8d
	movq 12(%rbx), %r9
	testq %r9, %r9
	jz end_check_HW1
	#value of next node in r9d
	movl 8(%r9), %r9d
	cmpl %r8d, %r9d
	je check_series_onwards_HW1
	jg ascend_onwards_HW1
	jl descend_onwards_HW1


ascend_onwards_HW1:
	cmpq $0x0, %rdx
	je change_to_ascending_series_2_HW1
	cmpq $0x1, %rdx
	je check_series_onwards_HW1
	jmp not_monotonic_HW1

descend_onwards_HW1:
	cmpq $0x0, %rdx
	je change_to_descending_series_2_HW1
	cmpq $0x2, %rdx
	je check_series_onwards_HW1
	jmp not_monotonic_HW1

	#--------------------------------------------


	#adjust flags-------------------------------
change_to_ascending_series_1_HW1:
	movq $0x1, %rdx
	jmp check_series_backwards_HW1

change_to_descending_series_1_HW1:
	movq $0x2, %rdx
	jmp check_series_backwards_HW1

change_to_ascending_series_2_HW1:
	movq $0x1, %rdx
	jmp check_series_onwards_HW1

change_to_descending_series_2_HW1:
	movq $0x2, %rdx
	jmp check_series_onwards_HW1

not_monotonic_HW1:
	movq $0x3, %rdx
	jmp end_check_HW1

	#--------------------------------------------




END_4_HW1:
