library ieee;
use ieee.std_logic_1164.all;
use work.ReedSolomon_package.all;

entity GfSum is port(
    in_bus_0: in data_bus;
    in_bus_1: in data_bus;
    out_bus: out data_bus);
end entity;

architecture RTL of GfSum is
begin

    do_xor: for i in 0 to data_bus'length-1 generate
        out_bus(i) <= in_bus_0(i) xor in_bus_1(i);
    end generate;
    
end architecture;