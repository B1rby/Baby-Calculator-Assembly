BITS 64

section .data
    operator1: db "+"
    operator2: db "/"
    operator3: db "*"
    operator4: db "-"

    msg1 db "What type of operation do you want to do ? ", 10, 0
    msg1_len equ $-msg1

    addition db "type + : addition", 10, 0
    addition_len equ $-addition

    substract db "type - : substraction", 10, 0
    substract_len equ $-substract

    multiplication db "type *: multiplication", 10, 0
    multiplication_len equ $-multiplication 

    division db "type / : division", 10, 0
    division_len equ $-division 


    msg2 db "Choose your first number", 10, 0
    msg2_len equ $-msg2

    msg3 db "Choose your second number",10, 0
    msg3_len equ $-msg3

    msg4 db "The result is: ", 0
    msg4_len equ $-msg4

    msg5 db "The remainder is: ", 0
    msg5_len equ $-msg5

section .bss
    operationtype resb 1
    firstnumber resb 2
    secondnumber resb 2
    result resb 1

section .text

global _start
_start:

    call _chooseoperator
    call _getoperator

    call _choosefirstnumber
    call _getnumber1

    call _choosesecondnumber
    call _getnumber2

    call _useroperator
    call _exit 

_chooseoperator:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, msg1_len
    syscall 

    mov rax, 1
    mov rdi, 1
    mov rsi, addition 
    mov rdx, addition_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, substract
    mov rdx, substract_len
    syscall 

    mov rax, 1
    mov rdi, 1
    mov rsi, multiplication
    mov rdx, multiplication_len
    syscall 

    mov rax, 1
    mov rdi, 1
    mov rsi, division
    mov rdx, division_len
    syscall 
    ret

_getoperator:
    mov rax, 0
    mov rdi, 0
    mov rsi, operationtype
    mov rdx, 1
    syscall 
    ret 

_choosefirstnumber:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2_len
    syscall 
    
_getnumber1:
    mov rax, 0
    mov rdi, 0
    mov rsi, firstnumber
    mov rdx, 2
    syscall 
    ret 

_choosesecondnumber:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg3
    mov rdx, msg3_len
    syscall
    
_getnumber2:
    mov rax, 0
    mov rdi, 0
    mov rsi, secondnumber
    mov rdx, 2
    syscall 

_useroperator:
    mov rsi, operator1
    mov rdi, operationtype
    mov ecx, 1
    repe cmpsb
    je _calculator
 
_useroperator1:
    xor rsi, rsi 
    xor rdi, rdi 
    mov rsi, operator2
    mov rdi, operationtype
    mov ecx, 1
    repe cmpsb
    je _calculator1    

_useroperator2:
    xor rsi, rsi 
    xor rdi, rdi 
    mov rsi, operator3
    mov rdi, operationtype
    mov ecx, 1
    repe cmpsb
    je _calculator2
_useroperator3:
    xor rsi, rsi 
    xor rdi, rdi 
    mov rsi, operator4
    mov rdi, operationtype
    mov ecx, 1
    repe cmpsb
    je _calculator3 

_calculator:
    xor rax, rax
    mov rax, [firstnumber]
    sub rax, '0'

    xor rbx, rbx
    mov rbx, [secondnumber]
    sub rbx, '0'

    add rax, rbx
    add rax, '0'
    mov [result], rax 
    jmp _print 


_calculator1:
_are_they_same_numbers:
    mov al, [firstnumber]
    mov bl, [secondnumber]

    cmp al, bl
    je _resultequal1
    jne _division
_resultequal1:
    mov rax, 1
    add rax, '0'
    mov [result], rax  
    jmp _print      
_division:
    xor rax, rax 
    mov rax, [firstnumber]
    sub rax, '0'

    xor rbx, rbx
    mov rbx, [secondnumber]
    sub rbx, '0'

    div rbx 
    add rbx, '0'
    mov [result], rbx 
    jmp _printdivision


_calculator2:
    xor rax, rax
    mov rax, [firstnumber]
    sub rax, '0'

    xor rbx, rbx
    mov rbx, [secondnumber]
    sub rbx, '0'

    imul rax, rbx
    add rax, '0'
    mov [result], rax 
    jmp _print 

_calculator3:
    xor rax, rax
    mov rax, [firstnumber]
    sub rax, '0'

    xor rbx, rbx
    mov rbx, [secondnumber]
    sub rbx, '0'

    sub rax, rbx
    add rax, '0'
    mov [result], rax 
    jmp _print 

_print:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg4
    mov rdx, msg4_len
    syscall 

    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 1
    syscall 
    jmp _exit 
_printdivision:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg5
    mov rdx, msg5_len
    syscall 

    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 1
    syscall 

_exit:
    mov rax, 0x3c
    xor rdi, rdi
    syscall 