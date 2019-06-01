library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.ReedSolomon_package.all;

entity GfMul is port(
    in_bus_0: in data_bus;
    in_bus_1: in data_bus;
    out_bus: out data_bus);
end entity;

architecture RTL of GfMul is

    component AddSub is port(
        in_bus_0: in data_bus;
        in_bus_1: in data_bus;
        sub: in std_logic;
        out_bus: out data_bus);
    end component;

    component Mux is port(
        in_bus_0: in data_bus;
        in_bus_1: in data_bus;
        selector: in std_logic;
        out_bus: out data_bus);
    end component;

    component SymbolPowerEncoder is port(
        in_pow: in data_bus;
        out_enc: out data_bus);
    end component;

    component SymbolPowerDecoder is port(
        in_pow: in data_bus;
        out_dec: out data_bus);
    end component;

    signal is_zero: std_logic;
    signal encoded_0: data_bus;
    signal encoded_1: data_bus;
    signal exp_sum: data_bus;

begin

    is_zero <= (to_integer(unsigned(in_bus_0)) = 0) or 
        (to_integer(unsigned(in_bus_1)) = 0);

    encode_0: SymbolPowerEncoder port map(in_bus_0, encoded_0);
    encode_1: SymbolPowerEncoder port map(in_bus_1, encoded_1);

    exp_adder: AddSub port map(encoded_0, encoded_1, '0', exp_sum);


    zero_mux: Mux port map(decoded, (others <= '0'), is_zero, out_bus);
    
end architecture;