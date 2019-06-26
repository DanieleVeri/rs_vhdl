library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity ParityCounterTb is
end entity;

architecture SIM of ParityCounterTb is
    signal clk: std_logic := '0';
    signal parity: std_logic := '0';
begin

    clk <= not clk after 10 ns;
    counter: entity work.ParityCounter(RTL) port map(
        clk => clk,
		  enable => '1',
        parity => parity);

end architecture;