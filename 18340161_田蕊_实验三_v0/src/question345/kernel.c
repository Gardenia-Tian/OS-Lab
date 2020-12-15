#define MAX 100
#define OffSetOfUserPrg1 8300h
#define OffSetOfUserPrg2 8500h
#define OffSetOfUserPrg3 8700h
#define OffSetOfUserPrg4 8900h

char getch(){
    char ch;
    asm volatile(
        "int 0x16\n"
        :"=a"(ch)
        :"a"(0x1000));
    return ch;            

}

void putch(char ch){
    static int x = 0, y = 0;
    if(ch!='\r'&&ch!='\n'){
        //输出字符
        asm volatile(
            "push es\n"
            "mov es,ax\n"
            "mov es:[bx],cx\n"
            "pop es\n"
            :
            :"a"(0XB800),"b"((x*80+y)*2),"c"((0x07 << 8) | ch)
            :);
        y++;
        if(y>=80){
            x++;
            if(x>=25) x = 0;
            y = 0;
        }
        //置光标
        asm volatile(
			"int 0x10\n"
			:
			: "a"(0x0200), "b"(0), "d"((x << 8) | y));
		return;    
    }else{
        do{
            //输出一行的空格
            putch(' ');    
        }while (y);
    }
}

void gets(char* s){
    while(1){
        *s = getch();
        putch(*s);
        if(*s=='\r'||*s=='\n'){
            break;
        }
        s++;
    }
    *s = '\0';
}

void puts(char* s){
    while(*s){
        putch(*s);
        s++;
    }
}

int strcmp(char* s1, char* s2){
    while(*s1 && *s1==*s2){
        s1++;
        s2++;
    }
    return (int)*s1 - (int)*s2;
}

/*
void main(){
    char HELP[] = "help";
    char CLEAR[] = "clear";
    char str[MAX] = {0};
    char me1[] = "Prg1Name:A  Instruction: A  \n";
    char me2[] = "Prg1Name:B  Instruction: B  \n";
    char me3[] = "Prg1Name:C  Instruction: C  \n";
    char me4[] = "Prg1Name:D  Instruction: D  \n";
    puts(me1);
    puts(me2);
    puts(me3);
    puts(me4);
    gets(str);
    if(!strcmp(str,"clear")){
        for(int i=0;i<25;i++){
            putchar('\n');
        }
    }else if(!strcmp(str,"help")){
        puts(me1);
        puts(me2);
        puts(me3);
        puts(me4);
        gets(str);
    }else if(!strcmp(str,"A")){
        asm volatile(
            "mov ax,cs\n"
            "mov es,ax\n"
            "mov bx, OffSetOfUserPrg1\n"
            "mov ah,2\n"
            "mov al,1\n"
            "mov dl,0\n"
            "mov dh,0\n"
            "mov ch,0\n"
            "mov cl,3\n"
            "int 13H\n"
            "jmp OffSetOfUserPrg1\n"
            :
            :
            :);
    }else if()
}*/
