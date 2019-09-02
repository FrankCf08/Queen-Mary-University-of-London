/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 9
	Excercise: 1
	Topic: network configuration
************************************************************************************************/
#include <stdio.h>
#include <unistd.h>// It is needed for the exec() functions
#include <errno.h>// it is needed for the errno variable
#include <string.h>//It will let you display errors with strerror()
int main()
{
	/* try to run the "/sbin/ifconfig" program firstly*/
	if (execl("/sbin/ifconfig","/sbin/ifconfig",NULL) == -1){//If execl() returns -1, it failed, so we should probably look for ipconfig
		/* if failed, try the “ipconfig” command*/
		if (execlp("ipconfig", "ipconfig",NULL) == -1){//excelp() will let us find the ipconfig command on the path
			fprintf(stderr,"Cannot run ipconfig: %s",strerror(errno)); //strerror will display any error
			return 1;
		}
	}
	return 0;
}
