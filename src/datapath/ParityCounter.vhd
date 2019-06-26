library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.ReedSolomon_package.all;

entity ParityCounter is port(
   clk: in std_logic;
	enable: in std_logic;
   parity: out std_logic);
end entity;

architecture RTL of ParityCounter is

   signal counter: data_bus := (others => '0');

begin 
	COUNT_PROC: process(clk) begin
		if(rising_edge(clk)) then
			if enable = '1' then
				if to_integer(unsigned(counter)) = K+1 then
					parity <= '1';
					counter <= std_logic_vector(unsigned(counter) + 1);
				elsif to_integer(unsigned(counter)) = N then
					parity <= '0';
					counter <= (others => '0');
				else
					counter <= std_logic_vector(unsigned(counter) + 1);
				end if;
			end if;
		end if;
	end process;
end architecture;