bits 16
extern _deal
extern _upper
extern _jcontrol
extern main
global _call_proc
global _getC
global _getCursor
global _setCursor
global _putC
global _start
global _clear
global _pageUP

%macro print 4	; string, length, x, y
	push ds
	push es
	push bp
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov bp, %1
	mov cx, %2
	mov ax, 1301h
	mov bx, 000fh
	mov edx,0
	mov dh, %3
	mov dl, %4
	int 10h
	pop bp
	pop es
	pop ds
%endmacro


OffSetOfUserPrg equ 9100h ;所有的用户程序都加载到这个内存处

delay equ 10		; 计时器延迟计数
 

_start:
	mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
;进入内核程序先清一下屏
Clear:
	mov ah,06h	;清屏
	mov al,0	
	mov ch,0
	mov cl,0
	mov dh,24
	mov dl,79
	mov bh,0fh
	int 10h
	
	
Begin:
	;装载中断
	cli
	xor ax,ax			; AX = 0
	mov es,ax			; ES = 0
	mov word [es:20h],int9	; 设置时钟中断向量的偏移地址
	mov ax,cs 
	mov word [es:22h],ax		; 设置时钟中断向量的段地址=CS
	sti
	
	mov ax,cs
	mov ds,ax
	mov es,ax 
	mov ss,ax 
	mov sp,0fffh
	
	call main
	
	jmp $

	
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
_getC:
	mov ah, 01H
	int 16H
	jz _getC
	mov ah, 00H
	int 16H
	ret
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
;==================================================================================================	
_call_proc:
	
	push ebp
	mov ebp, esp
	
	
	mov ax,cs
    mov es,ax
	
	mov al,byte [bp+8]
	cmp al,'A'
	je Load1Ex
	cmp al,'B'
	je Load2Ex
	cmp al,'C'
	je Load3Ex
	cmp al,'D'
	je Load4Ex
Load1Ex:
	mov cl,12
	jmp read
Load2Ex:
	mov cl,13
	jmp read
Load3Ex:
	mov cl,14
	jmp read
Load4Ex:
    mov cl,15
    jmp read	
read:

	mov ax,900h
	mov es,ax
	mov bx,100h
	mov ax,0201h
	mov dx,0000h
	mov ch,00h
	int 13h
	call 900h:100h
	
	
	pop ebp
	
	mov ax,cs
	mov ds,ax
	mov es,ax
	
	ret
;============================================================================================
int9:
	cli
	;push ax
	
	dec byte [count]		; 递减计数变量
	jnz end9			; >0：跳转
	mov byte[count],delay		; 重置计数变量=初值delay
	mov ah, 01h     ;缓冲区检测
	int 16h
	jz end9      ;缓冲区无按键
	
	print Ouch,OuchLength,3,40
	
	;pop ax
	sti
end9:
	mov al,20h			; AL = EOI
	out 20h,al			; 发送EOI到主8529A
	out 0A0h,al			; 发送EOI到从8529A
	iret


;============================================================================================
		
datadef:
	MessHelp db "Here is kernel by Tian Rui"
	MessHelpLength equ ($-MessHelp)
	Ouch db "OUCH!OUCH!  "
	OuchLength equ ($-Ouch)	  
	count db delay		; 计时器计数变量，初值=delay
	
;===============================================================================
;SECTION data_1 align=16 vstart=0
;	MessHelp db "Welcome back to the monitor  "
;	         db 0
;    MessHelpLength equ $-MessHelp

;===============================================================================

