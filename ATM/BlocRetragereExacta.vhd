library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RetragereExacta is
port(
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	RetragereExacta : in std_logic;
	CLK2 : in std_logic;
	SumAvailable : in std_logic_vector(15 downto 0);
	DISPLAY : out std_logic_vector(15 downto 0);
	SoldOK : out std_logic
	);
end RetragereExacta;

architecture R of RetragereExacta is

	signal a : std_logic;
	signal number_signal : std_logic_vector(15 downto 0);
	
	component DigitReader is
	port(
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		RESET : in std_logic;
		CLK : in std_logic;
		NUMBER : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component SumComparator is
	port(
		Available : in std_logic_vector(15 downto 0);
		Needed : in std_logic_vector(15 downto 0);
		SoldOK : out std_logic
		);
	end component;
	
begin
	DISPLAY <= number_signal;
	a <= not RetragereExacta;
	
	DR_2 : DigitReader
	port map(
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			RESET => a,
			CLK => CLK2,
			NUMBER => number_signal
			);
	
	SC_2 : SumComparator
	port map(
			Available => SumAvailable,
			Needed => number_signal,
			SoldOK => SoldOK
			);
	
end R;