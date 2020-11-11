library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dmux21_2bits is
port(
	input : in std_logic_vector(1 downto 0);
	sel : in std_logic_vector(1 downto 0);
	o0 : out std_logic_vector(1 downto 0);
	o1 : out std_logic_vector(1 downto 0);
	o2 : out std_logic_vector(1 downto 0);
	o3 : out std_logic_vector(1 downto 0)
	);
end dmux21_2bits;

architecture D of dmux21_2bits is

begin
	process(input, sel)
		begin
			if(sel = "00") then
				o0 <= input;
				o1 <= "00";
				o2 <= "00";
				o3 <= "00";
			elsif(sel = "01") then
				o1 <= input;
				o0 <= "00";
				o2 <= "00";
				o3 <= "00";
			elsif(sel = "10") then
				o2 <= input;
				o0 <= "00";
				o1 <= "00";
				o3 <= "00";
			else
				o3 <= input;
				o0 <= "00";
				o1 <= "00";
				o2 <= "00";
			end if;
		end process;
end D;