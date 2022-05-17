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
        movl $0, %eax       # %eax = i = 0
        movl 8(%ebp), %ebx  #%ebx = *mata
        movl 12(%ebp), %esi #%esi = *matb
        movl 16(%ebp), %edi #%edi = n
        
        imul %edi, %edi
_IniciFor:
        cmpl %edi, %eax
        jge _Fi
        movdqu (%ebx), %xmm0   #%xmm0 = mata[i*n+j]
        pandb $1, %xmm0        #%xmm0 = mata[i*n+j] & 1
        movdqu %xmm0, (%esi)
        movdqu inmediat, %xmm1    #xmm1 <- 0
        pcmpgtb %xmm2, %xmm0    #matc[i*n+j] > 0
        movdqu %xmm0, (%ecx)    #matc[i*n+j] = %xmm0
_FiFor:
        addl $16, %eax
        addl $16, %ebx
        addl $16, %esi
        jmp _IniciFor
_Fi:

# El final de la rutina ya esta programado

	emms	# Instruccion necesaria si os equivocais y usais MMX
	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
