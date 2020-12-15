	ifndef	??version
?debug	macro
	endm
	endif
	?debug	S "ques1.c"
	
_TEXT	segment	byte public 'CODE'
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP,ss:DGROUP
_TEXT	ends

;数据段必须定义成这样,定义类型为word,组合类型为public,段类别为DATA
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends

_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
	?debug	C E93044AB500771756573312E63
_BSS	ends

_DATA	segment word public 'DATA'
_global	label	word
	dw	0
_DATA	ends

_TEXT	segment	byte public 'CODE'
;	?debug	L 3
_f	proc	near
	push	bp
	mov	bp,sp
;	?debug	L 4
	mov	ax,word ptr [bp+4]
	cmp	ax,word ptr [bp+6]
	jle	@2
	mov	ax,word ptr [bp+4]
	mov	word ptr DGROUP:_global,ax
	jmp	short @3
@2:
;	?debug	L 5
	mov	ax,word ptr [bp+6]
	mov	word ptr DGROUP:_global,ax
@3:
;	?debug	L 6
	mov	ax,word ptr DGROUP:_global
	jmp	short @1
@1:
;	?debug	L 7
	pop	bp
	ret	
_f	endp
_TEXT	ends

_DATA	segment word public 'DATA'
	dw	0
	db	2 dup (0)
_DATA	ends

_TEXT	segment	byte public 'CODE'
;	?debug	L 9
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,4
	push	si
	push	ss
	lea	ax,word ptr [bp-4]
	push	ax
	push	ds
	mov	ax,offset DGROUP:d@+2
	push	ax
	mov	cx,4
	call	far ptr SCOPY@
;	?debug	L 11
	xor	si,si
;	?debug	L 12
	mov	word ptr [bp-4],100
;	?debug	L 13
	mov	word ptr [bp-2],50
;	?debug	L 14
	push	word ptr [bp-2]
	push	word ptr [bp-4]
	call	near ptr _f
	pop	cx
	pop	cx
	mov	si,ax
;	?debug	L 15
	xor	ax,ax
	jmp	short @4
@4:
;	?debug	L 16
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_main	endp
_TEXT	ends

	?debug	C E9
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends

	extrn	SCOPY@:far
_TEXT	segment	byte public 'CODE'
_TEXT	ends
	public	_global
	public	_main
	public	_f
	end
