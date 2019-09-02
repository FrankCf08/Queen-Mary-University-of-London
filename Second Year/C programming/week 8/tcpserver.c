/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 8
	Excercise: 3
	Topic: TCP server
************************************************************************************************/
#include <stdio.h> // TCP client Example
#include <sys/types.h>// Header needed for the socket
#include <sys/socket.h>// Header needed for the socket
#include <netdb.h> // constants and structures needed for internet domain address
#include <errno.h>// Neccesary because errno value used
#include <string.h>//needed for bzero()
#include <stdlib.h>//necessary for exit()


void error(char *msg){
	fprintf(stderr,"%s %s\n", msg, strerror(errno));
	exit(1);
}

int main(int argc, char *argv[]){

	int serverSockid, clientSockid;//socket file descriptor
	int portno;//port number on which the server accepts connections
	socklen_t clientLen;
	int n;
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

		printf("Here is the message: %s\n", buffer);

		/*Once a connection has been established, both ends can both read write to the connection*/

		n = write(clientSockid,"I got your message",18);
		if(n == -1) error("Server cannot wrote to client socket");
	}

	/*closing sockets before ending main*/
	close(serverSockid);
	close(clientSockid);

	return 0;
}


/*
	creating socket prototype: int socket(int domain, int type, int protocol)
		*domain:
			-IPv4: PF_INET
			-IPv6: PF_INET6
			-Local communication (FIle addresses) : PF_UNIX
		*type:
			-SOCK_STREAM (treat communications as continuous stream of character)
			- SOCK_DGRAM ( have to read entire messages at once)
		*protocol:
			-IPPROTO_TCP
			-IPPROTO_UDP

		*RETURNS: a socket descriptors

		*Example:
			struct sockaddr_in {
				unsigned short sin_family;Internet protocol (AF_INET)
				unsigned short sin_port;Address port (16 bits)
				struct in_addr sin_addr; nternet address (32 bits)
				char sin_zero [8]; Not used
}
	closing a Socket in c prototype : int close(int sockid)
		*sockid: the file descripto
		*RETURNS: 0 if successful
			  -1 if error
		*Example: status = close (sockid);

	Binding the port:

		int bind(int sockid, struct sockaddr *my_addr, socklen_t addrlen)

			*sockid: is the socket file descriptor returned by socket()

			*my_addr: is a pointer to a struct sockaddr that contains information about the port and IP address of the host*(for TCP/IP, it usuallt sets to INADDR_ANY)

			*addrlen: is the length in bytes of that sockaddr

			*RETURN: upon failure -1 is returned

			*Example:

				if(bind(sockid, (struct sockaddr *)&addrport, sizeof(addrport))!= -1) {…}

	listen() System call :

			int listen ( int sockid, int backlog);

		*sockid: is the socket "file descriptor" from the socket()
		*backlog: is the number of connections allowed on the incomming queue.
		*RETURNS: 0 if listenning, -1 if error

		*Example:
				status = listen(sockid, queueLimit);
*/
