;定义一个输出字符串的宏
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
bits 16
extern strlen
extern gets 
extern puts ;只能输出字符串
extern putchar
extern saveReg
extern printmyname
extern main
extern reg
extern preg
extern name
extern getbuf
global _call_proc
global _getC
global _getCursor
global _setCursor
global _putC
global _start
global _clear
global _pageUP
global _int20h
global _int21h
global _int22h
global _wait
global cnt

;==========================================================================================================
OffSetOfUserPrg equ 1000h ;所有的用户程序都加载到这个内存处

delay equ 1		; 计时器延迟计数
ddelay1 equ 50000
ddelay2 equ 50000
alltype equ 0ah

;==========================================================================================================
_start:
	mov ax,cs
    mov es,ax
    mov ds,ax
    mov ss,ax
	call _clear         ;进入内核程序先清一下屏	
Begin:
	;装载中断
	cli
	xor ax,ax			; AX = 0
	mov es,ax			; ES = 0
	mov word [es:20h],Timer	; 设置时钟中断向量的偏移地址
	mov ax,cs 
	mov word [es:22h],ax		; 设置时钟中断向量的段地址=CS
	mov word [es:128],int20hsys
	mov word [es:130],ax
	mov word [es:132],syscall
	mov word [es:134],ax 
	mov word [es:136],int22hsys
	mov word [es:138],ax 
	sti
	
	mov ds,ax			; DS = CS
	mov es,ax			; ES = CS
	; 在屏幕右下角显示字符	
	mov	ax,0B800h		; 文本窗口显存起始地址
	mov	gs,ax		; GS = B800h
	mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	mov al,byte[char1]			; AL = 显示字符值（默认值为20h=空格符）
	mov [gs:((80*24+79)*2)],ax	; 屏幕第 24 行, 第 79 列
	
	mov ax,cs
	mov ds,ax
	mov es,ax 
	mov ss,ax 
	mov sp,0fffh
	
	call main
	
	jmp $


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
;int _getC();
;==========================================================================================================
_getC:
	;mov ah, 01H
	;int 16H
	;jz _getC
	mov ah, 00H
	int 16H
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
;
;==========================================================================================================	

;==========================================================================================================
;wait
;==========================================================================================================
_wait:
	push ebp
	mov ebp, esp
	
	push eax
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
	cmp al,'E'
	je Load5Ex
Load1Ex:
	mov cl,12
	mov ax,0201h
	jmp read
Load2Ex:
	mov cl,13
	mov ax,0201h
	jmp read
Load3Ex:
	mov cl,14
	mov ax,0201h
	jmp read
Load4Ex:
    mov cl,15
	mov ax,0201h
    jmp read
Load5Ex:
	mov cl,16
	mov ax,0205h
	jmp read		
read:

	mov bx,1000h
	mov es,bx
	mov bx,100h
	;mov ax,0201h
	mov dx,0000h
	mov ch,00h
	int 13h
	call 1000h:100h
	
	pop ebp
	
	mov ax,cs
	mov ds,ax
	mov es,ax
	
	ret
;==========================================================================================================
;int 20h
;==========================================================================================================
_int20h:
	push ebp
	mov ebp, esp
	mov al,byte [bp+8]
	int 20h
	pop ebp
	ret
;==========================================================================================================
;int 20h系统的
;==========================================================================================================
int20hsys:
	cli
	call _save
	push si
	mov si,preg
	mov word[si+16],0x0800
	mov word[si+48],_start
	;mov word[ip_save],_start
	;mov word[cs_save],0x800
	pop si
end20h:
	jmp _restart
;==========================================================================================================
;int 21h接口这里还不用save,这里只是一个函数
;==========================================================================================================
_int21h:
	push ebp
	mov ebp, esp
	mov al,byte [bp+8]
	int 21h
	pop ebp
	ret

;==========================================================================================================
;syscall这里才是真正的处理程序
;==========================================================================================================
syscall:
	cli
	call _save
	
	pusha
	push ss
	push ds 
	push es 

	cmp al,0
	jz fno0
	cmp al,1
	jz fno1
	cmp al,2
	jz fno2
	cmp al,3
	jz fno3
	jmp endsyscall
fno0:	
	print MessHelp,MessHelpLength,12,20
	jmp endsyscall
fno1:	
	push 0x00
	call _getC
	
	movsx eax, al
	push eax
	push 0x00 
	call putchar

	int 20h
	jmp endsyscall
fno2:
    mov ax,getbuf
	movzx eax,ax
	push eax
	push 0x00
	call gets
	pop ax
	pop eax
	jmp endsyscall
fno3:
	push eax
	mov al,'C'
	movsx eax,al
	push eax
	push 0x00
	call _call_proc
	pop ax
	pop eax 
	pop eax 
	jmp endsyscall
