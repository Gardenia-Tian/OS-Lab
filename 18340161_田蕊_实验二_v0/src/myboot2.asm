;����Դ���루myos1.asm��
org  7c00h
;org  100h
;org 0h

		; BIOS���������������ص�0:7C00h��������ʼִ��
OffSetOfUserPrg1 equ 8100h
OffSetOfUserPrg2 equ 8500h
OffSetOfUserPrg3 equ 8900h
OffSetOfUserPrg4 equ 8D00h

Clear:
	mov ah,06h	;����
	mov al,0	
	mov ch,0
	mov cl,0
	mov dh,24
	mov dl,79
	mov bh,0fh
	int 10h
Start:
	mov	ax, cs	       ; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       ; ���ݶ�
	mov	bp, Message		 ; BP=��ǰ����ƫ�Ƶ�ַ
	mov	ax, ds		 ; ES:BP = ����ַ
	mov	es, ax		 ; ��ES=DS
	mov	cx, MessageLength  ; CX = ������=9��
	mov	ax, 1301h		 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
	mov	bx, 0007h		 ; ҳ��Ϊ0(BH = 0) �ڵװ���(BL = 07h)
      mov    dh, 0		       ; �к�=0
	mov	dl, 0			 ; �к�=0
	int	10h			 ; BIOS��10h���ܣ���ʾһ���ַ�
	
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
	int    16h                 ;�����жϻ�ȡ�ַ�����AL��,����ָ��
	
	mov ah,0eh 	
	mov bl,0 
	int 10h 		; ����10H���жϣ���ʾ���������
	
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
       mov ax,1301h                 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
       mov bx,000ch
       mov dl,0                     ;�к� = 0
       mov dh,5                     ;�к� = 1
       int 10h

     ;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
      mov ax,cs                ;�ε�ַ ; ������ݵ��ڴ����ַ
      mov es,ax                ;���öε�ַ������ֱ��mov es,�ε�ַ��
      mov bx, OffSetOfUserPrg1  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
      mov ah,2                 ; ���ܺ�
      mov al,1                 ;������
      mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
      mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
      mov ch,0                 ;����� ; ��ʼ���Ϊ0
      mov cl,3                 ;��ʼ������ ; ��ʼ���Ϊ1
      int 13H ;                ���ö�����BIOS��13h����
      ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
      jmp OffSetOfUserPrg1
Load2Ex:
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
       mov bx,000ch
       mov dl,40                     ;�к� = 0
       mov dh,5                     ;�к� = 1
       int 10h

	mov ax,cs                ;�ε�ַ ; ������ݵ��ڴ����ַ
      mov es,ax                ;���öε�ַ������ֱ��mov es,�ε�ַ��
      mov bx, OffSetOfUserPrg2  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
      mov ah,2                 ; ���ܺ�
      mov al,1                 ;������
      mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
      mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
      mov ch,0                 ;����� ; ��ʼ���Ϊ0
      mov cl,4                 ;��ʼ������ ; ��ʼ���Ϊ1
      int 13H ;                ���ö�����BIOS��13h����
      ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
      jmp OffSetOfUserPrg2
Load3Ex:
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
       mov bx,000ch
       mov dl,0                     ;�к� = 0
       mov dh,15                     ;�к� = 1
       int 10h

	mov ax,cs                ;�ε�ַ ; ������ݵ��ڴ����ַ
      mov es,ax                ;���öε�ַ������ֱ��mov es,�ε�ַ��
      mov bx, OffSetOfUserPrg3  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
      mov ah,2                 ; ���ܺ�
      mov al,1                 ;������
      mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
      mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
      mov ch,0                 ;����� ; ��ʼ���Ϊ0
      mov cl,5                 ;��ʼ������ ; ��ʼ���Ϊ1
      int 13H ;                ���ö�����BIOS��13h����
      ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
      jmp OffSetOfUserPrg3
Load4Ex:
	mov ax,Message1                  
       mov bp,ax
       mov cx,Message1Length  
       mov ax,1301h                 ; AH = 13h�����ܺţ���AL = 01h��������ڴ�β��
       mov bx,000ch
       mov dl,40                     ;�к� = 0
       mov dh,15                     ;�к� = 1
       int 10h

	mov ax,cs                ;�ε�ַ ; ������ݵ��ڴ����ַ
      mov es,ax                ;���öε�ַ������ֱ��mov es,�ε�ַ��
      mov bx, OffSetOfUserPrg4  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
      mov ah,2                 ; ���ܺ�
      mov al,1                 ;������
      mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
      mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
      mov ch,0                 ;����� ; ��ʼ���Ϊ0
      mov cl,6                 ;��ʼ������ ; ��ʼ���Ϊ1
      int 13H ;                ���ö�����BIOS��13h����
      ; �û�����a.com�Ѽ��ص�ָ���ڴ�������
      jmp OffSetOfUserPrg4

AfterRun:
      jmp $                      ;����ѭ��
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


