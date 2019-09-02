/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 8
	Excercise: 2
	Topic: TCP client
************************************************************************************************/
#include <stdio.h>
#include <sys/types.h>//define some data types used in systems calls
#include <sys/socket.h>//definitions of strucuture needed for scokets
#include <netinet/in.h>//constants and structures needed for internet domain addresses
#include <netdb.h>//define structures to the server information
#include <errno.h> // neccesary because errno value used
#include <string.h>//neccesary for memset
#include <stdlib.h>//neccesary for exit()

void error (char *msg){
	fprintf(stderr, "%s %s\n",strerror(errno));
	exit(1);
}

int main(int argc, char *argv[]){
	int sockFiled;//Socket file descriptor
	int portno;//port number of the server that this client wants to connect
	int n;
	struct sockaddr_in serv_addr; // socket structures for the internet addresses
	struct hostent *server;//pointer to a structure to type hosten, define in netdb.h

	char buffer[256];

	if(argc<3){
		fprintf(stderr, "Usage %s hostname port\n", argv[0]);
		exit(0);
	}
	portno = atoi(argv[2]);//takes the 3 argument in cmd line for the port as interger

	sockFiled = socket(PF_INET,SOCK_STREAM,0);//creates client socket

	if(sockFiled == 1) error("ERROR openning client socket");

	server = gethostbyname(argv[1]);//Takes the host name www.google.com return

	if(server == NULL){
		fprintf(stderr, "ERROR,no such host\n");
		exit(0);
	}

	/*set the fields in serv_addr*/
	memset(&serv_addr,0, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	bcopy((char *)server->h_addr,(char *)&serv_addr.sin_addr.s_addr,server->h_length);
	serv_addr.sin_port = htons(portno);

	/*Connecting to server*/
	if(connect(sockFiled,(struct sockaddr *)&serv_addr,sizeof(serv_addr))==-1)error("ERROR connecting to server");

	printf("PLease enter the message: ");
	memset(buffer,0,256);// Eg. memset(buffer, 0, 256);
	fgets(buffer,255,stdin);

	/*Sending the message to the server*/
	n = write(sockFiled,buffer,strlen(buffer));
	if(n==-1) error("Client: ERROR writing to socket");
	memset(buffer,0,256);//Eg. memset(buffer, 0, 256);

	/*Reading message back from server*/
	n = read(sockFiled,buffer,255);
	if(n == -1) error("Client: ERROR reading from socket");
	printf("%s\n",buffer);

	/*CLosing client socket*/
	close(sockFiled);

	return 0;
}
