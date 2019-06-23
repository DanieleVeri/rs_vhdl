library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package ReedSolomon_package is

   constant N: integer := 255;
   constant K: integer := 223;
   constant M: integer := 8;
	
	constant gf_overflow: integer := 254;
   
   subtype data_bus is std_logic_vector(M-1 downto 0);
	type parity_bus is array(N-K-1 downto 0) of data_bus;
	
	constant generator_polynomial : parity_bus := (
		"01011000",
		"10101100",
		"00110111",
		"10001110",
		"00010100",
		"11111101",
		"10001010",
		"00011000",
		"10111001",
		"10110011",
		"00101111",
		"10010100",
		"11100100",
		"11111101",
		"00110111",
		"00111011",
		"00001100",
		"11100001",
		"11000101",
		"10110000",
		"10011101",
		"00100001",
		"00100001",
		"10100010",
		"11000010",
		"00010000",
		"01111110",
		"00110110",
		"10101110",
		"00110100",
		"01000000",
		"01110100");

end package;