library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is port( 
	 in_0: in  std_logic;
	 in_1: in  std_logic;
	 in_carry: in  std_logic;
	 out_sum: out std_logic;
	 out_carry: out std_logic);
end entity;

architecture RTL of FullAdder is
begin

    out_sum <= in_0 xor in_1 xor in_carry;
    out_carry <= (in_0 and in_1) or (in_0 and in_carry) or (in_1 and in_carry);

end architecture;
