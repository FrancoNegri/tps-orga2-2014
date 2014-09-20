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


;void debugPrint(char* c, int long)
debugPrint:
	push rbp
	mov rbp, rsp
	push rax
	push rbx 
	push rcx
	push rdx

	mov rax, 4     ; funcion 4
   	mov rbx, 1     ; stdout
   	mov rcx, rdi
   	mov rdx, rsi
   	int 0x80

	pop rdx
	pop rcx
	pop rbx
	pop rax
	pop rbp
	ret


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
    mov r12d, [rbp + 8]
    mov r13d, [rbp + 16]
    mov r14d, [rbp + 24]
    mov r15d, [rbp + 32]
    xor rax, rax
    shl cols, 2
	mov rax, offsety
	mul cols
	add rax, src
    lea rdi, [rax + offsetx*4]
      
    xor r10, r10; i
    xor r11, r11; j

    dec tamy
    dec r9    
    mov r8, tamx
    dec r8
    ;seteamos el src en la ultima fila a recorrer
    ;agarramos 4 pixels y los pegamos en el destino
    ;sumamos 4 al destino y al src
    ; cuando llego a offsety paro


    .loop:
    xor rax, rax
	mov eax, cols
	mul r10
	add rax, src
	movdqu xmm0, [rax + r11*4]

	push r8
	push r9
	push r10
	push r11
	push rdi
	push rsi
	mov rdi, msgsys
 	mov rsi, 4
	call debugPrint
	pop rsi
	pop rdi
	pop r11
	pop r10
	pop r9
	pop r8

	xor rax, rax
	mov rax, tamx
	shl rax, 2
	mul tamy
	add rax, dst	
	movdqu [rax + r11*4], xmm0
	add r11, 4
	cmp r11, 1 ;me fijo que no me pasé de las columnas
	jl .loop
	inc r10
	dec tamy
	xor r11, r11
	cmp r10d, 0 ; y acá me fijo si no me pasé de las filas
	jle .loop
	

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
