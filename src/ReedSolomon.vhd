----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:00:16 04/15/2019 
-- Design Name: 
-- Module Name:    ReedSolomon - RTL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ReedSolomon is
port (
  i_clk          : in  std_logic;
  i_rstb         : in  std_logic;
  i_start_enc    : in  std_logic;
  i_data_ena     : in  std_logic;
  i_data         : in  std_logic_vector(2 downto 0);
  o_encoding     : out std_logic;
  o_data_valid   : out std_logic;
  o_data         : out std_logic_vector(2 downto 0));
end ReedSolomon;

architecture RTL of ReedSolomon is
constant C_N            : integer := 7;
constant C_K            : integer := 3;
constant C_M            : integer := 3;
constant C_T            : integer := C_N-C_K;

---------------------------------------------------------------------------------------------------
function  rise(val : in std_logic;  val_d : in std_logic ) return std_logic is
variable ret   : std_logic;
begin
  ret := not val_d and val;
  return ret;
end rise;
---------------------------------------------------------------------------------------------------
function mult13 (v1, v2 : in std_logic_vector) return std_logic_vector is
constant m              : integer := C_M;	
variable dummy          : std_logic;
variable v_temp         : std_logic_vector(m-1 downto 0);
variable ret            : std_logic_vector(m-1 downto 0);

begin
  v_temp := (others=>'0');   -- D^3+D^2+1
  for i in 0 to m-1 loop 
    dummy      := v_temp(2);
    v_temp(2 ) := v_temp(1 ) xor dummy;
    v_temp(1 ) := v_temp(0 );
    v_temp(0 ) := dummy;

    for j in 0 to m-1 loop
      v_temp(j) := v_temp(j) xor (v1(j) and v2(m-i-1));
    end loop;
  end loop;
  ret := v_temp;
  return ret;
end mult13;
----------------------------------------------------------------------------------------------------
type t_pipe_enc is array (1 to C_T) of std_logic_vector(C_M-1 downto 0);

constant G_GPOLY        : t_pipe_enc := (
   conv_std_logic_vector(5,C_M),
   conv_std_logic_vector(1,C_M),
   conv_std_logic_vector(5,C_M),
   conv_std_logic_vector(4,C_M));

type t_pipe_data is array (0 to 2) of std_logic_vector(C_M-1 downto 0);

signal p_start_enc                       : std_logic_vector(0 to 2);
signal p_data_ena                        : std_logic_vector(0 to 2);
signal p_data                            : t_pipe_data;
signal r_pipe_enc                        : t_pipe_enc;
signal w_pipe_enc                        : t_pipe_enc;
signal w_feedback                        : std_logic_vector(C_M-1 downto 0);
signal w_start_enc                       : std_logic;
signal w_sel                             : std_logic;
signal w_ecoder_enable                   : std_logic;
signal r_counter                         : integer range 0 to C_N;
signal w_counter_tc                      : std_logic;
signal r_encoding                        : std_logic;

begin

w_feedback     <= p_data(2) xor r_pipe_enc(C_T) when(w_sel='1') else (others=>'0');

g_pipe_enc :  for i in 1 to C_T generate
  w_pipe_enc(i)  <= mult13(G_GPOLY(i),w_feedback);
end generate;

p_enc : process(i_clk,i_rstb)
begin
  if(i_rstb='0') then
    r_pipe_enc     <= (others=>(others=>'0'));
    o_data         <= (others=>'0');
    o_data_valid   <= '0';
  elsif(rising_edge(i_clk)) then
    o_data_valid   <= w_ecoder_enable;
    if(w_ecoder_enable='1') then
      for i in 2 to C_T loop
        r_pipe_enc(i)     <= r_pipe_enc(i-1) xor w_pipe_enc(i);
      end loop;
      r_pipe_enc(1)     <= w_pipe_enc(1);
      
      if(w_sel='1') then
        o_data         <= p_data(2);
      else
        o_data         <= r_pipe_enc(C_T);
      end if;
    end if;
  end if;
end process p_enc;

w_start_enc       <= rise(p_start_enc(0),p_start_enc(1));
w_counter_tc      <= '0' when (r_counter<C_N) else '1';
w_sel             <= '1' when (r_counter<C_K) else '0';
w_ecoder_enable   <= p_data_ena(2) when (w_sel='1') else
                     '1'           when (w_counter_tc='0') else '0';

o_encoding        <= r_encoding;
p_enc_control : process(i_clk,i_rstb)
begin
  if(i_rstb='0') then
    r_encoding      <= '0';
    r_counter       <= C_N;
    p_start_enc     <= (others=>'0');
    p_data_ena      <= (others=>'0');
    p_data          <= (others=>(others=>'0'));
  elsif(rising_edge(i_clk)) then
    p_start_enc     <= i_start_enc &p_start_enc(0 to p_start_enc'length-2);
    p_data_ena      <= i_data_ena  &p_data_ena (0 to p_data_ena 'length-2);
    p_data          <= i_data      &p_data     (0 to p_data     'length-2);
    if(w_start_enc='1') then
      r_encoding      <= '1';
    elsif(w_counter_tc='1') then
      r_encoding      <= '0';
    end if;

    if(w_start_enc='1') then
      r_counter       <= 0;
    elsif(w_sel='1' and p_data_ena(2)='1') then
      r_counter       <= r_counter + 1;
    elsif(w_sel='0' and w_counter_tc='0') then
      r_counter       <= r_counter + 1;
    end if;
 	end if;
end process p_enc_control;

end RTL;