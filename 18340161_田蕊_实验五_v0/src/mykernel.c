#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25
//汇编里面定义的函数全都加_，C里面定义的不加，C里面extern到汇编里面要加_
typedef struct{
	int ax;   //+0          +0
	int bx;   //+2          +4
	int cx;   //+4          +8
	int dx;   //+6          +12
	int cs;   //+8          +16
	int ds;   //+10         +20 
	int es;   //+12         +24
	int ss;   //+14         +28
	int sp;   //+16         +32
	int bp;   //+18         +36
	int di;   //+20         +40
	int si;   //+22         +44
	int ip;   //+24         +48
	int flag; //+26         +52
} cpuRegister;

extern void _call_proc(char ch); 
extern int _getC();
extern int _getCursor();
extern void _pageUP(int);
extern void _setCursor(int cur);
extern void _putC(int ch, int color);
extern void _clear();
//extern void _save();
extern void _int20h();
extern void _int21h(int);
extern void _int22h();
extern void _wait();

cpuRegister reg;
cpuRegister* preg = &reg;

int strlen(char* s);
void gets(char *s);
void puts(const char *s);
void putchar(char c);

int deal(char* buf);
void upper(char* buf);
int jcontrol(int para,char* buf);
int strcmp(char str1[],char str2[]);
void saveReg(int ax,int bx,int cx,int dx,int ds,int es,int ss,int sp,int bp,int di,int si,int ip,int cs,int flag);

char getbuf[100] = {0};


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
		if(buf[0]=='R'&&buf[1]=='U'&&buf[2]=='N'){
			_call_proc(buf[4]);
		}else if(buf[0]=='I'&&buf[1]=='N'&&buf[2]=='T'&&buf[3]=='2'&&buf[4]=='1'&&buf[5]=='H'){
			if(buf[7]=='0'){
				_int21h(0);
				_wait();
			}else if(buf[7]=='1'){
				_int21h(1);
				//_wait();
			}else if(buf[7]=='2'){
				_int21h(2);
				puts(getbuf);
			}else if(buf[7]=='3'){
				_int21h(3);
			}	
		}else if(buf[0]=='I'&&buf[1]=='N'&&buf[2]=='T'&&buf[3]=='2'&&buf[4]=='2'&&buf[5]=='H'){
			_int22h();
			_wait();
		}else if(buf[0]=='I'&&buf[1]=='N'&&buf[2]=='T'&&buf[3]=='2'&&buf[4]=='0'&&buf[5]=='H'){
			_call_proc('A');
			_int20h();
			_wait();
		}
		
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

void puts(const char *s)
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
		puts("Command is wrong!");
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

void saveReg(int ax,int bx,int cx,int dx,int ds,int es,int ss,int sp,int bp,int di,int si,int ip,int cs,int flag){
	reg.ax = ax;
	reg.bx = bx;
	reg.cx = cx;
	reg.dx = dx;

	reg.ds = ds;
	reg.ss = ss;
	reg.es = es;
	reg.cs = cs;

	reg.di = di;
	reg.si = si;
	reg.bp = bp;
	reg.sp = sp;

	reg.ip = ip;
	reg.flag = flag;
}

