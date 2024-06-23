.global _start

.section .text
_start:
	test length, length
	js Not_Legal_HW1
	test Index, Index
	js Not_Legal_HW1

	movq length, %rbx   
	shrq $32, %rbx        
	test %ebx, %ebx      
	jne Not_Legal_HW1   
  
	movq Index, %rbx   
	shrq $32, %rbx        
	test %ebx, %ebx      
	jne Not_Legal_HW1   
	
	cmpq Index, length
	jae Not_Legal_HW1

	movq Adress, %rbx
	movl Index, %ecx
	movl (%rbx,%ecx,4), %eax  
	movl %eax, num
	mov Legal,#1
	jmp End_HW1

Not_Legal_HW1:
		mov Legal,#0

End_HW1:	


