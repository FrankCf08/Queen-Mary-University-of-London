/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 9
	Excercise: 3
	Topic: UDP client
************************************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> /* Define structures for the server information*/

#define BUFSIZE 1024

/* error - wrapper for perror */
void error(char * msg) {
	perror(msg);
	exit(0);
}

int main(int argc, char * argv[]) {

	int sockfd, portno, n;
	socklen_t serverlen;
	struct sockaddr_in serveraddr;
	struct hostent * server;
	char * hostname;
	char buf[BUFSIZE];
	/* check command line arguments */

	if (argc != 3) {
		fprintf(stderr, "usage: %s <hostname> <port>\n", argv[0]);
		exit(0);
	}
	hostname = argv[1];
	portno = atoi(argv[2]);

	/* socket: create the socket */
	sockfd = socket(PF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0)
		error("ERROR opening socket");
	/* gethostbyname: get the server's DNS entry */
	server = gethostbyname(hostname);
	if (server == NULL) {
		fprintf(stderr, "ERROR, no such host as %s\n", hostname);
		exit(0);
	}
	/* build the server's Internet address */

	memset(&serveraddr, 0, sizeof(serveraddr));
	serveraddr.sin_family = AF_INET;
	bcopy((char *)server -> h_addr,(char *)&serveraddr.sin_addr.s_addr, server->h_length);
	serveraddr.sin_port = htons(portno);

	/* get a message from the user */

	memset(buf, 0, BUFSIZE);
	printf("Please enter msg: ");
	fgets(buf, BUFSIZE, stdin);

	/* send the message to the server */

	serverlen = sizeof(serveraddr);
	n = sendto(sockfd, buf, strlen(buf), 0, (struct sockaddr * )&serveraddr, serverlen);
	if (n < 0) error("ERROR in sendto");

	/* print the server's reply */

	n = recvfrom(sockfd, buf, strlen(buf), 0, (struct sockaddr * )&serveraddr, &serverlen);
	if (n < 0) error("ERROR in recvfrom");
	printf("Echo from server: %s\n", buf);
	close(sockfd);
	return 0;
}
