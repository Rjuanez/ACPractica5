.data
	.align 16
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

	test %ebx, $15
	jnz _NoAlineat

	test %edi, $15
	jnz _NoAlineat

 	test %ecx, $15
	jnz _NoAlineat

####-------------Si és múltiple de 16-------------####
_Alineat:

_IniForA:
	cmpl %eax, %esi		#i < n²
	jge _FiFor		#i >= n²
	movdqa (%ebx), %xmm0	#%xmm0 = mata[i*n+j]
	movdqa (%edi), %xmm1	#%xmm1 = matb[i*n+j]
	psubb %xmm1, %xmm0	#%xmm0 = mata[i*n+j] - %xmm1 
	movdqq %xmm0, (%ecx)	#matc[i*n+j] = %xmm0	
	movdqq inmediat, %xmm2	#xmm2 <- 0 		
_IfiElseA:
	pcmpgtb %xmm2, %xmm0	#matc[i*n+j] > 0
	movdqq %xmm0, (%ecx)	#matc[i*n+j] = %xmm0
_FiA:
	addl $16, %esi		#i+=16
	addl $16, %ebx		#nem següent element		
	addl $16, %edi		
	addl $16, %ecx	
	jmp _IniForA

####-------------Si no és múltiple de 16-------------####
_NoAlineat:

_IniForNA:
	cmpl %eax, %esi		#i < n²
	jge _FiFor		#i >= n²
	movdqu (%ebx), %xmm0	#%xmm0 = mata[i*n+j]
	movdqu (%edi), %xmm1	#%xmm1 = matb[i*n+j]
	psubb %xmm1, %xmm0	#%xmm0 = mata[i*n+j] - %xmm1 
	movdqu %xmm0, (%ecx)	#matc[i*n+j] = %xmm0	
	movdqu inmediat, %xmm2	#xmm2 <- 0 		
_IfiElseNA:
	pcmpgtb %xmm2, %xmm0	#matc[i*n+j] > 0
	movdqu %xmm0, (%ecx)	#matc[i*n+j] = %xmm0
_FiNA:
	addl $16, %esi		#i+=16
	addl $16, %ebx		#nem següent element		
	addl $16, %edi		
	addl $16, %ecx	
	jmp _IniForNA

# El final de la rutina ya esta programado
_FiFor:
	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
