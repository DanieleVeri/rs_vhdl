#include "sys/alt_stdio.h"

#define rs_out (volatile char *) 0x0003030
#define rs_in (volatile char *) 0x0003020
#define ack (volatile char *) 0x0003010
#define strobe (volatile char *) 0x0003000

char* itoa(unsigned char byte) {
	int i;
	char *result = "000";
	for(i = 0; i < 3; i++, byte /= 10) {
		result[2 - i] = (byte % 10 ) + '0';
	}
	return result;
}

int main() {
	int i;
	for (i = 0; i < 223; i++) {
		int c = alt_getchar();
		*rs_in = c < 0 ? 0 : c > 255 ? 255 : c;
		*ack = 1; *ack = 0;
		alt_printf("sym %s:", itoa((unsigned char)(i+1)));
		alt_printf("%s\n", itoa(*rs_out));
	}
	for (i = 0; i < 32; i++) {
		alt_printf("sym %s:", itoa((unsigned char)(i+224)));
		alt_printf("%s\n", itoa(*rs_out));
		*ack = 1; *ack = 0;
	}
	return 0;
}
