library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ATM is
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
	BanknotesError : out std_logic;
	MoreThan1000 : out std_logic;
	EroareSold : out std_logic;
	BlocareCard : out std_logic;
	Display : out std_logic_vector(15 downto 0);
	
	current_state_display : out std_logic_vector(2 downto 0)
	);
end ATM;

architecture A of ATM is

	signal t3_signal, soldok_signal, pinok_signal, verificarepin_signal, blocarecard_signal, retragererapida_signal, retragereexacta_signal, schimbarepin_signal, eroaresold_signal, eliberarenumerar_signal : std_logic;
	signal pinmemclock_signal, monmemclock_signal : std_logic;
	signal pinmemdin_signal, pinmemout_signal : std_logic_vector(15 downto 0);
	signal monmemdin_signal, monmemout_signal : std_logic_vector(15 downto 0); 
	signal sumneeded_signal : std_logic_vector(15 downto 0);
	signal soldokA_signal, soldokB_signal : std_logic;
	signal verificarepin_display, retragererapida_display, retragereexacta_display: std_logic_vector(15 downto 0);
	signal selection_display : std_logic_vector(2 downto 0);
	signal activateb_signal, pinschimbat_signal, banknoteserror_signal, eliberarenumerar_signal_2, lessthan1000_signal, eliberarenumerarok_signal : std_logic;
	signal current_amount : std_logic_vector(15 downto 0);
	
	component CommandUnit is
	port(
		CLK1 : in std_logic;
		RESET : in std_logic;
		InserareCard : in std_logic;
		PinOK : in std_logic;
		I : in std_logic_vector(1 downto 0);
		T3 : in std_logic;
		SoldOK : in std_logic;
	
		CardInserat : out std_logic;
		VerificarePIN : out std_logic;
		BlocareCard : out std_logic;
		RetragereRapida : out std_logic;
		RetragereExacta : out std_logic;
		SchimbarePin : out std_logic;
		EroareSold : out std_logic;
		EliberareNumerar : out std_logic;
		EliberareChitanta : out std_logic;
		
		Selection : out std_logic_vector(2 downto 0);
		
		activateb : out std_logic;
		pinschimbat_activate : out std_logic;
		
		current_state_display : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component PinMemory is
	port(
		CLK : in std_logic;
		SEL : in std_logic_vector(2 downto 0);
		DIN : in std_logic_vector(15 downto 0);
		OUTPUT : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component MoneyMemory is
	port(
		CLK : in std_logic;
		SEL : in std_logic_vector(2 downto 0);
		DIN : in std_logic_vector(15 downto 0);
		OUTPUT : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component BlocVerificarePIN2 is
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
	end component;
	
	component BlocRetragereRapida is
	port(
		RetragereRapida : in std_logic;
		SumAvailable : in std_logic_vector(15 downto 0);
		UP : in std_logic;
		DISPLAY : out std_logic_vector(15 downto 0);
		SoldOK : out std_logic
		);
	end component;
	
	component RetragereExacta is
	port(
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		RetragereExacta : in std_logic;
		CLK2 : in std_logic;
		SumAvailable : in std_logic_vector(15 downto 0);
		DISPLAY : out std_logic_vector(15 downto 0);
		SoldOK : out std_logic
		);
	end component;
	
	component SumToBeExtracted3 is
	port(
		A : in std_logic_vector(15 downto 0);
		B : in std_logic_vector(15 downto 0);
		ActivateB : in std_logic;
		CLK1 : in std_logic;
		SumNeeded : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component BlocEliberareNumerar is
	port(
		EliberareNumerar : in std_logic;
		SumAvailable : in std_logic_vector(15 downto 0);
		SumNeeded : in std_logic_vector(15 downto 0);
		NewAmount : out std_logic_vector(15 downto 0);
		
		CLK : in std_logic;
		EliberareNumerar_OK : out std_logic;
		BanknotesError : out std_logic
		);
	end component;
	
	component BlocSchimbarePin is
	port(
		SchimbarePin : in std_logic;
		COUNT : in std_logic;
		UPDOWN : in std_logic;
		CLK2 : in std_logic;
		NewPin : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component BlocDisplay is
	port(
		VerificarePin : in std_logic_vector(15 downto 0);
		SchimbarePin : in std_logic_vector(15 downto 0);
		RetragereRapida : in std_logic_vector(15 downto 0);
		RetragereExacta : in std_logic_vector(15 downto 0);
		EliberareNumerar : in std_logic_vector(15 downto 0);
		InterogareSold : in std_logic_vector(15 downto 0);
		Selection : in std_logic_vector(2 downto 0);
	
		DISPLAY : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component comparator1000 is
	port(
		SumNeeded : in std_logic_vector(15 downto 0);
		LessThan1000 : out std_logic
		);
	end component;
	
begin
	
	BanknotesError <= (banknoteserror_signal and eliberarenumerar_signal) and lessthan1000_signal;
	
	process(CLK)
		begin
			if(CLK' event and CLK = '1') then
				if(retragererapida_signal = '1' or retragereexacta_signal = '1') then
					current_amount <= monmemout_signal;
				end if;
			end if;
		end process;
	
	EliberareNumerar <= eliberarenumerarok_signal;
	EroareSold <= eroaresold_signal;
	BlocareCard <= blocarecard_signal;
	MoreThan1000 <= (not lessthan1000_signal) and eliberarenumerar_signal;
	--Display
	
	COMMAND_U : CommandUnit
	port map(
			CLK1 => CLK1,
			RESET => RESET,
			InserareCard => InserareCard,
			PinOK => pinok_signal,
			I => I,
			T3 => t3_signal,
			SoldOK => soldok_signal,
			
			CardInserat => CardInserat,
			VerificarePIN => verificarepin_signal,
			BlocareCard => blocarecard_signal,
			RetragereRapida => retragererapida_signal,
			RetragereExacta => retragereexacta_signal,
			SchimbarePin => schimbarepin_signal,
			EroareSold => eroaresold_signal,
			EliberareNumerar => eliberarenumerar_signal,
			EliberareChitanta => EliberareChitanta,
			Selection => selection_display,
			
			activateb => activateb_signal,
			pinschimbat_activate => pinschimbat_signal,
			
			current_state_display => current_state_display
			);
			
	PIN_M : PinMemory
	port map(
			CLK => pinschimbat_signal,
			SEL => C,
			DIN => pinmemdin_signal,
			OUTPUT => pinmemout_signal
			);
	
	MON_M : MoneyMemory
	port map(
			CLK => eliberarenumerarok_signal,
			SEL => C,
			DIN => monmemdin_signal,
			OUTPUT => monmemout_signal
			);
	
	VERIFPIN : BlocVerificarePIN2
	port map(
			VerifPin => verificarepin_signal,
			CLK2 => CLK2,
			CLK1 => CLK1,
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			PIN => pinmemout_signal,
			DISPLAY => verificarepin_display,
			PinOK => pinok_signal,
			T3 => t3_signal
			);
	
	RETRRAP : BlocRetragereRapida
	port map(
			RetragereRapida => retragererapida_signal,
			SumAvailable => monmemout_signal,
			UP => COUNT,
			DISPLAY => retragererapida_display,
			SoldOK => soldokA_signal
			);
	
	RETREX : RetragereExacta
	port map(
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			RetragereExacta => retragereexacta_signal,
			CLK2 => CLK2,
			SumAvailable => monmemout_signal,
			DISPLAY => retragereexacta_display,
			SoldOK => soldokB_signal
			);
	
	SUMTOBE : SumToBeExtracted3
	port map(
			A => retragererapida_display,
			B => retragereexacta_display,
			ActivateB => activateb_signal,
			CLK1 => CLK1,
			SumNeeded => sumneeded_signal
			);
			
	CMP1000 : comparator1000
	port map(
			SumNeeded => sumneeded_signal,
			LessThan1000 => lessthan1000_signal
			);
	
	eliberarenumerar_signal_2 <= eliberarenumerar_signal and lessthan1000_signal;
	
	ELIBNUM : BlocEliberareNumerar
	port map(
			EliberareNumerar => eliberarenumerar_signal_2,
			SumAvailable => current_amount,
			SumNeeded => sumneeded_signal,
			NewAmount => monmemdin_signal,
			CLK => CLK,
			EliberareNumerar_OK => eliberarenumerarok_signal,
			BanknotesError => banknoteserror_signal
			);
			
	SCHPIN : BlocSchimbarePin
	port map(
			SchimbarePin => schimbarepin_signal,
			COUNT => COUNT,
			UPDOWN => UPDOWN,
			CLK2 => CLK2,
			NewPin => pinmemdin_signal
			);
			
	DSPL : BlocDisplay
	port map(
			VerificarePin => verificarepin_display,
			SchimbarePin => pinmemdin_signal,
			RetragereRapida => retragererapida_display,
			RetragereExacta => retragereexacta_display,
			EliberareNumerar => monmemdin_signal,
			InterogareSold => monmemout_signal,
			Selection => selection_display,
			DISPLAY => DISPLAY
			);
			
	soldok_signal <= soldokA_signal when retragererapida_signal = '1' else
					 soldokB_signal;
	
end A;