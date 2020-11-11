library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BlocVerificarePIN2 is
port(
	VerifPin : in std_logic;
	CLK2 : in std_logic;
	CLK1 : in std_logic;
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	PIN : in std_logic_vector(15 downto 0);
	DISPLAY : out std_logic_vector(15 downto 0);
	PinOK : out std_logic;
	T3 : out std_logic
	);
end BlocVerificarePIN2;

architecture B of BlocVerificarePIN2 is
	
	signal a, b, c, e : std_logic;
	signal PinToVerify : std_logic_vector(15 downto 0);
	
	component Modulo4Counter is
	port(
		UP : in std_logic;
		RESET : in std_logic;
		TC : out std_logic; --terminal count
		Q : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component comparator16bit is
	port(
		A : in std_logic_vector(15 downto 0);
		B : in std_logic_vector(15 downto 0);
		EQUALITY : out std_logic
		);
	end component;
	
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
	DISPLAY <= PinToVerify;
	a <= not VerifPin;
	b <= VerifPin and CLK2;
	e <= not c and CLK1;
	
	DR_1 : DigitReader
	port map(
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			RESET => a,
			CLK => b,
			NUMBER => PinToVerify
			);
	
	CMP_1 : comparator16bit
	port map(
			A => PIN,
			B => PinToVerify,
			EQUALITY => c
			);
	
	C4_2 : Modulo4Counter
	port map(
			RESET => a,
			UP => e,
			TC => T3
			);
			
	PinOK <= c;
end B;