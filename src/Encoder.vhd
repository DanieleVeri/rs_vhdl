library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity RSEncoder is port(
	dbg: out data_bus;
	clk: in std_logic;
	rst_a: in std_logic;
	hold: in std_logic;
	in_bus: in data_bus;
	out_bus: out data_bus);
end entity;

architecture RTL of RSEncoder is
	component ParityCounter is port(
		rst_a: in std_logic;
		clk: in std_logic;
	   enable: in std_logic;
		parity: out std_logic);
	end component;
	component SymbolRegister is port(
		rst_a: in std_logic;
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

	signal parity_count: std_logic;
	signal feedback: data_bus;
	signal feedback_sum: data_bus;
	signal ffd: parity_bus;
	signal ffq: parity_bus;
	signal products: parity_bus;
	signal ffhold: parity_bus;
	
begin
	ffholds: for i in 0 to parity_bus'length-1 generate
		ffhold(i) <= ffd(i) when hold = '0' else ffq(i);
	end generate;

	regs: for i in 0 to parity_bus'length-1 generate
		ff: SymbolRegister port map(rst_a, clk, ffhold(i), ffq(i));
	end generate;

	galois_multipliers: for i in 0 to parity_bus'length-1 generate
		gf_mul: GfMul port map(generator_polynomial(i), feedback, products(i));
	end generate;
	
	ffd(0) <= products(0);
	galois_adders: for i in 1 to parity_bus'length-1 generate
		gf_sum: GfSum port map(products(i), ffq(i-1), ffd(i));
	end generate;
	
	fb_sum: GfSum port map(ffq(parity_bus'length-1), in_bus, feedback_sum);
	
	parity_counter: ParityCounter port map(rst_a, clk, not hold, parity_count);
	feedback_mux: Mux port map(feedback_sum, (others => '0'), parity_count, feedback);
	out_mux: Mux port map(in_bus, ffq(parity_bus'length-1), parity_count, out_bus);
	
	dbg <= ffd(parity_bus'length-1);
end architecture;