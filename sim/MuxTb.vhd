library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity MuxTb is
end entity;

architecture SIM of MuxTb is
    signal in_bus_0: data_bus := (others => '0');
    signal in_bus_1: data_bus := (others => '1');
    signal out_bus: data_bus := (others => '0');
    signal selector: std_logic := '0';
begin
    mux: entity work.Mux(RTL) port map(
        in_bus_0 => in_bus_0,
        in_bus_1 => in_bus_1,
        out_bus => out_bus,
        selector => selector);

    process is
    begin
        wait for 10 ns;
        selector <= '1';
        wait for 10 ns;
        selector <= '0';
    end process;
end SIM;