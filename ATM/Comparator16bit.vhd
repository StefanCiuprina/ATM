library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator16bit is
port(
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	EQUALITY : out std_logic
	);
end comparator16bit;

architecture C of comparator16bit is

begin
	EQUALITY <= '1' when A = B else
				'0';
end C;