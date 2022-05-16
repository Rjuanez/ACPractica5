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
movl $0, %esi        #%esi(=i) = 0
    movl 8(%ebp), %ebx    #%ebx = *mata
    movl 12(%ebp), %edi    #%edi = *matb
    movl 16(%ebp), %ecx    #%ecx = n
    
    imul %eax, %eax        #eax = n²
_IniFor:
    cmpl %eax, %esi        #%i < n² -> en un únic bucle
    jge _FiFor        #saltem quan i >= n²
    movb (%ebx), %dl    #dl = mata[i*n+j] <- volem part baixa
    andb $1, %dl    #dl = mata[i*n+j]  & 1
    movb %dl, (%edi)    #matb[i*n+j] = %dl <- tractem amb chars
_IniIf:
    cmpb $0, (%edi)        #matb[i*n+j] > 0
    jle _IniElse        #saltem quan matc[i*n+j] <= 0
    movb $0, (%edi)    #matb[i*n+j] = FF
    jmp _Fi
_IniElse:
    movb $255, (%edi)        #matb[i*n+j] = 0
_Fi:
    incl %esi        #i+=1
    incl %ebx        #nem al següent element amb chars i seq
    incl %edi
    jmp _IniFor

_FiFor:

# El final de la rutina ya esta programado

	popl	%edi
	popl	%esi
	popl	%ebx
	movl %ebp,%esp
	popl %ebp
	ret
