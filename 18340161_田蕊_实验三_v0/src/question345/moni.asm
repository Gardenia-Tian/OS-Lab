bits 16
extern getch
extern putch
extern gets
extern puts
extern strcmp


;org 8B00h



OffSetOfUserPrg1 equ 8300h
OffSetOfUserPrg2 equ 8500h
OffSetOfUserPrg3 equ 8700h
OffSetOfUserPrg4 equ 8900h
;OffSetOfMonitor  equ 1300h	


	mov ax,cs
    mov es,ax
    mov ds,ax
    mov es,ax

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
	
	mov	   ax, ds		 ; ES:BP = 串地址
	mov	   es, ax		 ; 置ES=DS
	mov	   ax, 1301h		 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	   bx, 0007h		 ; 页号为0(BH = 0) 黑底白字(BL = 07h)
	mov    bp, MessHelp1
	mov    cx, MessHelp1Length
	mov    dh, 1
	mov    dl, 0
	int    10h

	mov    bp, MessHelp2
	mov    cx, MessHelp2Length
	mov    dh, 2
	mov    dl, 0
	int    10h

	mov    bp, MessHelp3
	mov    cx, MessHelp3Length
	mov    dh, 3
	mov    dl, 0
	int    10h

	mov    bp, MessHelp4
	mov    cx, MessHelp4Length
	mov    dh, 4
	mov    dl, 0
	int    10h

	mov    ah, 0
	int    16h                 ;调用中断获取字符放在AL中,输入指令
	
	mov ah,0eh 	
	mov bl,0 
	int 10h 		; 调用10H号中断，显示输入的内容
	
	cmp    al, 'A'
	je     Load1Ex
	cmp    al, 'B'
	je     Load2Ex
	cmp    al, 'C'
	je     Load3Ex
	cmp    al, 'D'
	je     Load4Ex
Load1Ex:

     ;读软盘或硬盘上的若干物理扇区到内存的ES:BX处：
    mov ax,cs                ;段地址 ; 存放数据的内存基地址
    mov es,ax                ;设置段地址（不能直接mov es,段地址）
    mov bx, OffSetOfUserPrg1  ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    mov cl,3                 ;起始扇区号 ; 起始编号为1
    int 13H ;                调用读磁盘BIOS的13h功能
    ; 用户程序a.com已加载到指定内存区域中
    jmp OffSetOfUserPrg1
Load2Ex:

	mov ax,cs                ;段地址 ; 存放数据的内存基地址
    mov es,ax                ;设置段地址（不能直接mov es,段地址）
    mov bx, OffSetOfUserPrg2  ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    mov cl,4                 ;起始扇区号 ; 起始编号为1
    int 13H ;                调用读磁盘BIOS的13h功能
    ; 用户程序a.com已加载到指定内存区域中
    jmp OffSetOfUserPrg2
Load3Ex:

	mov ax,cs                ;段地址 ; 存放数据的内存基地址
    mov es,ax                ;设置段地址（不能直接mov es,段地址）
    mov bx, OffSetOfUserPrg3  ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    mov cl,5                 ;起始扇区号 ; 起始编号为1
    int 13H ;                调用读磁盘BIOS的13h功能
      ; 用户程序a.com已加载到指定内存区域中
    jmp OffSetOfUserPrg3
Load4Ex:
	
	mov ax,cs                ;段地址 ; 存放数据的内存基地址
    mov es,ax                ;设置段地址（不能直接mov es,段地址）
    mov bx,OffSetOfUserPrg4  ;偏移地址; 存放数据的内存偏移地址
    mov ah,2                 ; 功能号
    mov al,1                 ;扇区数
    mov dl,0                 ;驱动器号 ; 软盘为0，硬盘和U盘为80H
    mov dh,0                 ;磁头号 ; 起始编号为0
    mov ch,0                 ;柱面号 ; 起始编号为0
    mov cl,6                 ;起始扇区号 ; 起始编号为1
    int 13H ;                调用读磁盘BIOS的13h功能
      ; 用户程序a.com已加载到指定内存区域中
    jmp OffSetOfUserPrg4

AfterRun:
    jmp $                      ;无限循环	

datadef:
MessHelp1 db "Prg1Name:A  Instruction: A  "
MessHelp1Length equ ($-MessHelp1)
MessHelp2 db "Prg2Name:B  Instruction: B  "
MessHelp2Length equ ($-MessHelp2)
MessHelp3 db "Prg3Name:C  Instruction: C  "
MessHelp3Length equ ($-MessHelp3)
MessHelp4 db "Prg4Name:D  Instruction: D  "    
MessHelp4Length equ ($-MessHelp4)
    

