library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity GfMulTb is
end entity;

architecture SIM of GfMulTb is
    signal in_bus_0: data_bus := "11111111";
    signal in_bus_1: data_bus := "11111111";
    signal out_bus: data_bus;
begin
    mux: entity work.GfMul(RTL) port map(
        in_bus_0 => in_bus_0,
        in_bus_1 => in_bus_1,
        out_bus => out_bus);
end architecture;