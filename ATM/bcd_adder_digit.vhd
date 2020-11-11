library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_adder_digit is
port(
	A : in std_logic_vector(3 downto 0);
	B : in std_logic_vector(3 downto 0);
	CIN : in std_logic_vector(3 downto 0);
	SUM : out std_logic_vector(3 downto 0);
	COUT : out std_logic_vector(3 downto 0)
	);
end bcd_adder_digit;

architecture bcd of bcd_adder_digit is
	 signal tmp : std_logic_vector(3 downto 0);
begin
	tmp <= A + B + CIN;
	process(tmp, A, B, CIN)
		begin
			if(tmp > 9) then
				SUM <= tmp + 6;
				COUT <= "0001";
			else
				SUM <= tmp;
				COUT <= "0000";
			end if;
		end process;

end bcd;