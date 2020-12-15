bits 16
global _putC
global _getC
global _getCursor
global _setCursor
global _pageUP
global _clear
global _wait
SegKernel equ 800h
OffKernel equ 100h
extern strlen
extern gets 
extern puts 
extern putchar 
extern strcmp
extern upper
extern main

ddelay1 equ 50000
ddelay2 equ 50000

_start:
	;org 100h
	mov ax, cs 
	mov ss, ax 
	mov es, ax 
	mov ds, ax 
	mov sp, 0fffh

	call main

	;retf
	int 20h
	jmp $


;==========================================================================================================
;int _getC();
;==========================================================================================================
_getC:
	;mov ah, 01H
	;int 16H
	;jz _getC
	mov ah, 00H
	int 16H
	movzx eax,ax
	ret


;==========================================================================================================
;void _putC(int ch, int color);
;==========================================================================================================	
_putC:
	push ebp
	mov ebp, esp
	push ebx
	mov eax, dword [ebp+8]
	or ah, 9
	mov edx, dword [ebp+12]
	mov ecx, 1
	mov ebx, edx
	int 0x10
	pop ebx
	pop ebp
	ret    
;==========================================================================================================
;设置光标 int _getCursor();
;==========================================================================================================
_getCursor:
	push ebp
	mov ebp, esp
	push ebx
	sub esp, 4
	mov eax, 768
	mov edx, 0
	mov ebx, edx
	int 0x10
	mov eax, edx
	mov dword [ebp-8], eax
	mov eax, dword [ebp-8]
	add esp, 4
	pop ebx
	pop ebp
	ret
;==========================================================================================================
;void _setCursor(int cur);
;==========================================================================================================
_setCursor:
	push ebp
	mov ebp, esp
	push ebx
	mov eax, 512
	mov ecx, 0
	mov edx, dword [ebp+8]
	mov ebx, ecx
	int 0x10
	pop ebx
	pop ebp
	ret	

;==========================================================================================================
;void _pageUP(int);
;==========================================================================================================	
_pageUP:
	push ebp
	mov ebp, esp
	mov eax, dword [ebp+8]
	or ah, 6
	mov ecx, 0
	mov edx, 184fh
	int 0x10
	pop ebp
	ret

;==========================================================================================================
;_clear();
;==========================================================================================================	
_clear:
	push ebp
	mov ebp, esp
	
	mov ah,06h	;清屏
	mov al,0	
	mov ch,0
	mov cl,0
	mov dh,24
	mov dl,79
	mov bh,0fh
	int 10h
	
	pop ebp
	ret
	
;==========================================================================================================
;wait
;==========================================================================================================
_wait:
	push ebp
	mov ebp, esp
	
	push eax
	num1 dw ddelay1
	num2 dw ddelay2
.1:
	dec word[num1]				
    jnz .1					
    mov word[num1],ddelay1
    dec word[num2]				
    jnz .1
    mov word[num1],ddelay1
    mov word[num2],ddelay2

	pop eax
	pop ebp
	ret	