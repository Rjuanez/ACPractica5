.data
    inmediat: .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    inmediat2: .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
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
        movl $0, %eax       # %eax = i = 0
        movl 8(%ebp), %ebx  #%ebx = *mata
        movl 12(%ebp), %esi #%esi = *matb
        movl 16(%ebp), %edi #%edi = n
        
        imul %edi, %edi

        test %ebx, $0x0000000F
        jnz _IniciForNoAl

        test %esi, $0x0000000F
        jnz _IniciForNoAl


IniciForAl:
        cmpl %edi, %eax
        jge _Fi
        movdqa (%ebx), %xmm0   #%xmm0 = mata[i*n+j]
        movdqa inmediat2, %xmm1    #xmm1 <- 0
        pand %xmm1, %xmm0        #%xmm0 = mata[i*n+j] & 1
        movdqa %xmm0, (%esi)
        movdqa inmediat, %xmm1
        pcmpgtb %xmm1, %xmm0
        movdqa %xmm0, (%esi)
_FiFor:
        addl $16, %eax
        addl $16, %ebx
        addl $16, %esi
        jmp _IniciForAl

_IniciForNoAl:
        cmpl %edi, %eax
        jge _Fi
        movdqu (%ebx), %xmm0   #%xmm0 = mata[i*n+j]
        movdqu inmediat2, %xmm1    #xmm1 <- 0
        pand %xmm1, %xmm0        #%xmm0 = mata[i*n+j] & 1
        movdqu %xmm0, (%esi)
        movdqu inmediat, %xmm1
        pcmpgtb %xmm1, %xmm0
        movdqu %xmm0, (%esi)
_FiFor:
        addl $16, %eax
        addl $16, %ebx
        addl $16, %esi
        jmp _IniciForNoAl
_Fi:

# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
