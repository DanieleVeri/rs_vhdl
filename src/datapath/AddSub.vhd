library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity AddSub is port( 
	in_bus_0: in data_bus;
	in_bus_1: in data_bus;
	sub: in std_logic;
	out_carry: out std_logic;
	out_bus: out data_bus);
end entity;

architecture RTL of AddSub is

	component FullAdder is port(
		in_0: in std_logic;
		in_1: in std_logic;
		in_carry: in std_logic;
		out_carry: out std_logic;
		out_sum: out std_logic);
	end component;

	signal carry: data_bus := (others => '0');
	signal addend: data_bus;

begin

	add_or_sum: for i in 0 to data_bus'length-1 generate
		addend(i) <= in_bus_1(i) xor sub;
	end generate;

	fa: FullAdder port map(in_bus_0(0), addend(0), sub, carry(0), out_bus(0));
	full_adders: for i in 1 to data_bus'length-1 generate
		fa: FullAdder port map(in_bus_0(i), addend(i), carry(i-1), carry(i), out_bus(i));
	end generate;

	out_carry <= carry(data_bus'length-1) xor sub;
	
end architecture;
