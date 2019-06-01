library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ReadFile is port(
    data: out std_logic_vector(2 downto 0));
end entity;

architecture RTL of ReadFile is
    signal bin_value : std_logic_vector(2 downto 0):="000";
begin
   
    process
        file file_pointer : text;
        variable line_content : string(1 to 15);
        variable line_num : line;
        variable j, i : integer := 0;
        variable char : character:='0';
    begin
        file_open(file_pointer, "in/read.txt", READ_MODE);   
        bin_value <= "UUU";
        while not endfile(file_pointer) loop
            readline(file_pointer, line_num);
            read(line_num, line_content);
            for j in 1 to 15 loop
                i := i + 1;
                char := line_content(16-j);
                if(char = '0') then
                    bin_value(i-1) <= '0';
                else
                    bin_value(i-1) <= '1';
                end if;
                if (i = 3) then
                    i := 0;
                end if;
            end loop;
            bin_value <= "UUU";
        end loop;
        file_close(file_pointer);
    end process;
	data <= bin_value;
end architecture;
