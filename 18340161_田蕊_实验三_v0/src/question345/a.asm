const:
    Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2                  ;
    Up_Lt equ 3                  ;
    Dn_Lt equ 4                  ;
    delay equ 50000					; ï¿½ï¿½Ê±ï¿½ï¿½ï¿½Ó³Ù¼ï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½Ú¿ï¿½ï¿½Æ»ï¿½ï¿½ï¿½ï¿½ï¿½Ù¶ï¿?
    ddelay equ 580					; ï¿½ï¿½Ê±ï¿½ï¿½ï¿½Ó³Ù¼ï¿½ï¿½ï¿½,ï¿½ï¿½ï¿½Ú¿ï¿½ï¿½Æ»ï¿½ï¿½ï¿½ï¿½ï¿½Ù¶ï¿?
    OShead equ 8B00h
code:
    org 8300h
    ;org 7c00h
    mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax
    mov ax,name                  ;ï¿½ï¿½ï¿½ï¿½Òµï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ñ§ï¿½ï¿?
    mov bp,ax
    mov cx,17
    mov ax,1301h                 ; AH = 13hï¿½ï¿½ï¿½ï¿½ï¿½ÜºÅ£ï¿½ï¿½ï¿½AL = 01hï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ú´ï¿½Î²ï¿½ï¿?
    mov bx,000ch
    mov dl,0                     ;ï¿½Ðºï¿½ = 0
    mov dh,5                     ;ï¿½Ðºï¿½ = 1
    int 10h
start:                           ;ï¿½ï¿½Ò»ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä¸ï¿½ï¿½ï¿½Ë¶ï¿½ï¿½ï¿½Ê¼ï¿½Ä´ï¿½ï¿½ï¿½
    mov ax,0B800h                ; ï¿½Ä±ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ô´ï¿½ï¿½ï¿½Ê¼ï¿½ï¿½Ö·
    mov es,ax
    mov byte[char],'A'
loop1:
    dec word[count]				; ï¿½Ý¼ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    jnz loop1					; >0ï¿½ï¿½ï¿½ï¿½×ª;
    mov word[count],delay
    dec word[dcount]				; ï¿½Ý¼ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    jnz loop1
    mov word[count],delay
    mov word[dcount],ddelay


      mov al,1
      cmp al,byte[rdul]
	jz  DnRt                       ;Ëµï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      mov al,2
      cmp al,byte[rdul]
	jz  UpRt                       ;Ëµï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      mov al,3
      cmp al,byte[rdul]
	jz  UpLt                       ;ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      mov al,4
      cmp al,byte[rdul]
	jz  DnLt                       ;ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      jmp $	

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,15
	sub ax,bx                       ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½Â±ï¿½
      jz  dr2ur
DnRt1:
	mov bx,word[y]
	mov ax,40
	sub ax,bx
      jz  dr2dl                       ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	jmp judgech
dr2ur:                                ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
      mov word[x],13
      mov byte[rdul],Up_Rt	     
      ;jmp judgech
	jmp DnRt1
dr2dl:                                ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
      mov word[y],38
      mov byte[rdul],Dn_Lt	
      jmp judgech

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,40
	sub ax,bx
      jz  ur2ul                        ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
UpRt1:
	mov bx,word[x]
	mov ax,5
	sub ax,bx
       jz  ur2dr                        ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	jmp judgech
ur2ul:                                 ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
      mov word[y],38
      mov byte[rdul],Up_Lt	
      ;jmp judgech
	jmp UpRt1
ur2dr:                                 ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
      mov word[x],7
      mov byte[rdul],Dn_Rt	
      jmp judgech

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,5
	sub ax,bx
      jz  ul2dl                        ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½Ï±ï¿½
UpLt1:	
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur                        ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
	jmp judgech

ul2dl:                                 ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
      mov word[x],7
      mov byte[rdul],Dn_Lt	
      ;jmp judgech
	jmp UpLt1
ul2ur:                                 ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      mov word[y],1
      mov byte[rdul],Up_Rt	
      jmp judgech

	
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr                          ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
DnLt1:
	mov bx,word[x]
	mov ax,15
	sub ax,bx
      jz  dl2ul                           ;ï¿½Ð¶ï¿½ï¿½Ç²ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½Â±ï¿½
	jmp judgech

dl2dr:
      mov word[y],1                       ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
      mov byte[rdul],Dn_Rt	
      ;jmp judgech
	jmp DnLt1
dl2ul:
      mov word[x],13                      ;ï¿½ï¿½ï¿½×²ï¿½ï¿½ï¿½ï¿½ï¿½Â±ï¿?
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
    xor ax,ax                 ; ï¿½ï¿½ï¿½ï¿½ï¿½Ô´ï¿½ï¿½Ö?
    mov ax,word[x]
    mov bx,80
    mul bx
    add ax,word[y]
    mov bx,2
    mul bx
    mov bx,ax                 ;bxï¿½ï¿½ï¿½ï¿½Î»ï¿½ï¿½
    mov ah,byte[color]              ;0chï¿½ï¿½ï¿½ï¿½ï¿½ï¿½É«
    mov al,byte[char]
    mov [es:bx],ax
   
    inc word[cnt]
    mov ax,word[cnt]
    cmp ax,100h
    jne loop1

return:
    mov ax,cs                ;¶ÎµØÖ· ; ´æ·ÅÊý¾ÝµÄÄÚ´æ»ùµØÖ·
    mov es,ax                ;ÉèÖÃ¶ÎµØÖ·£¨²»ÄÜÖ±½Ómov es,¶ÎµØÖ·£©
    mov bx, OShead           ;Æ«ÒÆµØÖ·; ´æ·ÅÊý¾ÝµÄÄÚ´æÆ«ÒÆµØÖ·
    mov ah,2                 ; ¹¦ÄÜºÅ
    mov al,1                 ;ÉÈÇøÊý
    mov dl,0                 ;Çý¶¯Æ÷ºÅ ; ÈíÅÌÎª0£¬Ó²ÅÌºÍUÅÌÎª80H
    mov dh,0                 ;´ÅÍ·ºÅ ; ÆðÊ¼±àºÅÎª0
    mov ch,0                 ;ÖùÃæºÅ ; ÆðÊ¼±àºÅÎª0
    mov cl,7                 ;ÆðÊ¼ÉÈÇøºÅ ; ÆðÊ¼±àºÅÎª1
    int 13H ;                µ÷ÓÃ¶Á´ÅÅÌBIOSµÄ13h¹¦ÄÜ
    ; ÓÃ»§³ÌÐòa.comÒÑ¼ÓÔØµ½Ö¸¶¨ÄÚ´æÇøÓòÖÐ
    jmp OShead
	;jmp 0x8000:100

end:
    jmp $
datadef:
    name db "18340161 Tian Rui"
    count dw delay
    dcount dw ddelay
    rdul db Dn_Rt         ; ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ë¶ï¿½
    x    dw 6
    y    dw 0
    char db 'A'
    color db 11h
    cnt   dw 0
    ;times 510-($-$$) db 0
    ;db 0x55,0xaa