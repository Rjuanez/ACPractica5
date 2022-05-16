.text
    .align 4
    .globl procesar
    .type    procesar, @function
procesar:
    pushl    %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    pushl    %ebx
    pushl    %esi
    pushl    %edi

# Aqui has de introducir el codigo
    movl $0, %esi        #%esi(=i) = 0
    movl 8(%ebp), %ebx    #%ebx = *mata
    movl 12(%ebp), %edi    #%edi = *matb
    movl 16(%ebp), %ecx    #%ecx = n
    
    imul %eax, %eax        #eax = n²
_For:
    cmpl %esi, %eax        #%i < n²
    jge _FiFor
    movb (%ebx), %dl    #dl = mata[i*n+j]
    andb $1, %dl        #dl = mata[i*n+j]  & 1
    movb %dl, (%edi)    #matb[i*n+j] = %dl
_If:
    cmpb $0, (%edi)
    jle _Else        #matb[i*n+j] <= 0
    movb $255, (%edi)   #matb[i*n+j] = 255
    jmp _Fi
_Else:
    movb $0, (%edi)     #matb[i*n+j] = 0
_Fi:
    incl %esi           #i+=1
    incl %ebx
    incl %edi
    jmp _For

_FiFor:

# El final de la rutina ya esta programado

    popl    %edi
    popl    %esi
    popl    %ebx
    movl %ebp,%esp
    popl %ebp
    ret
    ret
