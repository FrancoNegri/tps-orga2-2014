
global bandas_asm

section .data

mascarita: dd 0xFFF0,0xFFF0,0xFFF0,0xFFF0
shufflingB: db 0,0,0,8,1,1,1,8,2,2,2,8,3,3,3,8
mask96: dw 95,95,95,95 
mask288: dw 287,287,287,287
mask480: dw 479,479,479,479
mask672: dw 671,671,671,671

const64: dw 64,64,64,64
const63: dw 63,63,63,63
const255: dw 255,255,255,255


section .text
;void bandas_asm    (
	;unsigned char *src,
	;unsigned char *dst,
	;int filas,
	;int cols,
	;int src_row_size,
	;int dst_row_size)

%define src rdi
%define dst rsi
%define cols ecx
%define rows edx
%define dst_row_size r9d
%define src_row_size r8d

bandas_asm:
	push rbp
	mov rbp, rsp

	xor r10, r10
    xor r11, r11

    pxor xmm14, xmm14

    movdqu xmm9, [mascarita]
    movdqu xmm8, xmm9
    pandn xmm8, xmm8

    movdqu xmm10, [mask672]
    movdqu xmm11, [mask480]
    movdqu xmm12, [mask288]
    movdqu xmm13, [mask96]

    movdqu xmm5, [const64]
    movdqu xmm6, [const63]
    movdqu xmm7, [const255]

    movdqu xmm15, [shufflingB]


    .loop:
    movdqu xmm0, [src]
    movdqu xmm3, xmm7 ;ACÀ ESTARÀ LA SOLUCIÒN, PERO PRIMERO SETEO TODO EN 255
    movdqu xmm2, xmm0
    pand xmm2, xmm7 ;ME GUARDO LOS FACTORES SARASA
    pand xmm0, xmm9
    movdqu xmm1,xmm0
    punpcklbw xmm0, xmm14
    punpckhbw xmm1, xmm14
    phaddw xmm0, xmm1
    phaddw xmm0, xmm0 ;ACÀ TENGO EN CADA WORD, EL "b" DE CADA PIXEL

    movdqu xmm4, xmm10
    pcmpgtq xmm4, xmm0
    pand xmm4, xmm6
    psubd xmm3, xmm4

    movdqu xmm4, xmm11
    pcmpgtq xmm4, xmm0
    pand xmm4, xmm5
    psubd xmm3, xmm4

    movdqu xmm4, xmm12
    pcmpgtq xmm4, xmm0
    pand xmm4, xmm5
    psubd xmm3, xmm4

    movdqu xmm4, xmm13
    pcmpgtq xmm4, xmm0
    pand xmm4, xmm5
    psubd xmm3, xmm4

    ;ahora empaqueto y brodcasteo

    packusdw xmm3, xmm14
    packuswb xmm3, xmm14
    pshufb xmm3, xmm15

    paddb xmm3, xmm2
    ;y acà hago la magia

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
 
