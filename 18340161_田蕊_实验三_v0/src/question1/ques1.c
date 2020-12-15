int global = 0;

int f(int a,int b){
	if(a>b) global = a;
	else global = b;
	return global;
}

int main(){
	int temp[2] = {0};
	int res = 0;
	temp[0] = 100;
	temp[1] = 50;
	res = f(temp[0],temp[1]);
	return 0;
}