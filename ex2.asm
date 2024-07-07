.global _start

.section .text
_start:
#your code here

	#check if size > 0
	movq size, %rax
	testq %rax, %rax
	jz Num_4_HW1
	js Num_4_HW1
	dec %rax


	#conditions for num 1 -------
condition_1_HW1:
	movq $0x0, %rdx
loop_1_HW1:
	movb data(%rdx), %bl
	jmp start_broad_check_1_HW1
back_to_loop_1_HW1:
	inc %rdx
	cmpq %rax, %rdx
	je null_1_HW1
	jmp loop_1_HW1
null_1_HW1:
	movb data(%rdx), %bl
	cmpq $0x0, %rdx
	jz condition_1_met_HW1
	jnz condition_2_HW1
	#------------------------------

	#------------------------------
	#begin check for ASCII - condition 1
start_broad_check_1_HW1:

	#if ! or space
spaces_execl_1_HW1:
	cmpb $0x20, %bl
	jl condition_2_HW1
	cmpb $0x21, %bl
	jg numbers_dots_commas_1_HW1
	jmp end_check_1_HW1

	#if number or . or , (exceptions / -)
numbers_dots_commas_1_HW1:
	cmpb $0x2C, %bl
	jl condition_2_HW1
	cmpb $0x39, %bl
	jg capital_letters_quas_1_HW1
	cmpb $0x2D, %bl
	je condition_2_HW1
	cmpb $0x2F, %bl
	je condition_2_HW1
	jmp end_check_1_HW1

	#if capital letter or ? (exception  @)
capital_letters_quas_1_HW1:
	cmpb $0x3F, %bl
	jl condition_2_HW1
	cmpb $0x5A, %bl
	jg small_letters_1_HW1
	cmpb $0x40, %bl
	je condition_2_HW1
	jmp end_check_1_HW1

	#if small letter
small_letters_1_HW1:
	cmpb $0x61, %bl
	jl condition_2_HW1
	cmpb $0x7A, %bl
	jg condition_2_HW1
	jmp end_check_1_HW1

	#end check, back to loop
end_check_1_HW1:
	jmp back_to_loop_1_HW1
	#------------------------------

condition_1_met_HW1:
	movb $0x1, type
	jmp END_2_HW1



	#conditions for num 2 -------
condition_2_HW1:
	movq $0x0, %rdx
loop_2_HW1:
	movb data(%rdx), %bl
	cmpb $0x20, %bl
	jl condition_3_HW1
	cmpb $0x7E, %bl
	jg condition_3_HW1
	inc %rdx
	cmpq %rax, %rdx
	je null_2_HW1
	jmp loop_2_HW1
null_2_HW1:
	movb data(%rdx), %bl
	cmpq $0x0, %rdx
	jz condition_2_met_HW1
	jnz condition_3_HW1
	#------------------------------

condition_2_met_HW1:
	movb $0x2, type
	jmp END_2_HW1



	#conditions for num 3 -------
condition_3_HW1:
	#condition1
	inc %rax
	movq $0x0, %rdx
	movq $0x8, %rcx
	div %rcx
	cmpq $0x0, %rdx
	jnz Num_4_HW1
	
	#condition 2
	movq $0x0, %rdx
loop_3_HW1:
	cmpq %rax, %rdx
	je last_quad_3_HW1
	movq data(,%rax,8), %rbx
	cmpq $0x0, %rbx
	je Num_4_HW1
	inc %rdx
	jmp loop_3_HW1
last_quad_3_HW1:
	movq data(,%rax,8), %rbx
	cmpq $0x0, %rbx
	je Num_4_HW1
	jnz condition_3_met_HW1
	#------------------------------

condition_3_met_HW1:
	movb $0x3, type
	jmp END_2_HW1


Num_4_HW1:
	movb $0x4, type

END_2_HW1:
