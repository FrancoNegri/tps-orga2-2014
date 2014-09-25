
global mblur_asm

section .data

const02: dd 0.2,0.2,0.2,0.2
mascarita: db 0xFF,0xFF,0xFF,0x00,0xFF,0xFF,0xFF,0x00,0xFF,0xFF,0xFF,0x00,0xFF,0xFF,0xFF,0x00


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
%define cols edx
%define rows ecx
%define src_row_size r8d
%define dst_row_size r9d




mblur_asm:
	push rbp
   	mov rbp, rsp
   	push r12
   	push r13
   	push r14
   	push r15


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



;     ;probamos iniciando todo en 0
;     mov r13, dst

; .loopini:

;     movdqu [r13], xmm14
;     add r13, 16
;     add r11d, 4
;     cmp r11d, cols
;     jl .loopini
;     xor r11, r11
;     inc r10d
;     cmp r10d, rows
;     jl .loopini


;     xor r10,r10
;     xor r11,r11
;     xor r13, r13

;fin prueba

    
    sub cols, 4
    sub rows, 4

    ;ACÀ CALCULO LOS OFFSET PARA TOMARLOS CINCO PIXELES
   	mov r12d, src_row_size
   	add r12d, 4
    mov r13d, r12d
    add r13d, src_row_size
    add r13d, 4
    mov r14d, r13d
    add r14d, src_row_size
    add r14d, 4
    mov r15d, r14d
    add r15d, src_row_size
    add r15d, 4
    
   	
   	movdqu xmm15, [const02]




    mov r9, dst
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

;p1
;   p2
;       p3
;           p4
;               p5

  mov dst, r9
  add dst, r13

.loop:
	movdqu xmm0, [src]
	movdqu xmm1, [src + r12]
	movdqu xmm2, [src + r13]
	movdqu xmm3, [src + r14]
	movdqu xmm4, [src + r15]

	movdqu xmm10, xmm2
	pand xmm10, xmm13

	movdqu xmm5, xmm0
	punpckhbw xmm5, xmm14; en xmm5 dejo la parte alta de p1
	punpcklbw xmm0, xmm14; en xmm0 dejo la parte baja de p1

	movdqu xmm6, xmm1
	punpckhbw xmm6, xmm14 ; en xmm6 dejo la parte alta de p2
	punpcklbw xmm1, xmm14 ; en xmm1 dejo la parte baja de p2

	movdqu xmm7, xmm2
	punpckhbw xmm7, xmm14 ; en xmm6 dejo 
	punpcklbw xmm2, xmm14
	
	movdqu xmm8, xmm3
	punpckhbw xmm8, xmm14
	punpcklbw xmm3, xmm14

	movdqu xmm9, xmm4
	punpckhbw xmm9, xmm14
	punpcklbw xmm4, xmm14

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
	punpckhwd xmm1, xmm14; la parte alta de la parte baja, pixel 2
	punpcklwd xmm0, xmm14; la parte baja de la parte baja, pixel 1

	movdqu xmm6, xmm5
	punpckhwd xmm6, xmm14; pixel 4
	punpcklwd xmm5, xmm14; pixel 3

	cvtdq2ps xmm0, xmm0
	cvtdq2ps xmm1, xmm1
	cvtdq2ps xmm5, xmm5
	cvtdq2ps xmm6, xmm6

	mulps xmm0, xmm15
	mulps xmm1, xmm15
	mulps xmm5, xmm15
	mulps xmm6, xmm15

	cvttps2dq xmm0, xmm0
	cvttps2dq xmm1, xmm1
	cvttps2dq xmm5, xmm5
	cvttps2dq xmm6, xmm6

	packusdw xmm0,xmm1; p1 p2
	packusdw xmm5,xmm6; p3 p4
	packuswb xmm0,xmm5

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
 
