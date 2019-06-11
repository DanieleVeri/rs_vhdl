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
        out_carry: out std_logic;
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

    constant all_ones: data_bus := (others => '1');
    constant all_zeros: data_bus := (others => '0');

    signal encoded_0: data_bus;
    signal encoded_1: data_bus;

    signal exp_sum: data_bus;
    signal sum_carry_exp_adder: std_logic;
	 signal sum_carry_exp_sub: std_logic;

    signal field_overflow: std_logic;
    signal exp_sub: data_bus;

    signal is_zero: std_logic;
    signal to_decode: data_bus;
    signal decoded: data_bus;

begin

    encode_0: SymbolPowerEncoder port map(in_bus_0, encoded_0);
    encode_1: SymbolPowerEncoder port map(in_bus_1, encoded_1);

    exp_adder: AddSub port map(encoded_0, encoded_1, '0', sum_carry_exp_adder, exp_sum);

    field_overflow <= '1' when (sum_carry_exp_adder = '1') or (exp_sum = all_ones) else '0';
    field_norm: AddSub port map(exp_sum, all_ones, '1', sum_carry_exp_sub, exp_sub);
    mux_to_decoder: Mux port map(exp_sum, exp_sub, field_overflow, to_decode);

    decode: SymbolPowerDecoder port map(to_decode, decoded);

    is_zero <= '1' when (in_bus_0 = all_zeros) or (in_bus_1 = all_zeros) else '0';
    zero_mux: Mux port map(decoded, all_zeros, is_zero, out_bus);
    
end architecture;