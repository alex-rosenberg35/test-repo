	.file	"asm.s"
	.cstring
STR0:
	.ascii "i = %d %d"
	.text
.globl _main
_main:
	addl  $-16, %esp			# allocate memory on the stack for local variables
	# int i = ((5 + 4) * 2);
	movl  $5, (%esp)
	movl  $4, 4(%esp)
	popl  %ebx
	popl  %edx
	addl  %ebx, %edx			# o1 += o2
	movl  %edx, 8(%esp)
	movl  $2, 12(%esp)
	# while loop
	jmp   L0					# jump to loop entry point
L2:								# loop body
	# compute and push arguments onto the stack
	movl  $5, 16(%esp)
	movl  -4(%ebp), %ecx		# fetch i from the stack
	movl  %ecx, 20(%esp)		# move i to the stack
	movl  $STR0, 24(%esp)		# place pointer to "i = %d" onto the stack
	call  _printf
	addl  $2, -4(%ebp)			# i += 2
L0:								# loop entry-point
	movl  -4(%ebp), %ecx		# fetch i from the stack
	movl  %ecx, 32(%esp)		# move i to the stack
	movl  $20, 36(%esp)
	popl  %edi
	popl  %ecx
	cmp  %edi, %ecx				# i < 20
	jl    L2
	# end of loop
	# release the frame from the top of the stack
	leave
	ret
