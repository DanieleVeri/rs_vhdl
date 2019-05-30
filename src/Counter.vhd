library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.ReedSolomon_package.all;

entity Counter is
    port(
        clk: in std_logic;
        parity: out std_logic);
end entity;

architecture RTL of Counter is
    signal counter: std_logic_vector (M-1 downto 0) := (others => '0');
begin 
    COUNT_PROC: process(clk)
    begin
        if(rising_edge(clk)) then
            if to_integer(unsigned(counter)) = 0 then
                parity <= '0';
            elsif to_integer(unsigned(counter)) = K then
                parity <= '1';
            end if;

            if to_integer(unsigned(counter)) = N then
                counter <= (others => '0');
            else
                counter <= std_logic_vector(unsigned(counter) + 1);
            end if;
        end if;
    end process;
end architecture;