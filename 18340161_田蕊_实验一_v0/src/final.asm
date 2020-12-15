const:
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; 计时器延迟计数,用于控制画框的速度
    ddelay equ 580					; 计时器延迟计数,用于控制画框的速度
code:
    org 7c00h
    mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
    mov ax,name                  ;输出我的姓名和学号
    mov bp,ax
    mov cx,17
    mov ax,01301h
    mov bx,000ch
    mov dl,0                     ;记得尝试一下，这里把0改成39是不是就可以变成把学号和姓名在最中间显示
    int 10h
start:                           ;这一部分是字母的运动开始的代码
    mov ax,0B800h
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
	mov ax,25
	sub ax,bx                       ;判断是不是撞上了下边
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  dr2dl                       ;判断是不是撞上了右面
	jmp judgech
dr2ur:                                ;如果撞上了下面
      mov word[x],23
      mov byte[rdul],Up_Rt	     
      jmp judgech
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
	mov bx,word[x]
	mov ax,0
	sub ax,bx
      jz  ur2dr                        ;判断是不是撞上了上面
	jmp judgech
ur2ul:                                 ;如果撞上了右面
      mov word[y],78
      mov byte[rdul],Up_Lt	
      jmp judgech
ur2dr:                                 ;如果撞上了上面
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
    jmp loop1
end:
    jmp $
datadef:
    name db "18340161 Tian Rui"
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; 向右下运动
    x    dw 18
    y    dw 0
    char db 'A'
    color db 01h
    times 510-($-$$) db 0
    db 0x55,0xaa