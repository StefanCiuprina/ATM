library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Interface is
port(
	InserareCard : in std_logic;
	C : in std_logic_vector(2 downto 0);
	I : in std_logic_vector(1 downto 0);
	CLK1 : in std_logic;
	CLK2 : in std_logic;
	CLK : in std_logic; --internal clock
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	RESET : in std_logic;
	clr : in std_logic;
	
	CardInserat : out std_logic;
	EliberareNumerar : out std_logic;
	EliberareChitanta : out std_logic;
	EroareSold : out std_logic;
	BlocareCard : out std_logic;
	BanknotesError : out std_logic;
	MoreThan1000 : out std_logic;
	current_state_display : out std_logic_vector(2 downto 0);
	a_to_g: out STD_LOGIC_VECTOR(6 downto 0);
	an: out STD_LOGIC_VECTOR(3 downto 0)
	);
end Interface;

architecture I of Interface is

	signal clk_signal, clk1_signal, clk2_signal, count_signal : std_logic;
	signal display_signal : std_logic_vector(15 downto 0);
	
	component ATM is
	port(
		InserareCard : in std_logic;
		C : in std_logic_vector(2 downto 0);
		I : in std_logic_vector(1 downto 0);
		CLK1 : in std_logic;
		CLK2 : in std_logic;
		CLK : in std_logic; --internal clock
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		RESET : in std_logic;
	
		CardInserat : out std_logic;
		EliberareNumerar : out std_logic;
		EliberareChitanta : out std_logic;
		EroareSold : out std_logic;
		BlocareCard : out std_logic;
		Display : out std_logic_vector(15 downto 0);
		BanknotesError : out std_logic;
	    MoreThan1000 : out std_logic;
		
		current_state_display : out std_logic_vector(2 downto 0)
		);
		end component;
	
	component x7seg is
	port(
		clk: in STD_LOGIC;
		clr: in STD_LOGIC;
		a_to_g: out STD_LOGIC_VECTOR(6 downto 0);
		an: out STD_LOGIC_VECTOR(3 downto 0);
		x:  in STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component freq_divider is
    port(
		 CLK : in std_logic;
     	 CLK0 : out std_logic
	 	);
	end component;
	
	component Debouncer is
	port(
		D : in std_logic; 
		CLK : in std_logic;
		Y : out std_logic
		);
	end component;

begin
	DBC_1 : Debouncer
	port map(
			D => CLK1,
			CLK => CLK,
			Y => clk1_signal
			);
	
	DBC_2 : Debouncer
	port map(
			D => CLK2,
			CLK => CLK,
			Y => clk2_signal
			);
	
	DBC_3 : Debouncer
	port map(
			D => COUNT,
			CLK => CLK,
			Y => count_signal
			);
			
	FREQDIV : freq_divider
	port map(
			CLK => CLK,
			CLK0 => clk_signal
			);
			
	ATM_1 : ATM
	port map(
			InserareCard => InserareCard,
			C => C,
			I => I,
			CLK1 => clk1_signal,
			CLK2 => clk2_signal,
			CLK => clk_signal,
			COUNT => count_signal,
			UPDOWN => UPDOWN,
			RESET => RESET,
	
			CardInserat => CardInserat,
			EliberareNumerar => EliberareNumerar,
			EliberareChitanta => EliberareChitanta,
			EroareSold => EroareSold,
			BlocareCard => BlocareCard,
			Display => display_signal,
			BanknotesError  => BanknotesError,
	        MoreThan1000 => MoreThan1000,
			current_state_display => current_state_display
			);
	
	SEGM : x7seg
	port map(
			clk => CLK,
			clr => clr,
			a_to_g => a_to_g,
			an => an,
			x => display_signal
			);
			
end I;