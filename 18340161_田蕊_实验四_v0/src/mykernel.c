#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

extern void _call_proc(char ch); 
extern int _getC();
extern int _getCursor();
extern void _pageUP(int);
extern void _setCursor(int cur);
extern void _putC(int ch, int color);
extern void _clear();


int strlen(char* s);
void gets(char *s);
void printf(const char *s);
void putchar(char c);

int deal(char* buf);
void upper(char* buf);
int jcontrol(int para,char* buf);
int strcmp(char str1[],char str2[]);
//char buf[100];


char a[13] = "here is main\n";
char b[25] = "please input instruction:";


void main(){
	int para = 0;
	int i=0;
	
	
	while(1){
		char buf[100] = {0};
		for(i=0;i<100;i++){
			buf[i] = 0;
		}
		_clear();
		_setCursor(0);
		gets(buf);
		upper(buf);
		_call_proc(buf[4]);
	}
	
}

int strlen(char* s){
	int ret;
	ret = 0;
	for(;*s;++s){
		ret++;
	}
	return ret;
}

void gets(char *s)
{
	for (;; ++s)
	{
		putchar(*s = _getC());
		if (*s == '\r' || *s == '\n')
			break;
	}
	*s = 0;
}

void printf(const char *s)
{
	for (; *s; ++s)
		putchar(*s);
}

void putchar(char c)
{
	int cur = _getCursor(), curX = cur >> 8, curY = cur - (curX << 8);
	if (c == '\r' || c == '\n')
	{
		if (++curX >= SCREEN_HEIGHT){
			--curX;
			//_pageUP(1);
		}
			
		return _setCursor(curX << 8);
	}
	_putC(c, 0x07);
	if (++curY >= SCREEN_WIDTH)
		putchar('\n');
	_setCursor(curX << 8 | curY);
}

int deal(char* buf){
	int len = strlen(buf);
	int ret = 0;
	int i = 0;
	upper(buf);
	for(i=0;i<len;i++){
		
		if(buf[i]==' '){
			ret = i;
			break;
		} 
	}
	
	return ret;	
	
}

void upper(char* buf){
	int len = strlen(buf);
	int i;
	for (i = 0; i < len; ++i)
	if ('a' <= buf[i] && buf[i] <= 'z') 
		buf[i] -= 'a' - 'A';
	
}

int jcontrol(int para,char* buf){
	char temp[100];
	char* run = "RUN";
	char para1;
	int i=0;
	for(i=0;i<para;i++){
		temp[i] = buf[i];
	}
	temp[para] = '\0';
	
	if(strcmp(temp,run)==0){
		para1 = buf[4];
		_call_proc(para1);
	}else{
		printf("Command is wrong!");
	}
	//para1 = buf[4];
	//_call_proc(para1);
	return 0;
}

int strcmp(char str1[],char str2[]){
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int i = 0, j = 0;
	while (i < len1 && j < len2 && str1[i] == str2[j])
	{
		i++;
		j++;
	}
	return (str2[j] - str1[i]);
	
}