endsyscall:
	pop es 
	pop ds 
	pop ss 
	popa
	jmp _restart

;==========================================================================================================
;int22hsys
;==========================================================================================================
int22hsys:
	cli
	call _save
	mov ax,cs
	mov ds,ax
	mov ax,0b800h
	mov es,ax
	mov al,'I'
	mov ah,0fh
	mov [es:((80*3+50)*2)],ax
	mov al,'N'	
	mov [es:((80*3+51)*2)],ax	
	mov al,'T'
	mov [es:((80*3+52)*2)],ax	
	mov al,'2'
	mov [es:((80*3+53)*2)],ax
	mov al,'2'	
	mov [es:((80*3+54)*2)],ax
	mov al,'H'
	mov [es:((80*3+55)*2)],ax

end22hsys:
	jmp _restart

;==========================================================================================================
;int22h user
;==========================================================================================================
_int22h:
	push ebp
	mov ebp, esp
	int 22h	
	pop ebp
	ret

;==========================================================================================================
;
;==========================================================================================================
Timer:
	cli
	call _save
	
	mov ax,cs
	mov ds,ax
	mov ax,0B800h		; 文本窗口显存起始地址
	mov es,ax		; GS = B800h
	mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	
	dec byte [count]		; 递减计数变量
	jnz end8			; >0：跳转
	mov al,byte[chara]
	cmp al,1
	je  outch1
	cmp al,2
	je  outch2
	cmp al,3
	je  outch3
	cmp al,4
	je  outch4

outch1:
	mov al,byte[char1]      			; AL = 显示字符值（默认值为20h=空格符）
	mov [es:((80*24+79)*2)],ax
	mov byte[count],delay		; 重置计数变量=初值delay
	mov byte[chara],2
	jmp end8
outch2:
    ;mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	mov al,byte[char2]			; AL = 显示字符值（默认值为20h=空格符）
	mov [es:((80*24+79)*2)],ax
	mov byte[count],delay		; 重置计数变量=初值delay	
	mov byte[chara],3
	jmp end8
outch3:
    ;mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	mov al,byte[char3]			; AL = 显示字符值（默认值为20h=空格符）
	mov [es:((80*24+79)*2)],ax
	mov byte[count],delay		; 重置计数变量=初值delay	
	mov byte[chara],4
	jmp end8	
outch4:
	;mov ah,0Fh		; 0000：黑底、1111：亮白字（默认值为07h）
	mov al,byte[char4]			; AL = 显示字符值（默认值为20h=空格符）
	mov [es:((80*24+79)*2)],ax
	mov byte[count],delay		; 重置计数变量=初值delay	
	mov byte[chara],1
	jmp end8
	
end8:
    jmp _restart	
;==========================================================================================================
;
;==========================================================================================================
_save:
	push ds
	push cs 
	pop ds
	pop word[ds_save]

	pop word[ret_save] 

	mov word[si_save], si
	mov si,preg
	
	pop word[si+48];保存ip
	pop word[si+16];保存cs
	pop word[si+52];保存flag


	mov word[si], ax 
	mov word[si+4],bx 
	mov word[si+8],cx 
	mov word[si+12],dx 
	push word[ds_save]
	pop word[si+20]
	mov word[si+24],es 
	mov word[si+28],ss
	mov word[si+32],sp 
	mov word[si+36],bp 
	mov word[si+40],di 
	push word[si_save]
	pop word[si+44];si

	jmp word[ret_save]
;==========================================================================================================
;
;==========================================================================================================	
_restart:
	mov si, preg
	mov ax, word[si]
	mov bx, word[si+4]
	mov cx, word[si+8]
	mov dx, word[si+12]
		;mov cs, word[si+16]
		;mov ds, word[si+20]
	mov es, word[si+24]
	mov ss, word[si+28]
	mov sp, word[si+32]
	mov bp, word[si+36]
	mov di, word[si+40]

	push word[si+52];flag压栈
	push word[si+16];cs压栈
	push word[si+48];ip压栈

	push word[si+44]
	push word[si+20]
	pop ds
	pop si 

	push ax
	mov al,20h
	out 20h,al
	out 0A0h,al 
	pop ax 
 
	iret
;==========================================================================================================
;
;==========================================================================================================
datadef:
	MessHelp db "Here is kernel by Tian Rui"
	MessHelpLength equ ($-MessHelp)
	Ouch db "OUCH!OUCH!  "
	OuchLength equ ($-Ouch)	  
	count db delay		; 计时器计数变量，初值=delay
	color db 02h
	cnt   db alltype
	chara db alltype
	char1  db '|'
	char2  db '\\'
	char3  db '-'
	char4  db '/'
	num1   dw ddelay1
	num2   dw ddelay2
	ret_save dw 0
	ds_save dw 0
	si_save dw 0