library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator1000 is
port(
	SumNeeded : in std_logic_vector(15 downto 0);
	LessThan1000 : out std_logic
	);
end comparator1000;

architecture comp of comparator1000 is

begin
	LessThan1000 <= '1' when SumNeeded <= "0001000000000000" else
					'0';

end comp;