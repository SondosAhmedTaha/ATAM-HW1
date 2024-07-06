#conditions for num 3 -------
condition_3_HW1:
	#condition1 
	movq $0x8, %rcx
	div %rcx
	cmpq %rdx, %rdx
	jnz Num_4_HW1
	
	#condition 2
	movq $0x0, %rax
loop_3_HW1:
	cmpq %rax, %rdx
	je last_quad_3_HW1
	movq data(,%rax,8), %rbx
	cmpq %rbx, %rbx
	jz Num_4_HW1
	inc %rax
	jmp loop_3_HW1
last_quad_3_HW1:
	movq data(,%rax,8), %rbx
	cmpq %rbx, %rbx
	jz Num_4_HW1
	jnz condition_3_met_HW1
	#------------------------------

condition_3_met_HW1:
	movb $0x3, type
	jmp END_2_HW1


Num_4_HW1:
	movb $0x4, type

END_2_HW1:
