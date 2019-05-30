library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity Mux is
    port(
        in_bus_0: in data_bus;
        in_bus_1: in data_bus;
        selector: in std_logic;
        out_bus: out data_bus);
end entity;

architecture RTL of Mux is
begin
    with selector select out_bus <= 
        in_bus_0 when '0', 
        in_bus_1 when others;
end architecture;