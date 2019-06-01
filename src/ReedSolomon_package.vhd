library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package ReedSolomon_package is

    constant N: integer := 255;
    constant K: integer := 223;
    constant M: integer := 8;
    
    subtype data_bus is std_logic_vector(M-1 downto 0);

end package;