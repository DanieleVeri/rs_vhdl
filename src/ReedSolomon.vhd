library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity ReedSolomon is port(
	 CLOCK_50: in std_logic;
	 LEDR: out std_logic_vector(7 downto 0);
	 KEY : IN STD_LOGIC_VECTOR(0 DOWNTO 0));
end entity;

architecture RTL of ReedSolomon is
	component HostBridge is port(
		clk_0 : IN STD_LOGIC;
		reset_n : IN STD_LOGIC;
		out_port_from_the_pio_1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		in_port_to_the_pio_0 : IN STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
	 
    component GfMul is port(
        in_bus_0: in data_bus;
		  in_bus_1: in data_bus;
		  out_bus: out data_bus);
    end component;
	 
	 signal in_bus_0: data_bus := "00000000";
    signal in_bus_1: data_bus := "01010001";
	 signal out_bus: data_bus := "00000000";
	
begin
    mul: GfMul port map(in_bus_0, in_bus_1, out_bus);
	 nios: HostBridge port map(CLOCK_50, KEY(0), in_bus_0, out_bus);
	 LEDR <= out_bus;
end architecture;