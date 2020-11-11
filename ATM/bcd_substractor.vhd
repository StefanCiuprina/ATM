library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_substractor is
port(
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	DIFF : out std_logic_vector(15 downto 0)
	);
end bcd_substractor;

architecture bcd of bcd_substractor is
	
	signal cin1, cin2, cin3 : std_logic_vector(3 downto 0);
	
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
	BCD1 : bcd_substractor_digit
	port map(
			A => A(3 downto 0),
			B => B(3 downto 0),
			CIN => "0000",
			DIFF => DIFF(3 downto 0),
			COUT => cin1
			);
	
	BCD2 : bcd_substractor_digit
	port map(
			A => A(7 downto 4),
			B => B(7 downto 4),
			CIN => cin1,
			DIFF => DIFF(7 downto 4),
			COUT => cin2
			); 
	
	BCD3 : bcd_substractor_digit
	port map(
			A => A(11 downto 8),
			B => B(11 downto 8),
			CIN => cin2,
			DIFF => DIFF(11 downto 8),
			COUT => cin3
			);
			
	BCD4 : bcd_substractor_digit
	port map(
			A => A(15 downto 12),
			B => B(15 downto 12),
			CIN => cin3,
			DIFF => DIFF(15 downto 12)
			);
end bcd;