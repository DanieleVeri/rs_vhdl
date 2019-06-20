library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.ReedSolomon_package.all;

entity AdderModulo is port( 
	in_bus_0: in data_bus;
	in_bus_1: in data_bus;
	out_bus: out data_bus);
end entity;

architecture RTL of AdderModulo is
	component FullAdder is port(
		in_0: in std_logic;
		in_1: in std_logic;
		in_carry: in std_logic;
		out_carry: out std_logic;
		out_sum: out std_logic);
	end component;
	component Mux is port(
        in_bus_0: in data_bus;
        in_bus_1: in data_bus;
        selector: in std_logic;
        out_bus: out data_bus);
    end component;
	 
	subtype wider_bus is std_logic_vector(data_bus'length downto 0);

	constant modulo_sub: wider_bus := (wider_bus'length-1 => '1', others => '0');
	
	signal wider_bus_0: wider_bus;
	signal wider_bus_1: wider_bus;
	signal carry_sum: std_logic_vector(data_bus'length+1 downto 0) := (others => '0');
	signal carry_sub: std_logic_vector(data_bus'length+1 downto 0) := (others => '1');
	signal sum: wider_bus;
	signal sub: wider_bus;
	signal overflow: std_logic;

begin

	wider_bus_0 <= (data_bus'length downto in_bus_0'length => '0') & in_bus_0;
	wider_bus_1 <= (data_bus'length downto in_bus_1'length => '0') & in_bus_1;
	
	full_adders: for i in 0 to wider_bus'length-1 generate
		fa: FullAdder port map(wider_bus_0(i), wider_bus_1(i), carry_sum(i), carry_sum(i+1), sum(i));
	end generate;

	overflow <= '1' when (to_integer(unsigned(sum)) > 254) else '0';
	
	full_adders_mod: for i in 0 to wider_bus'length-1 generate
		fa: FullAdder port map(sum(i), modulo_sub(i), carry_sub(i), carry_sub(i+1), sub(i));
	end generate;
	
	out_mux: Mux port map(sum(wider_bus'length-2 downto 0), sub(wider_bus'length-2 downto 0), overflow, out_bus);
	
end architecture;