library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_adder is
port(
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	SUM : out std_logic_vector(15 downto 0)
	);
end bcd_adder;

architecture bcd of bcd_adder is

	component bcd_adder_digit is
	port(
		A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		CIN : in std_logic_vector(3 downto 0);
		SUM : out std_logic_vector(3 downto 0);
		COUT : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal cin1, cin2, cin3 : std_logic_vector(3 downto 0);
	
begin

	BCDADD1 : bcd_adder_digit
	port map(
			A => A(3 downto 0),
			B => B(3 downto 0),
			CIN => "0000",
			SUM => SUM(3 downto 0),
			COUT => cin1
			);
	
	BCDADD2 : bcd_adder_digit
	port map(
			A => A(7 downto 4),
			B => B(7 downto 4),
			CIN => cin1,
			SUM => SUM(7 downto 4),
			COUT => cin2
			);
			
	BCDADD3 : bcd_adder_digit
	port map(
			A => A(11 downto 8),
			B => B(11 downto 8),
			CIN => cin2,
			SUM => SUM(11 downto 8),
			COUT => cin3
			);
			
	BCDADD4 : bcd_adder_digit
	port map(
			A => A(15 downto 12),
			B => B(15 downto 12),
			CIN => cin3,
			SUM => SUM(15 downto 12)
			);

end bcd;