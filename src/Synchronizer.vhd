library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity Synchronizer is port (
	clk: in std_logic;
	rst_a: in std_logic;
	sym_ack: in std_logic;
	enable_rs: out std_logic);
end entity;

architecture RTL of Synchronizer is
	
	signal prev_ack: std_logic;
	
begin
	process (clk) begin
		if (rst_a = '1') then 
			prev_ack <= '0';
			enable_rs <= '0';
		elsif (rising_edge(clk)) then
			enable_rs <= '0';
			if sym_ack = '1' and prev_ack = '0' then
				enable_rs <= '1';
			end if;
			prev_ack <= sym_ack;
		end if;
	end process;
end architecture;