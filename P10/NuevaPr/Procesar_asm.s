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
    movb (%ebx), %dl    #%dl = mata[i*n+j]
    andb $1, %dl        #%dl = mata[i*n+j] & 1
    cmpb $0, %dl
    jle _Else
    movb $255, (%esi)   #matb[i*n+j] = 255
    jmp _FiFor
_Else:
    movb $0,(%esi)      #matb[i*n+j] = 0;
_FiFor:
    incl %eax
    incl %ebx
    incl %esi
    jmp _IniciFor
_Fi:


# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
