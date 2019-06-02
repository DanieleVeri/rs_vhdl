library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity AddSubTb is
end entity;

architecture SIM of AddSubTb is
    signal in_bus_0: data_bus := (others => '1');
    signal in_bus_1: data_bus := (others => '1');
    signal out_bus: data_bus := (others => '0');
    signal out_carry: std_logic := '0';
    signal operation: std_logic := '1';
begin
    mux: entity work.AddSub(RTL) port map(
        in_bus_0 => in_bus_0,
        in_bus_1 => in_bus_1,
        sub => operation,
        out_carry => out_carry,
        out_bus => out_bus);

    process is
    begin
        wait for 10 ns;
        operation <= '1';
        wait for 10 ns;
        operation <= '0';
    end process;
end architecture;