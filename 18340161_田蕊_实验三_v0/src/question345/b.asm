const:
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; 计时器延迟计数,用于控制画框的速度
    ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
    OShead equ 8B00h

code:
    org 8500h
    ;org 7c00h
    mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
    mov ax,name                  ;输出我的姓名和学号
    mov bp,ax
    mov cx,17
    mov ax,1301h                 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
    mov bx,000ch
    mov dl,40                     ;列号 = 0
    mov dh,5                     ;行号 = 1
    int 10h
start:                           ;这一部分是字母的运动开始的代码
    mov ax,0B800h                ; 文本窗口显存起始地址
    mov es,ax
    mov byte[char],'A'
loop1:
    dec word[count]				; 递减计数变量
    jnz loop1					; >0：跳转;
    mov word[count],delay
    dec word[dcount]				; 递减计数变量
    jnz loop1
    mov word[count],delay
    mov word[dcount],ddelay


      mov al,1
      cmp al,byte[rdul]
	jz  DnRt                       ;说明是向右下走
      mov al,2
      cmp al,byte[rdul]
	jz  UpRt                       ;说明是向右上走
      mov al,3
      cmp al,byte[rdul]
	jz  UpLt                       ;向左上走
      mov al,4
      cmp al,byte[rdul]
	jz  DnLt                       ;向左下走
      jmp $	

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,15
	sub ax,bx                       ;判断是不是撞上了下边
      jz  dr2ur
DnRt1:
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  dr2dl                       ;判断是不是撞上了右面
	jmp judgech
dr2ur:                                ;如果撞上了下面
      mov word[x],13
      mov byte[rdul],Up_Rt	     
      ;jmp judgech
	jmp DnRt1
dr2dl:                                ;如果撞上了右面
      mov word[y],78
      mov byte[rdul],Dn_Lt	
      jmp judgech

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul                        ;判断是不是撞上了右面
UpRt1:
	mov bx,word[x]
	mov ax,5
	sub ax,bx
       jz  ur2dr                        ;判断是不是撞上了上面
	jmp judgech
ur2ul:                                 ;如果撞上了右面
      mov word[y],78
      mov byte[rdul],Up_Lt	
      ;jmp judgech
	jmp UpRt1
ur2dr:                                 ;如果撞上了上面
      mov word[x],7
      mov byte[rdul],Dn_Rt	
      jmp judgech

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,5
	sub ax,bx
      jz  ul2dl                        ;判断是不是撞上了上边
UpLt1:	
	mov bx,word[y]
	mov ax,39
	sub ax,bx
      jz  ul2ur                        ;判断是不是撞上了左边
	jmp judgech

ul2dl:                                 ;如果撞上了上面
      mov word[x],7
      mov byte[rdul],Dn_Lt	
      ;jmp judgech
	jmp UpLt1
ul2ur:                                 ;如果撞上了左边
      mov word[y],41
      mov byte[rdul],Up_Rt	
      jmp judgech

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,39
	sub ax,bx
      jz  dl2dr                          ;判断是不是撞上了左边
DnLt1:
	mov bx,word[x]
	mov ax,15
	sub ax,bx
      jz  dl2ul                           ;判断是不是撞上了下边
	jmp judgech

dl2dr:
      mov word[y],41                       ;如果撞上了左边
      mov byte[rdul],Dn_Rt	
      ;jmp judgech
	jmp DnLt1
dl2ul:
      mov word[x],13                      ;如果撞上了下边
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
      mov al,50h
      sub al,bl
      jz changeco
      jmp show
changech:
      mov byte[char],'A'
      jmp judgeco
changeco:
      mov byte[color],41h
      jmp show
show:	
    xor ax,ax                 ; 计算显存地址
    mov ax,word[x]
    mov bx,80
    mul bx
    add ax,word[y]
    mov bx,2
    mul bx
    mov bx,ax                 ;bx中是位置
    mov ah,byte[color]              ;0ch代表颜色
    mov al,byte[char]
    mov [es:bx],ax

    inc word[cnt]
    mov ax,word[cnt]
    cmp ax,100h
    jne loop1

return:
    mov ax,cs                ;段地址 ; 存放数据的内存基地址
    mov es,ax                ;设置段地址（不能直接mov es,段地址）
    mov bx, OShead           ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    mov cl,7                 ;起始扇区号 ; 起始编号为1
    int 13H ;                调用读磁盘BIOS的13h功能
    ; 用户程序a.com已加载到指定内存区域中
    jmp OShead
    
end:
    jmp $
datadef:
    name db "18340161 Tian Rui"
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; 向右下运动
    x    dw 6
    y    dw 40
    char db 'A'
    color db 41h
    cnt   dw 0
    ;times 510-($-$$) db 0
    ;db 0x55,0xaa
