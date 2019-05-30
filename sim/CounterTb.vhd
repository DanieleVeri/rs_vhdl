library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CounterTb is
end entity;

architecture SIM of CounterTb is
    signal clk: std_logic := '0';
    signal parity: std_logic := '0';
begin
    counter: entity work.Counter(RTL) port map(
        clk => clk,
        parity => parity);

    process is
    begin
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
    end process;
end architecture;