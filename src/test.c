#include<stdio.h>
#include<unistd.h>
#include<poll.h>

int xxmain(int argc, char *argv[]) {
	int pn, rn;
	char buf[1024];
	struct pollfd pfds[2];

	pfds[0].fd = STDIN_FILENO;
	pfds[0].events = POLLIN;
	pn = poll(pfds, 1, 5000);

	if (pn == 0) {
		printf("timeout\n");
		return 1;
	}

	
	rn = read(STDIN_FILENO, buf, 1024);
	printf("READ STDIN:\n%s\n", buf);
	return 1;

}
