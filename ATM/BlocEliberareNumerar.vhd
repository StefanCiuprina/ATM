library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BlocEliberareNumerar is
port(
	EliberareNumerar : in std_logic;
	SumAvailable : in std_logic_vector(15 downto 0);
	SumNeeded : in std_logic_vector(15 downto 0);
	NewAmount : out std_logic_vector(15 downto 0);
	
	CLK : in std_logic;
	EliberareNumerar_OK : out std_logic;
	BanknotesError : out std_logic
	
	);
end BlocEliberareNumerar;

architecture EliberareNumerar of BlocEliberareNumerar is

	component bcd_substractor is
	port(
		A : in std_logic_vector(15 downto 0);
		B : in std_logic_vector(15 downto 0);
		DIFF : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component BancnotesVerifier is
	port(
		SumNeeded : in std_logic_vector(15 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		OK : out std_logic
		);
	end component;
	
	signal eliberarenumerar_signal, ok_signal: std_logic;
	signal newamount_signal : std_logic_vector(15 downto 0);

begin
	eliberarenumerar_signal <= not EliberareNumerar;
	
	EliberareNumerar_OK <= '1' when ok_signal = '1' else
						   '0';
	BanknotesError <= '1' when ok_signal = '0' else
					  '0';
	
	BNCVERIF : BancnotesVerifier
	port map(
			SumNeeded => SumNeeded,
			RESET => eliberarenumerar_signal,
			CLK => CLK,
			OK => ok_signal
			);
	
	
	BCDSUB : bcd_substractor
	port map(
			A => SumAvailable,
			B => SumNeeded,
			DIFF => newamount_signal
			);
	
	NewAmount <= newamount_signal when ok_signal = '1' else
				 SumAvailable;

end EliberareNumerar;