/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 9
	Excercise: 4
	Topic: 	UDP server
************************************************************************************************/
#include <stdio.h>
#include <stdlib.h>//Neccesary for exit()
#include <string.h>//Neccesary for memset()
#include <netdb.h>/**Needed in UDP servers too**/
#include <sys/types.h> /**define some data types used in system calls**/
#include <sys/socket.h>/**Definitions of structures needed for sockets**/
#include <netinet/in.h>/**constants and structures needed for internet domanin addresses**/
#include <arpa/inet.h> // It's needed because inet_ntoa()
#include <math.h>

#define BUFSIZE 1024

/*ERROR-Wrapper for perror*/
void error(char *msg){
	perror(msg);
	exit(0);
}

power(int i)
{
	int j,p=1;
	for(j=1;j<=i;j++)
		p = p*2;
	return(p);
}

int covertBinToDec (long int n){
	int x,s=0,i=0,flag=1;
	while(flag==1){
		x=n%10;
		s=s+x*power(i);
		i=i+1;
		n=n/10;
		if(n==0)
			flag=0;
	}
	return s;
}

int main(int argc, char *argv[]){
	int sockid; // socket
	int portno; // port to listen on
	socklen_t clientlen; //byte size of client's address

	struct sockaddr_in serveraddr; // server's addr
	struct sockaddr_in clientaddr; // client's addr
	struct hostent *hostp; // client host info

	char buf[BUFSIZE];//message buf
	char msg[BUFSIZE];//sent message
	long int binary;
	char *hostaddrp;// dotted decimal host addr string

	int optval; // flag value for setsockopt
	int n;

	/*check command line arguments*/
	if(argc !=2){
		fprintf(stderr, "usage: %s<port>\n",argv[0]);
		exit(1);
	}

	portno = atoi(argv[1]);// Takes argument in cmd line for the port as integer

	/*socket: create the parent socket*/
	sockid = socket(PF_INET,SOCK_DGRAM,0);
	if(sockid<0){
		error("ERROR opening socket");
	}

	/*setockopt:
		* Handy debug trick that lets rerun the server immediately after being killed
		* Otherwise one needs to wait about 20 secs.
		* Eliminates "Error on binding: Address already in use" error.
	*/
	optval = 1;
	setsockopt(sockid,SOL_SOCKET, SO_REUSEADDR, (const void*)&optval,sizeof(int));

	/*Build the server's INternet Address*/

	memset(&serveraddr,0,sizeof(serveraddr));
	serveraddr.sin_family = AF_INET;
	serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
	serveraddr.sin_port = htons(portno);

	/*Bind: assocaute the parent socket with a port*/

	if(bind(sockid, (struct sockaddr*)&serveraddr, sizeof(serveraddr))<0) error("Error on binding");

	/*Main Loop: wait for datagram, then echo it*/

	clientlen = sizeof(clientaddr);

	while(1){
		/*recvfrom: receive a UDP datagram from a client*/

		memset(buf,0,BUFSIZE);
		n = recvfrom(sockid,buf,BUFSIZE,0,(struct sockaddr *)&clientaddr,&clientlen);
		if(n<0) error("ERROR in recvfrom");

		/*Converting the buf char array into a long int*/

		binary = atol(buf);
		sprintf(msg,"%li", covertBinToDec (binary));

		/*gethostbyaddr: determine who setn the datagram*/

		hostp = gethostbyaddr((const char*)&clientaddr.sin_addr.s_addr,sizeof(clientaddr.sin_addr.s_addr),AF_INET);
		if(hostp == NULL) error("ERROR on gethostbyaddr");

		hostaddrp = inet_ntoa(clientaddr.sin_addr);

		if(hostaddrp == NULL) error("ERROR on inet_ntoa");

		printf("Server received datagram from %s (%s)\n", hostp -> h_name,hostaddrp);
		printf("Server reveived %lu/%d bytes: binary = %li\n",strlen(buf),n,binary,buf);

		/*sendto: echo the input back to the client*/
		n =sendto(sockid,msg,strlen(buf),0,(struct sockaddr *)&clientaddr,clientlen);
		if(n<0) error("Error in sendto");
	}
	return 0;
}
