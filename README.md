# Reed Solomon encoder attraverso il modulo UART - JTAG

Target board: Altera CycloneII - EP2C20F484C7

N: 255
K: 223
T: 16
M: 8

Primitive polynomial: p(x) = 285

Generator polynomial: g(z) =
    45 + 216z + 239z<sup>2</sup> + 24z<sup>3</sup> + 253z<sup>4</sup> + 104z<sup>5</sup> + 27z<sup>6</sup> + 40z<sup>7</sup> + 107z<sup>8</sup> + 50z<sup>9</sup> + 163z<sup>10</sup> + 210z<sup>11</sup> + 227z<sup>12</sup> + 134z<sup>13</sup> +
    224z<sup>14</sup> + 158z<sup>15</sup> + 119z<sup>16</sup> + 13z<sup>17</sup> + 158z<sup>18</sup> + z<sup>19</sup> + 238z<sup>20</sup> + 164z<sup>21</sup> + 82z<sup>22</sup> + 43z<sup>23</sup> + 15z<sup>24</sup> + 232z<sup>25</sup> +
    246z<sup>26</sup> + 142z<sup>27</sup> + 50z<sup>28</sup> + 189z<sup>29</sup> + 29z<sup>30</sup> + 232z<sup>31</sup> + z<sup>32</sup>

## Reed Solomon

Reed Solomon è un codice a correzione di errore usato in molte applicazioni: dalle comunicazioni dei satelliti ai codici a barre ai CDROM.

Un codice RS è un codice a correzione di  errore ciclico che usa pattern di simboli invece che di bit per trasmettere e ricevere messaggi.

Ogni simbolo è costituito da m bit e la relazione tra bit e simboli viene fatta attraverso la teoria dei Campi Finiti. 

### Campi finiti di Galois

In matematica, un campo è un insieme di elementi nel quale sono definite le operazioni di somma e prodotto. Queste operazioni sono commutative, associative e chiuse, ovvero che il risultato dell’operazione tra due elementi qualunque dell’insieme è ancora appartenete all’insieme.

 Un campo ha anche valori identità alla somma e prodotto, da cui deriva che gli elementi di un campo hanno inversi additivi e moltiplicativi.

I campi finiti di Galois esistono con m elementi per ogni  p primo: dato che i numeri binari possono essere rappresentati con 2 valori possibili (0 o 1) e che 2 è un numero primo, è possibile trovare un campo finito per un insieme di numeri binari.

## Comunicazione PC - FPGA

La comunicazione tra PC (host) e FPGA consiste in uno stream seriale di caratteri e avviene tramite il modulo JTAG che permette di inviare e ricevere dati usando il protocollo UART.
L’FPGA Altera contiene un circuito di controllo tra i pin JTAG del dispositivo e la logica interna. 
Il dispositivo viene connesso al PC tramite il cavo USB di download, per essere riconosciuto dall’ host è necessario che quest’ultimo installi i driver dell’USB Blaster di altera, che permettono di interfacciarsi con il JTAG server presente sulla scheda. 

![sopc schema](doc/img/SOPC.png)

Il modulo SOCP(system-on-a-programmable-chip) builder messo a disposizione dall’ide Quartus II permette di definire un sistema complesso partendo da un diagramma a blocchi. Tra gli IP cores disponibili è stato usato il modulo Nios2, ovvero un processore RISC a 32 bit (circa 700 LEs) che eseguirà le istruzioni necessarie per interfacciare la rete con il modulo JTAG UART.

```c
#include "sys/alt_stdio.h"
#define rs_out (volatile char *) 0x0003030
#define rs_in (volatile char *) 0x0003020
#define ack (volatile char *) 0x0003010

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
		   *rs_in = alt_getchar();
		   *ack = 1; *ack = 0;
		   alt_printf("sym %s:", itoa((unsigned char)(i+1)));
		   alt_printf("%s\n", itoa(*rs_out));

 	}
	*ack = 1; *ack = 0;
	for (i = 0; i < 32; i++) {
		   alt_printf("sym %s:", itoa((unsigned char)(i+224)));
		   alt_printf("%s\n", itoa(*rs_out));
		   *ack = 1; *ack = 0;
	}
	return 0;
}
```

Altera mette a disposizione una command-line utility: nios2-terminal che apre una sessione terminale con il core JTAG UART, occupandosi della gestione della connessione e della decodifica dello stream dei dati mostrandoli a schermo.
___
// immagine generazione sopc builder
___

I driver del dispositivo sono forniti dalla libreria di sistema HAL (Hardware Abstraction Layer) che viene generata a partire dal design del sistema SOPC, la quale permette di interfacciarsi con il core JTAG UART attraverso chiamate a funzioni della libreria ANSI C stdio.h.

I sorgenti VHDL generati che costituiscono il processore NIOS2 e il modulo JTAG-UART vengono inclusi nella main entity del progetto

```vhdl
component HostBridge is port(
    clk_0: in std_logic;
    reset_n: in std_logic;
    out_port_from_the_rs_in_symbol: out std_logic_vector (7 downto 0);
    in_port_to_the_rs_out_symbol: in std_logic_vector (7 downto 0);
    out_port_from_the_symbol_ack: out std_logic);
end component;
```
