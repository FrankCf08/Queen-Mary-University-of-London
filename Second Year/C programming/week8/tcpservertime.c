/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 8
	Excercise: 4
	Topic: TCP server time
************************************************************************************************/
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>


void error(char *msg){
	fprintf(stderr,"%s %s\n", msg, strerror(errno));
	exit(1);
}

char *now(){
	time_t t;
	time(&t);
	return asctime(localtime(&t));
}

int main(int argc, char *argv[]){
	char comment[] = "/Time";
	char cmd[120];//time from the PC

	int serverSockid, clientSockid;//socket file descriptor
	int portno;//port number on which the server accepts connections
	socklen_t clientLen;
	int n,i ;
	int j =0;
	char buffer[256];//server reads characters from the socket into this buffer

	struct sockaddr_in serv_addr, cli_addr;//socket structures for the internet addresses (struct sockaddr_in)

	if(argc<2)error("No port provided in cmd line");

	serverSockid = socket(PF_INET,SOCK_STREAM,0);//creates a stream socket that belongs to the INTERNET family

	if(serverSockid == -1) error("Cannot open listening socket");

	memset(&serv_addr,0, sizeof(serv_addr));// 0 --> for this case can be declared like that

	portno = atoi(argv[1]);

	/*Setting the individual fields of the sockaddr_in structure*/

	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port = htons(portno);

	/* binds socket to the address of the current host and port number on which the server will run*/

	if(bind(serverSockid, (struct sockaddr*)&serv_addr,sizeof(serv_addr)) == -1) error("Cannot bind to listening socket");

	/*listen on the socket for connections with a backlog queue of 5*/

	if(listen(serverSockid,5)==-1)error("Cannot listen");

	/*accept() causes the process to block until a client connect to the server*/

	clientLen = sizeof (cli_addr);

	while(1){

		clientSockid = accept(serverSockid, (struct sockaddr *)&cli_addr, &clientLen);

		if(clientSockid == -1) error("Server cannot accept client socket");

		/*client has succesfully connected to our server*/

		bzero(buffer,256); /*buffer is initialised and the server reads from the client socket descriptor*/

		n = read(clientSockid, buffer,255);//read()blocks until something to read
		if(n == -1) error("Server cannot read from client socket");

		n = strlen(buffer);
		char c[5]="/Time";
		for(i=0;i<5;i++){
			if(c[i]==buffer[i])
			{
				j++;
			}
		}

		if(j== 5){
			printf("Here is the message: %s\n", buffer);
			strcpy(cmd,now());
			/*Once a connection has been established, both ends can both read write to the connection*/
			n = write(clientSockid,cmd,sizeof(cmd));
		}
		else {
			n = write(clientSockid,"Not match",9);
		}
		if(n == -1) error("Server cannot wrote to client socket");

	}

	/*closing sockets before ending main*/
	close(serverSockid);
	close(clientSockid);

	return 0;
}
