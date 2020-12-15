;程序源代码（myos1.asm）
org  7c00h
;org  100h
;org 0h

		; BIOS将把引导扇区加载到0:7C00h处，并开始执行
OffSetOfUserPrg1 equ 8100h
OffSetOfUserPrg2 equ 8500h
OffSetOfUserPrg3 equ 8900h
OffSetOfUserPrg4 equ 8D00h

Clear:
	mov ah,06h	;清屏
	mov al,0	
	mov ch,0
	mov cl,0
	mov dh,24
	mov dl,79
	mov bh,0fh
	int 10h
Start:
	mov	ax, cs	       ; 置其他段寄存器值与CS相同
	mov	ds, ax	       ; 数据段
	mov	bp, Message		 ; BP=当前串的偏移地址
	mov	ax, ds		 ; ES:BP = 串地址
	mov	es, ax		 ; 置ES=DS
	mov	cx, MessageLength  ; CX = 串长（=9）
	mov	ax, 1301h		 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
	mov	bx, 0007h		 ; 页号为0(BH = 0) 黑底白字(BL = 07h)
      mov    dh, 0		       ; 行号=0
	mov	dl, 0			 ; 列号=0
	int	10h			 ; BIOS的10h功能：显示一行字符
	
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
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
       mov bx,000ch
       mov dl,0                     ;列号 = 0
       mov dh,5                     ;行号 = 1
       int 10h

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
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
       mov bx,000ch
       mov dl,40                     ;列号 = 0
       mov dh,5                     ;行号 = 1
       int 10h

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
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
       mov bx,000ch
       mov dl,0                     ;列号 = 0
       mov dh,15                     ;行号 = 1
       int 10h

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
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h（功能号）、AL = 01h（光标置于串尾）
       mov bx,000ch
       mov dl,40                     ;列号 = 0
       mov dh,15                     ;行号 = 1
       int 10h

	mov ax,cs                ;段地址 ; 存放数据的内存基地址
      mov es,ax                ;设置段地址（不能直接mov es,段地址）
      mov bx, OffSetOfUserPrg4  ;偏移地址; 存放数据的内存偏移地址
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
Message:
      db 'Hello, Please select the program you want to run. '
MessageLength  equ ($-Message)

Message1:
      db 'Hello, MyOs is loading user program  '
Message1Length  equ ($-Message1)

MessHelp1:
      db 'Prg1Name:A  SectorNum: 3  ' 
MessHelp1Length equ ($-MessHelp1)
MessHelp2:
      db 'Prg2Name:B  SectorNum: 4  '
MessHelp2Length equ ($-MessHelp2)
MessHelp3:
      db 'Prg3Name:C  SectorNum: 5  '
MessHelp3Length equ ($-MessHelp3)
MessHelp4:
      db 'Prg4Name:D  SectorNum: 6  '    
MessHelp4Length equ ($-MessHelp4)
      times 510-($-$$) db 0
      db 0x55,0xaa


