library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity Synchronizer is port (
	clk: in std_logic;
	sym_ack: in std_logic;
	hold: out std_logic);
end entity;

architecture RTL of Synchronizer is
	
	signal prev_ack: std_logic := '0';
	
begin
	process (clk) begin
		if (rising_edge(clk)) then
			hold <= '1';
			if sym_ack = '1' and prev_ack = '0' then
				hold <= '0';
			end if;
			prev_ack <= sym_ack;
		end if;
	end process;
end architecture;