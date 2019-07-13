library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity RSDecoder is port(
	dbg: out data_bus;
	clk: in std_logic;
	rst_a: in std_logic;
	enable: in std_logic;
	in_bus: in data_bus;
	out_bus: out data_bus);
end entity;

architecture RTL of RSDecoder is
	component ParityCounter is port(
		rst_a: in std_logic;
		clk: in std_logic;
	   enable: in std_logic;
		finish: out std_logic);
	end component;
	component SymbolRegister is port(
		clk: in std_logic;
		rst_a: in std_logic;
		enable: in std_logic;
		d_bus: in data_bus;
		q_bus: out data_bus);
	end component;
	component Mux is port(
		in_bus_0: in data_bus;
		in_bus_1: in data_bus;
		selector: in std_logic;
		out_bus: out data_bus);
	end component;
	component GfSum is port(
		in_bus_0: in data_bus;
		in_bus_1: in data_bus;
		out_bus: out data_bus);
	end component;
	component GfMul is port(
		in_bus_0: in data_bus;
		in_bus_1: in data_bus;
		out_bus: out data_bus);
	end component;

	signal finish: std_logic;
	signal out_selector: std_logic;
	signal parity_symbol: data_bus;
	signal feedback: data_bus;
	signal sum: data_bus;
	signal ffd: parity_bus;
	signal ffq: parity_bus;
	signal products: parity_bus;
	
begin
	regs: for i in 0 to parity_bus'length-1 generate
		ff: SymbolRegister port map(clk, rst_a, enable, ffd(i), ffq(i));
	end generate;

	gfmuls: for i in 0 to parity_bus'length-1 generate
		gf_mul: GfMul port map(generator_polynomial(i), feedback, products(i));
	end generate;
	
	sum <= in_bus when finish='0' else (others => '0');
	
	parity_counter: ParityCounter port map(clk, rst_a, enable, finish);
	
	gf_sum: GfSum port map(products(0), sum, ffd(0));
	gfadds: for i in 1 to parity_bus'length-1 generate
		gf_sum: GfSum port map(products(i), ffq(i-1), ffd(i));
	end generate;
		
	feedback <= ffq(parity_bus'length-1);
	
	dbg <= feedback;
end architecture;