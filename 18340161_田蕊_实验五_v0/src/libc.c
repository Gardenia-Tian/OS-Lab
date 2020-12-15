#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25
extern int _getC();
extern void _putC(int ch, int color);
extern int _getCursor();
extern void _setCursor(int cur);
extern void _pageUP(int);
extern void _clear();
extern void _wait();


int strlen(char* s){
	int ret;
	ret = 0;
	for(;*s;++s){
		ret++;
	}
	return ret;
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
	char newline = '\n';
	for (; *s; ++s)
		putchar(*s);

	putchar(newline);
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

void upper(char* buf){
	int len = strlen(buf);
	int i;
	for (i = 0; i < len; ++i)
	if ('a' <= buf[i] && buf[i] <= 'z') 
		buf[i] -= 'a' - 'A';
	
}