library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity ReedSolomon is port(
	 LEDR: out data_bus);
end entity;

architecture RTL of ReedSolomon is
    component GfMul is port(
        in_bus_0: in data_bus;
		  in_bus_1: in data_bus;
		  out_bus: out data_bus);
    end component;
	 
	 signal in_bus_0: data_bus := "11111011";
    signal in_bus_1: data_bus := "11011111";
	 
begin
    mul: GfMul port map(in_bus_0, in_bus_1, LEDR);
end architecture;