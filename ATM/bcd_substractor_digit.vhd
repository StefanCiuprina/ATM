library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_substractor_digit is
port(
	A : in std_logic_vector(3 downto 0);
	B : in std_logic_vector(3 downto 0);
	CIN : in std_logic_vector(3 downto 0);
	DIFF : out std_logic_vector(3 downto 0);
	COUT : out std_logic_vector(3 downto 0)
	);
end bcd_substractor_digit;

architecture D of bcd_substractor_digit is
	signal tmp : std_logic_vector(3 downto 0);
begin
	tmp <= B + CIN;
	process(A, B, tmp)
		begin
			if(A < tmp) then
				DIFF <= "1010" - (tmp - A);
				COUT <= "0001";
			else
				DIFF <= A - tmp;
				COUT <= "0000";
			end if;
		end process;

end D;