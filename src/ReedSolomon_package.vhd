library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package ReedSolomon_package is

   constant N: integer := 255; --
   constant K: integer := 223; --
   constant M: integer := 8; --
		
	constant gf_overflow: integer := 2**M-2;
   
   subtype data_bus is std_logic_vector(M-1 downto 0);
	type parity_bus is array(N-K-1 downto 0) of data_bus;
	
	constant generator_polynomial : parity_bus := ( --
		"01110100",
		"01000000",
		"00110100",
		"10101110",
		"00110110",
		"01111110",
		"00010000",
		"11000010",
		"10100010",
		"00100001",
		"00100001",
		"10011101",
		"10110000",
		"11000101",
		"11100001",
		"00001100",
		"00111011",
		"00110111",
		"11111101",
		"11100100",
		"10010100",
		"00101111",
		"10110011",
		"10111001",
		"00011000",
		"10001010",
		"11111101",
		"00010100",
		"10001110",
		"00110111",
		"10101100",
		"01011000");

end package;