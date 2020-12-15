
extern  macro %1    ;统一用extern导入外部标识符
	extrn %1
endm

extern _count:near

;*****************************************
.8086                                   ;*
_TEXT segment byte public 'CODE'        ;*
assume cs:_TEXT                         ;*
DGROUP group _TEXT,_DATA,_BSS           ;* 
org 100h                                ;*
                                        ;*
start:                                  ;*
;*****************************************
;


		mov ax,cs
		mov ds,ax; DS = CS
		mov es,ax; ES = CS
		mov ss,ax; SS = cs
		mov sp, 100h   
		
		mov  bp, offset DGROUP:tip1
		mov  ax,ds
		mov  es,ax
		mov  cx,tip1len
		mov  ax,1301h
		mov  bx,0007h
		mov  dh,0
		mov  dl,0
		int  10h
		mov  ax,cs  ;设置es = cs
		mov  es,ax
		
		mov  bp, offset DGROUP:tip2
		mov  ax,ds
		mov  es,ax
		mov  cx,tip2len
		mov  ax,1301h
		mov  bx,0007h
		mov  dh,1
		mov  dl,0
		int  10h
		mov  ax,cs  ;设置es = cs
		mov  es,ax
		
		
		mov  ax, len
		push ax
		mov  ax, OFFSET DGROUP:mess
		push ax
		call near ptr _count
		pop  cx
		pop  cx
		
		
		mov  bx,0B800h
		mov  es,bx
		mov  bx,238
		mov  ah,07h
		add  al,48
		mov  es:[bx],ax
		mov  ax,cs
		mov  es,ax
		;mov  ah,4ch
		;int  21h
		
    	jmp $	
	
		;include kliba.asm
;
;*******************************************************************
                                                                  ;*
_TEXT ends                                                        ;*
                                                                  ;*
_DATA segment word public 'DATA'                                  ;*
    assume ds:_DATA                                               ;*
	tip1  db   "the message is:  bbaaazzssssaa", 0AH, 0DH, '$'    ;*
	tip1len equ $-tip1                                            ;*
	tip2  db   "the number of 'a' in the message is : ";38        ;*
	tip2len equ $-tip2                                            ;*
	mess db   "bbaaazzssssaa"                                     ;*
	len  equ  $-mess                                              ;*
	;cnt  dw   0                                                  ;*
	;stri db 5 dup(0)                                             ;*
_DATA ends                                                        ;*
                                                                  ;*
_BSS	segment word public 'BSS'                                 ;*
_BSS ends                                                         ;*
                                                                  ;* 
end start                                                         ;*
;*******************************************************************
