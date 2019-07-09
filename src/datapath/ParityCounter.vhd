library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.ReedSolomon_package.all;

entity ParityCounter is port(
	rst_a: in std_logic;
   clk: in std_logic;
	enable: in std_logic;
	parity2: out std_logic;
   parity: out std_logic);
end entity;

architecture RTL of ParityCounter is

   signal counter: data_bus;

begin 
	COUNT_PROC: process(clk, rst_a) begin
		if(rst_a = '1') then
			counter <= (others => '0');
			parity <= '0';
			parity2 <= '0';
		elsif(rising_edge(clk)) then
			if enable = '1' then
				counter <= std_logic_vector(unsigned(counter)+1);
				if to_integer(unsigned(counter)) = K then
					parity2 <= '1';
				elsif to_integer(unsigned(counter)) = K-1 then
					parity <= '1';
				elsif to_integer(unsigned(counter)) = N then
					parity <= '0';
					parity2 <= '0';
					counter <= (others => '0');
				end if;
			end if;
		end if;
	end process;
end architecture;