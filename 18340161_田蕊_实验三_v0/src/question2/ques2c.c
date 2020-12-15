int count(char* a,int b){
	int i = 0;
	int cnt = 0;
	for(i=0;i<b;i++){
		if(a[i]=='a') cnt++;
	}
	return cnt;
}
