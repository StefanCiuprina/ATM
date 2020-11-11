library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BlocSchimbarePin is
port(
	SchimbarePin : in std_logic;
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	CLK2 : in std_logic;
	NewPin : out std_logic_vector(15 downto 0)
	);
end BlocSchimbarePin;

architecture S of BlocSchimbarePin is

	signal a : std_logic;
	
	component DigitReader is
	port(
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		RESET : in std_logic;
		CLK : in std_logic;
		NUMBER : out std_logic_vector(15 downto 0)
		);
	end component;

begin
	a <= not SchimbarePin;
	DR : DigitReader
	port map(
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			RESET => a,
			CLK => CLK2,
			NUMBER => NewPin
			);

end S;