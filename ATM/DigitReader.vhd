library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DigitReader is
port(
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	RESET : in std_logic;
	CLK : in std_logic;
	NUMBER : out std_logic_vector(15 downto 0)
	);
end DigitReader;

architecture D of DigitReader is

	signal sel, updown_signal, o0, o1, o2, o3 : std_logic_vector(1 downto 0);
	
	component Modulo4Counter is
	port(
		UP : in std_logic;
		RESET : in std_logic;
		TC : out std_logic; --terminal count
		Q : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component Modulo10Counter is
	port(
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		RESET : in std_logic;
		Q : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component dmux21_2bits is
	port(
		input : in std_logic_vector(1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		o0 : out std_logic_vector(1 downto 0);
		o1 : out std_logic_vector(1 downto 0);
		o2 : out std_logic_vector(1 downto 0);
		o3 : out std_logic_vector(1 downto 0)
		);
	end component;

begin
	updown_signal(0) <= UPDOWN;
	updown_signal(1) <= COUNT;
	
	C4_1 : Modulo4Counter
	port map(
			UP => CLK,
			RESET => RESET,
			Q => sel
			);		 
			
	DMUX_1 : dmux21_2bits
	port map(
			input => updown_signal,
			sel => sel,
			o0 => o0,
			o1 => o1,
			o2 => o2,
			o3 => o3
			);
	
	C10_1 : Modulo10Counter
	port map(
			COUNT => o0(1),
			UPDOWN => o0(0),
			RESET => RESET,
			Q => NUMBER(15 downto 12)
			); 
			
	C10_2 : Modulo10Counter
	port map(
			COUNT => o1(1),
			UPDOWN => o1(0),
			RESET => RESET,
			Q => NUMBER(11 downto 8)
			);
			
	C10_3 : Modulo10Counter
	port map(
			COUNT => o2(1),
			UPDOWN => o2(0),
			RESET => RESET,
			Q => NUMBER(7 downto 4)
			);
			
	C10_4 : Modulo10Counter
	port map(
			COUNT => o3(1),
			UPDOWN => o3(0),
			RESET => RESET,
			Q => NUMBER(3 downto 0)
			);
	
	
	
end D;