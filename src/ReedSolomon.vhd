library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity ReedSolomon is port(
	 CLOCK_50: in std_logic;
	 LEDR: out std_logic_vector(7 downto 0);
	 KEY : in std_logic_vector(0 downto 0));
end entity;

architecture RTL of ReedSolomon is
	component HostBridge is port(
		clk_0: in std_logic;
		reset_n: in std_logic;
		out_port_from_the_rs_in_symbol: out std_logic_vector(7 downto 0);
		in_port_to_the_rs_out_symbol: in std_logic_vector(7 downto 0);
		out_port_from_the_symbol_ack: out std_logic);
	end component;
	component Synchronizer is port (
		clk: in std_logic;
		rst_a: in std_logic;
		sym_ack: in std_logic;
		enable_rs: out std_logic);
	end component;
	component RSDecoder is port(
		dbg: out data_bus;
		clk: in std_logic;
		rst_a: in std_logic;
		enable: in std_logic;
		in_bus: in data_bus;
		out_bus: out data_bus);
	end component;

	signal uart_symbol_in: data_bus;
   signal uart_symbol_out: data_bus;
	signal uart_symbol_ack: std_logic;
	signal enable_rs: std_logic;
	
begin
	host_uart: HostBridge port map(CLOCK_50, KEY(0), uart_symbol_in, uart_symbol_out, uart_symbol_ack);
	sync: Synchronizer port map(CLOCK_50, not KEY(0), uart_symbol_ack, enable_rs);
	encoder: RSDecoder port map(LEDR, CLOCK_50, not KEY(0), enable_rs, uart_symbol_in, uart_symbol_out);
end architecture;