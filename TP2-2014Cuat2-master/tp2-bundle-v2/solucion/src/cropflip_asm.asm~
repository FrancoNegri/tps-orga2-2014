global cropflip_asm

section .rodata

msgsys: db "RDI vale :", 0


section .text
;void tiles_asm(unsigned char *src,
;              unsigned char *dst,
;		int cols, rows
;              int src_row_size,
;              int dst_row_size,
;		int tamx, int tamy,
;		int offsetx, int offsety);

; 1 cols -> 4 


%define src rdi
%define dst rsi
%define cols edx
%define rows ecx
%define dst_row_size r9d
%define src_row_size r8d
%define tamx r12
%define tamy r13
%define offsetx r14
%define offsety r15

cropflip_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    
    xor r12, r12
    xor r13, r13
    xor r14, r14
    xor r15, r15
    mov dword r12d, [rbp + 16]
    mov dword r13d, [rbp + 24]
    mov dword r14d, [rbp + 32]
    mov dword r15d, [rbp + 40]

    mov rax, offsety
    add rax, tamy
    dec rax
    mul src_row_size
    add rax, src
    dec offsetx
    lea src, [rax + offsetx*4] ;offsetx

    xor rax, rax
    mov eax, dst_row_size
    add eax, src_row_size
    
    dec tamx

    xor r10, r10
    xor r11, r11



    .loop:

    movdqu xmm0, [src]
    movdqu [dst], xmm0
    add src, 16
    add dst, 16
    add r11, 4
    cmp r11, tamx
    jl .loop
    xor r11, r11
    sub src, rax ;LE RESTO
    inc r10
    cmp r10, tamy
    jl .loop

	

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
