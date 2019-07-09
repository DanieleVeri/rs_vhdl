library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity SymbolRegister is port(
	rst_a: in std_logic;
   clk: in std_logic;
   d_bus: in data_bus;
   q_bus: out data_bus);
end entity;

architecture RTL of SymbolRegister is
begin 
    process(clk, rst_a)
    begin
		  if(rst_a = '1') then
				q_bus <= (others => '0');
        elsif(rising_edge(clk)) then
            q_bus <= d_bus;
        end if;
    end process;
end architecture;