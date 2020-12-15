extern int _getC();
extern void _putC(int ch, int color);
extern void _putC(int ch, int color);
extern int _getCursor();
extern void _setCursor(int cur);
extern void _pageUP(int);
extern void _clear();
extern void _wait();

extern int strlen(char* s);
extern void gets(char* s);
extern void puts(const char* s);
extern void putchar(char c);
extern int strcmp(char str1[],char str2[]);
extern void upper(char* buf);


int main(){
    char* buf1 = "I am Tianrui hhhh";
    char* help1 = "please input a string: ";
    char* help2 = "buf1 is: ";
    char* help3 = "buf2 is: ";
    char* help4 = "length of buf2 is: ";
    char* help5 = "please input a char: ";
    char* help6 = "the char you have input is: ";
    char* help7 = "please input any key to continue";
    char newline = '\n';
    char buf2[100] = {0};
    char temp = 0;
    int len = 0;
    

    puts(buf1);
    puts(help1);
    gets(buf2);

    puts(help2);
    puts(buf1);
    puts(help3);
    puts(buf2);

    puts(help4);
    len = strlen(buf2);
    len = len + 48;
    putchar(len);
    putchar(newline);


    puts(help5);
    temp = _getC();
    puts(help6);
    _putC(temp,7);
    putchar(newline);

    puts(help7);
    _getC();

}