library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity SymbolRegister is port(
    clk: in std_logic;
    d_bus: in data_bus;
    q_bus: out data_bus);
end entity;

architecture RTL of SymbolRegister is
begin 

    process(clk)
    begin
        if(rising_edge(clk)) then
            q_bus <= d_bus;
        end if;
    end process;
    
end architecture;