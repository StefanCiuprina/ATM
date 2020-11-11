library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_substractor_2digits is
port(
	A : in std_logic_vector(7 downto 0);
	B : in std_logic_vector(7 downto 0);
	DIFF : out std_logic_vector(7 downto 0)
	);
end bcd_substractor_2digits;

architecture bcd of bcd_substractor_2digits is
	
	signal cin1 : std_logic_vector(3 downto 0);
	
	component bcd_substractor_digit is
	port(
		A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		CIN : in std_logic_vector(3 downto 0);
		DIFF : out std_logic_vector(3 downto 0);
		COUT : out std_logic_vector(3 downto 0)
		);
	end component;

begin
	BCD5 : bcd_substractor_digit
	port map(
			A => A(3 downto 0),
			B => B(3 downto 0),
			CIN => "0000",
			DIFF => DIFF(3 downto 0),
			COUT => cin1
			);
	
	BCD6 : bcd_substractor_digit
	port map(
			A => A(7 downto 4),
			B => B(7 downto 4),
			CIN => cin1,
			DIFF => DIFF(7 downto 4)
			); 
end bcd;