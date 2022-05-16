.data
	inmediat: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.text
	.align 4
	.globl procesar
	.type	procesar, @function
procesar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi

# Aqui has de introducir el codigo

	movl $0, %esi		#%esi(=i) = 0
	movl 8(%ebp), %ebx	#%ebx = *mata
	movl 12(%ebp), %edi	#%edi = *matb
	movl 16(%ebp), %ecx	#%ecx = *matc
	movl 20(%ebp), %eax	#%eax = n

	imul %eax, %eax		#eax = n²
_IniFor:
	cmpl %eax, %esi		#i < n²
	jge _FiFor		#i >= n²
	movdqu (%ebx), %xmm0	#%xmm0 = mata[i*n+j]
	movdqu (%edi), %xmm1	#%xmm1 = matb[i*n+j]
	psubb %xmm1, %xmm0	#%xmm0 = mata[i*n+j] - %xmm1 
	movdqu %xmm0, (%ecx)	#matc[i*n+j] = %xmm0	
	movdqu inmediat, %xmm2	#xmm2 <- 0 		
_IfiElse:
	pcmpgtb %xmm2, %xmm0	#matc[i*n+j] > 0
	movdqu %xmm0, (%ecx)	#matc[i*n+j] = %xmm0
_Fi:
	addl $16, %esi		#i+=16
	addl $16, %ebx		#nem següent element		
	addl $16, %edi		
	addl $16, %ecx	
	jmp _IniFor
# El final de la rutina ya esta programado
_FiFor:
	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
