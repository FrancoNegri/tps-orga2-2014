global sierpinski_asm

section .data

indiceColumna: dd 0x0000,0x0001,0x0002,0x0003
constante: dd 255.0 , 255.0, 255.0, 255.0   

section .text

;void sierpinski_asm (unsigned char *src,
;                     unsigned char *dst,
;                     int cols, int rows,
;                     int src_row_size,
;                     int dst_row_size)


%define src rdi
%define dst rsi
%define cols edx
%define rows ecx
%define dst_row_size r9d
%define src_row_size r8d



sierpinski_asm:
   	push rbp
   	mov rbp, rsp

	xor r10, r10
    xor r11, r11

    movd xmm8, cols
    pshufd xmm8, xmm8, 0
    cvtdq2ps xmm8, xmm8 ; cols brodcasteado ps

    movd xmm9, rows
    pshufd xmm9, xmm9, 0
    cvtdq2ps xmm9, xmm9; rows brodcasteado ps

    movdqu xmm13, [constante]


    movdqu xmm15, [indiceColumna]

    pxor xmm14, xmm14

   .loop:

;instucciones para limite de performance logico
    PUSH rax
    POP rax
    PUSH rax
    POP rax
;instucciones para limite de performance logico


  ;instucciones para limite de performance ram

;instucciones para limite de performance ram



    movdqu xmm0, [src]
    ; calculo del coeficiente
    movd xmm11, r11d
    pshufd xmm11, xmm11, 0
    paddd xmm11, xmm15
    cvtdq2ps xmm11, xmm11; j brodcasteado en ps

    movd xmm10, r10d
    pshufd xmm10, xmm10, 0
    cvtdq2ps xmm10, xmm10; i brodcasteado en ps

    divps xmm10, xmm9 
    divps xmm11, xmm8

    mulps xmm10, xmm13
    mulps xmm11, xmm13

    cvttps2dq xmm10, xmm10
    cvttps2dq xmm11, xmm11

    pxor xmm10, xmm11

    cvtdq2ps xmm10, xmm10

    divps xmm10, xmm13

    ; fin calculo coeficiente

    movdqu xmm1, xmm0
    movdqu xmm2, xmm0

    punpcklbw xmm1, xmm14
    punpckhbw xmm2, xmm14

 	movdqu xmm3, xmm1
    movdqu xmm4, xmm1
    movdqu xmm5, xmm2
    movdqu xmm6, xmm2

    punpcklwd xmm3, xmm14
    punpcklwd xmm5, xmm14

	punpckhwd xmm4, xmm14
    punpckhwd xmm6, xmm14

    cvtdq2ps xmm3, xmm3; r,g ,b , t
    cvtdq2ps xmm4, xmm4
    cvtdq2ps xmm5, xmm5
    cvtdq2ps xmm6, xmm6

    movdqu xmm11, xmm10
    shufps xmm11, xmm10, 0
    mulps xmm3, xmm11

    movdqu xmm11, xmm10
    shufps xmm11, xmm10, 01010101b ; brodcasteo el segundo coeficiente para multiplicarlo por el segundo pixel
    mulps xmm4, xmm11

    movdqu xmm11, xmm10
    shufps xmm11, xmm10, 10101010b ; brodcasteo el tercer coeficiente para multiplicarlo por el tercero pixel
    mulps xmm5, xmm11

 	movdqu xmm11, xmm10
    shufps xmm11, xmm10, 11111111b ; brodcasteo el cuarto para multiplicarlo por el cuarto pixel
    mulps xmm6, xmm11

    cvttps2dq xmm3, xmm3
    cvttps2dq xmm4, xmm4
    cvttps2dq xmm5, xmm5
    cvttps2dq xmm6, xmm6

    packssdw xmm3, xmm4
    packssdw xmm5, xmm6

    packuswb xmm3, xmm5



    ;acá hago cosas con el coeficiente
    ;y multiplico por el mmx0


    movdqu [dst], xmm3
    add src, 16
    add dst, 16
    add r11d, 4
    cmp r11d, cols
    jl .loop
    xor r11, r11
    inc r10d
    cmp r10d, rows
    jl .loop


    pop rbp
    ret
