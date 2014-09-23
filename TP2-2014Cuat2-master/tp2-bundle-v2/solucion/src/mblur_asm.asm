
global mblur_asm

section .data

const02: dd 0.2,0.2,0.2,0.2
mascarita: db 0xFF,0xFF,0xFF,0x0,0xFF,0xFF,0xFF,0x0,0xFF,0xFF,0xFF,0x0,0xFF,0xFF,0xFF,0x0


section .text
;void mblur_asm    (
	;unsigned char *src,
	;unsigned char *dst,
	;int filas,
	;int cols,
	;int src_row_size,
	;int dst_row_size)

%define src rdi
%define dst rsi
%define rows edx
%define cols ecx
%define src_row_size r8d
%define dst_row_size r9d




mblur_asm:
	push rbp
   	mov rbp, rsp
   	push r12
   	push r13
   	push r14
   	push r15

   	sub cols, 4
   	sub rows, 4

   	movdqu xmm12, [mascarita]
    pcmpeqd xmm13, xmm13
    pxor xmm13, xmm12; aca tenemos la mascarita invertid

   	xor rax, rax
   	mov eax, r8d

   	xor r10, r10
   	xor r11, r11

   	xor r12,r12
   	xor r13,r13
   	xor r14,r14
   	xor r15,r15

    ;ACÀ CALCULO LOS OFFSET PARA TOMARLOS CINCO PIXELES
   	mov r12d, src_row_size
   	add r12d, 4
   	mov r13d, src_row_size
   	shl r13d, 1
   	add r12d, 8
   	mov r14d, src_row_size
   	shl r14d, 1
   	add r14d, src_row_size
   	add r14d, 12 
   	mov r15d, src_row_size
   	shl r15d, 2
   	add r15d, 16

   	pxor xmm14, xmm14
   	movdqu xmm15, [const02]

   	xor rax, rax
   	mov [dst], rax
   	add dst, 8
   	add r11, 8

   	.negrear1:
   	movdqu [dst], xmm14
   	add dst, 16
   	add r11d, 16
   	cmp r11d, r13d
   	jl .negrear1

   	xor r11, r11

.loop:
	movdqu xmm0, [src]
	movdqu xmm1, [src + r12]
	movdqu xmm2, [src + r13]
	movdqu xmm3, [src + r14]
	movdqu xmm4, [src + r15]

	movdqu xmm10, xmm2
	pand xmm10, xmm13

	movdqu xmm5, xmm0
	punpckhbw xmm5, xmm14
	punpcklbw xmm0, xmm14

	movdqu xmm6, xmm1
	punpckhbw xmm6, xmm14
	punpcklbw xmm1, xmm14

	movdqu xmm7, xmm2
	punpckhbw xmm7, xmm14
	punpcklbw xmm2, xmm14
	
	movdqu xmm8, xmm3
	punpckhbw xmm8, xmm14
	punpcklbw xmm3, xmm14

	movdqu xmm9, xmm4
	punpckhbw xmm9, xmm14
	punpckhbw xmm4, xmm14

	paddw xmm5,xmm6
	paddw xmm0,xmm1

	paddw xmm7,xmm8
	paddw xmm2,xmm3

	paddw xmm5,xmm7
	paddw xmm0,xmm2

	paddw xmm5, xmm9
	paddw xmm0, xmm4

	;aca en el xmm0 tengo los dos pixeles de las partes bajas sumados y los dos de las partes altas en xmm5

	movdqu xmm1, xmm0
	punpckhwd xmm1, xmm14
	punpcklwd xmm0, xmm14

	movdqu xmm6, xmm5
	punpckhwd xmm6, xmm14
	punpcklwd xmm5, xmm14

	cvtdq2ps xmm0, xmm0
	cvtdq2ps xmm1, xmm1
	cvtdq2ps xmm5, xmm5
	cvtdq2ps xmm6, xmm6

	mulps xmm0, xmm15
	mulps xmm1, xmm15
	mulps xmm5, xmm15
	mulps xmm6, xmm15

	cvtps2dq xmm0, xmm0
	cvtps2dq xmm1, xmm1
	cvtps2dq xmm5, xmm5
	cvtps2dq xmm6, xmm6

	packusdw xmm0, xmm1
	packusdw xmm5, xmm6
	packuswb xmm0, xmm5

	pand xmm0, xmm12
	paddb xmm0, xmm10

    movdqu [dst], xmm0
    add src, 16
    add dst, 16
    add r11d, 4
    cmp r11d, cols
    jl .loop
    xor r11, r11
    movdqu [dst], xmm14
    add dst, 16
    add src, 16
    inc r10d
    cmp r10d, rows
    jl .loop

    xor r11, r11
    add r11, 16
    .negrear2:
   	movdqu [dst], xmm14
   	add dst, 16
   	add r11d, 16
   	cmp r11d, r13d
   	jl .negrear2

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
 
