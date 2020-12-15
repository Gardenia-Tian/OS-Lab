const:
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�?
    ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�?
    OShead equ 8100h
code:
    org 100h
    mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
    mov ax,name                  ;����ҵ�������ѧ��?
    mov bp,ax
    mov cx,17
    mov ax,1301h                 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��?
    mov bx,000ch
    mov dl,0                     ;�к� = 0
    mov dh,5                     ;�к� = 1
    int 10h
start:                           ;��һ��������ĸ���˶���ʼ�Ĵ���
    mov ax,0B800h                ; �ı������Դ���ʼ��ַ
    mov es,ax
    mov byte[char],'A'
loop1:
    dec word[count]				; �ݼ���������
    jnz loop1					; >0����ת;
    mov word[count],delay
    dec word[dcount]				; �ݼ���������
    jnz loop1
    mov word[count],delay
    mov word[dcount],ddelay


      mov al,1
      cmp al,byte[rdul]
	jz  DnRt                       ;˵������������
      mov al,2
      cmp al,byte[rdul]
	jz  UpRt                       ;˵������������
      mov al,3
      cmp al,byte[rdul]
	jz  UpLt                       ;��������
      mov al,4
      cmp al,byte[rdul]
	jz  DnLt                       ;��������
      jmp $	

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,15
	sub ax,bx                       ;�ж��ǲ���ײ�����±�
      jz  dr2ur
DnRt1:
	mov bx,word[y]
	mov ax,40
	sub ax,bx
      jz  dr2dl                       ;�ж��ǲ���ײ��������
	jmp judgech
dr2ur:                                ;���ײ��������?
      mov word[x],13
      mov byte[rdul],Up_Rt	     
      ;jmp judgech
	jmp DnRt1
dr2dl:                                ;���ײ��������?
      mov word[y],38
      mov byte[rdul],Dn_Lt	
      jmp judgech

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,40
	sub ax,bx
      jz  ur2ul                        ;�ж��ǲ���ײ��������
UpRt1:
	mov bx,word[x]
	mov ax,5
	sub ax,bx
       jz  ur2dr                        ;�ж��ǲ���ײ��������
	jmp judgech
ur2ul:                                 ;���ײ��������?
      mov word[y],38
      mov byte[rdul],Up_Lt	
      ;jmp judgech
	jmp UpRt1
ur2dr:                                 ;���ײ��������?
      mov word[x],7
      mov byte[rdul],Dn_Rt	
      jmp judgech

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,5
	sub ax,bx
      jz  ul2dl                        ;�ж��ǲ���ײ�����ϱ�
UpLt1:	
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur                        ;�ж��ǲ���ײ�������?
	jmp judgech

ul2dl:                                 ;���ײ��������?
      mov word[x],7
      mov byte[rdul],Dn_Lt	
      ;jmp judgech
	jmp UpLt1
ul2ur:                                 ;���ײ�������
      mov word[y],1
      mov byte[rdul],Up_Rt	
      jmp judgech

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr                          ;�ж��ǲ���ײ�������?
DnLt1:
	mov bx,word[x]
	mov ax,15
	sub ax,bx
      jz  dl2ul                           ;�ж��ǲ���ײ�����±�
	jmp judgech

dl2dr:
      mov word[y],1                       ;���ײ�������
      mov byte[rdul],Dn_Rt	
      ;jmp judgech
	jmp DnLt1
dl2ul:
      mov word[x],13                      ;���ײ�����±�?
      mov byte[rdul],Up_Lt	
      jmp judgech
	
judgech:
      inc byte[char]
      mov bl,byte[char]
      mov al,91
      sub al,bl
      jz changech
judgeco:
      inc byte[color]
      mov bl,byte[color]
      mov al,20h
      sub al,bl
      jz changeco
      jmp show
changech:
      mov byte[char],'A'
      jmp judgeco
changeco:
      mov byte[color],11h
      jmp show
show:	
    xor ax,ax                 ; �����Դ���?
    mov ax,word[x]
    mov bx,80
    mul bx
    add ax,word[y]
    mov bx,2
    mul bx
    mov bx,ax                 ;bx����λ��
    mov ah,byte[color]              ;0ch������ɫ
    mov al,byte[char]
    mov [es:bx],ax
   
    inc word[cnt]
    	
    mov ax,word[cnt]
    cmp word[cnt],60h
    jne loop1
    	
return:
	
    retf

end:
    jmp $
datadef:
    name db "18340161 Tian Rui"
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; �������˶�
    x    dw 6
    y    dw 0
    char db 'A'
    color db 11h
    cnt   dw 0
    ;times 510-($-$$) db 0
    ;db 0x55,0xaa
