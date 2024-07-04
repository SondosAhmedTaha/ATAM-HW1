.global _start

.section .text
_start:
#your code here

	#check if size > 0
	movq size %rax
	testq %rax %rax
	jz Num_4_HW1
	js Num_4_HW1


	#conditions for num 1 -------
condition_1_HW1:
	movq 0x0 %rdx
loop_1_HW1:
	movb (data,%rdx, 1) %rbx
	jmp start_broad_check_1_HW1
back_to_loop_1_HW1:
	inc %rdx
	testq %rax %rdx
	je null_1_HW1:
	jmp loop_1_HW1
null_1_HW1:
	movb (data,%rdx, 1) %rbx
	testb %rdx %rdx
	jz condition_1_met_HW1
	jnz condition_2_HW1
	#------------------------------

	#------------------------------
	#begin check for ASCII - condition 1
start_broad_check_1_HW1:

	#if ! or space
spaces_!_1_HW1:
	sub 0x20 %rbx
	js condition_2_HW1
	sub %rbx 0x21
	js numbers_dots_commas_1_HW1
	jmp end_check_1_HW1

	#if number or . or , (exceptions / -)
numbers_dots_commas_1_HW1:
	sub 0x2C %rbx
	js condition_2_HW1
	sub %rbx 0x39
	js capital_letters_?_1_HW1
	sub 0x2D %rbx
	jz condition_2_HW1
	sub 0x2F %rbx
	jz condition_2_HW1
	jmp end_check_1_HW1

	#if capital letter or ? (exception  @)
capital_letters_?_1_HW1:
	sub 0x3F %rbx
	js condition_2_HW1
	sub %rbx 0x5A
	js small_letters_1_HW1
	sub 0x40 %rbx
	jz condition_2_HW1
	jmp end_check_1_HW1

	#if small letter
small_letters_1_HW1:
	sub 0x61 %rbx
	js condition_2_HW1
	sub %rbx 0x7A
	js condition_2_HW1
	jmp end_check_1_HW1

	#end check, back to loop
end_check_1_HW1:
	jmp back_to_loop_1_HW1
	#------------------------------

condition_1_met_HW1:
	movb $0x1 type
	jmp END_2_HW1



	#conditions for num 2 -------
condition_2_HW1:
	movq 0x0 %rdx
loop_3_HW1:
	movb (data,%rdx, 1) %rbx
	sub 0x20 %rbx
	js condition_3_HW1
	sub %rbx 0x7E
	js condition_3_HW1
	inc %rdx
	testq %rax %rdx
	je null_2_HW1:
	jmp loop_3_HW1
null_2_HW1:
	movb (data,%rdx, 1) %rbx
	testb %rdx %rdx
	jz condition_2_met_HW1
	jnz condition_3_HW1
	#------------------------------

condition_2_met_HW1:
	movb $0x2 type
	jmp END_2_HW1



	#conditions for num 3 -------
condition_3_HW1:
	#condition1 
	movq $0x8 %rcx
	div %rcx
	testb %rdx %rdx
	jnz Num_4_HW1
	
	#condition 2
	movq 0x0 %rax
loop_3_HW1:
	test %rax %rdx
	je last_quad_3_HW1
	movq (data,%rax, 8) %rbx
	testq %rbx %rbx
	jz Num_4_HW1
	inc %rax
	jmp loop_3_HW1
last_quad_3_HW1:
	movq (data,%rax, 8) %rbx
	testq %rbx %rbx
	jz Num_4_HW1
	jnz condition_3_met_HW1
	#------------------------------

condition_3_met_HW1:
	movb $0x3 type
	jmp END_2_HW1


Num_4_HW1:
	movb $0x4 type

END_2_HW1:
