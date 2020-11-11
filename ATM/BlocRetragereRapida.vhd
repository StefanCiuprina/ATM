library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BlocRetragereRapida is
port(
	RetragereRapida : in std_logic;
	SumAvailable : in std_logic_vector(15 downto 0);
	UP : in std_logic;
	DISPLAY : out std_logic_vector(15 downto 0);
	SoldOK : out std_logic
	);
end BlocRetragereRapida;

architecture B of BlocRetragereRapida is

	signal a : std_logic;
	signal sel : std_logic_vector(1 downto 0);
	signal choice : std_logic_vector(15 downto 0);
	
	component Modulo4Counter is
	port(
		UP : in std_logic;
		RESET : in std_logic;
		TC : out std_logic; --terminal count
		Q : out std_logic_vector(1 downto 0)
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
	DISPLAY <= choice;
	a <= not RetragereRapida;
	
	CP_3 : Modulo4Counter
	port map(
			UP => UP,
			RESET => a,
			Q => sel
			);
			
	with sel select
		choice <= "0000000000010000" when "00", --10
			 	  "0000000001010000" when "01",	--50
				  "0000000100000000" when "10",	--100
			 	  "0000010100000000" when others; --500
	
	SC_1 : SumComparator
	port map(
			Available => SumAvailable,
			Needed => choice,
			SoldOK => SoldOK
			);

end B;