library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity RSEncoder is port(
	clk: in std_logic;
	rst: in std_logic;
	hold: in std_logic;
	in_bus: in data_bus;
	out_bus: out data_bus);
end entity;

architecture RTL of RSEncoder is
	component ParityCounter is port(
		 clk: in std_logic;
		 enable: in std_logic;
		 parity: out std_logic);
	end component;
	component SymbolRegister is port(
		 clk: in std_logic;
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

	signal parity_count: std_logic := '0';
	
	signal chain_input: data_bus := (others=>'0');
	signal feedback_sum: data_bus := (others=>'0');

	signal ffd: parity_bus := (others=>(others=>'0'));
	signal ffq: parity_bus := (others=>(others=>'0'));
	signal products: parity_bus := (others=>(others=>'0'));
	
	signal ffhold: parity_bus := (others=>(others=>'0'));
	
begin
	parity_counter: ParityCounter port map(clk, not hold, parity_count);
	feedback_mux: Mux port map(in_bus, ffq(parity_bus'length-1), parity_count, chain_input);
	
	galois_multipliers: for i in 0 to parity_bus'length-1 generate
		ffhold(i) <= ffd(i) when hold = '0' else ffq(i);
		ff: SymbolRegister port map(clk, ffhold(i), ffq(i));
		gf_mul: GfMul port map(generator_polynomial(i), feedback_sum, products(i));
	end generate;
	
	ffd(0) <= products(0);
	galois_adders: for i in 1 to parity_bus'length-1 generate
		gf_sum: GfSum port map(products(i), ffq(i-1), ffd(i));
	end generate;
	
	fb_sum: GfSum port map(ffq(parity_bus'length-1), chain_input, feedback_sum);
	
	out_mux: Mux port map(in_bus, ffq(parity_bus'length-1), parity_count, out_bus);
end architecture;