library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity ReedSolomon is port(
	 CLOCK_50: in std_logic;
	 KEY : in std_logic_vector(0 downto 0));
end entity;

architecture RTL of ReedSolomon is
	component HostBridge is port(
	  clk_0 : in std_logic;
	  reset_n : in std_logic;
	  out_port_from_the_pio_1 : out std_logic_vector (7 downto 0);
	  in_port_to_the_pio_0 : in std_logic_vector (7 downto 0));
	end component;
	component RSEncoder is port(
		clk: in std_logic;
		rst: in std_logic;
		in_bus: in data_bus;
		out_bus: out data_bus);
	end component;

	signal uart_in: data_bus;
   signal uart_out: data_bus;
	
begin
	host_uart: HostBridge port map(CLOCK_50, KEY(0), uart_in, uart_out);
	encoder: RSEncoder port map(CLOCK_50, '0', uart_in, uart_out);
end architecture;