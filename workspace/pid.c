#include "apue.h"

int main(void){
	printf("from process ID %ld\n", (long)getpid());
	exit(0);
}
