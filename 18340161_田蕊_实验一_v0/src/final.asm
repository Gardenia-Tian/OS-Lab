const:
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
    ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
code:
    org 7c00h
    mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
    mov ax,name                  ;����ҵ�������ѧ��
    mov bp,ax
    mov cx,17
    mov ax,01301h
    mov bx,000ch
    mov dl,0                     ;�ǵó���һ�£������0�ĳ�39�ǲ��ǾͿ��Ա�ɰ�ѧ�ź����������м���ʾ
    int 10h
start:                           ;��һ��������ĸ���˶���ʼ�Ĵ���
    mov ax,0B800h
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
	mov ax,25
	sub ax,bx                       ;�ж��ǲ���ײ�����±�
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  dr2dl                       ;�ж��ǲ���ײ��������
	jmp judgech
dr2ur:                                ;���ײ��������
      mov word[x],23
      mov byte[rdul],Up_Rt	     
      jmp judgech
dr2dl:                                ;���ײ��������
      mov word[y],78
      mov byte[rdul],Dn_Lt	
      jmp judgech

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul                        ;�ж��ǲ���ײ��������
	mov bx,word[x]
	mov ax,0
	sub ax,bx
      jz  ur2dr                        ;�ж��ǲ���ײ��������
	jmp judgech
ur2ul:                                 ;���ײ��������
      mov word[y],78
      mov byte[rdul],Up_Lt	
      jmp judgech
ur2dr:                                 ;���ײ��������
      mov word[x],2
      mov byte[rdul],Dn_Rt	
      jmp judgech

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,0
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur
	jmp judgech

ul2dl:
      mov word[x],2
      mov byte[rdul],Dn_Lt	
      jmp judgech
ul2ur:
      mov word[y],1
      mov byte[rdul],Up_Rt	
      jmp judgech

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp judgech

dl2dr:
      mov word[y],1
      mov byte[rdul],Dn_Rt	
      jmp judgech
	
dl2ul:
      mov word[x],23
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
      mov al,10h
      sub al,bl
      jz changeco
      jmp show
changech:
      mov byte[char],'A'
      jmp judgeco
changeco:
      mov byte[color],01h
      jmp show
show:	
    xor ax,ax                 ; �����Դ��ַ
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
    jmp loop1
end:
    jmp $
datadef:
    name db "18340161 Tian Rui"
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; �������˶�
    x    dw 18
    y    dw 0
    char db 'A'
    color db 01h
    times 510-($-$$) db 0
    db 0x55,0xaa