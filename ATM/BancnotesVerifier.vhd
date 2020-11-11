library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BancnotesVerifier is
port(
	SumNeeded : in std_logic_vector(15 downto 0);
	RESET : in std_logic;
	CLK : in std_logic;
	OK : out std_logic
	);
end BancnotesVerifier;

architecture bancnotes of BancnotesVerifier is

	component MagazieBancnote is
	port(
		CLK : in std_logic;
		SEL : in std_logic_vector(2 downto 0);
		DIN : in std_logic_vector(7 downto 0);
		WE : in std_logic;
		OUTPUT : out std_logic_vector(7 downto 0)
		);
	end	 component;
	
	component BancnotesNeeded is
	port(
		CLK : in std_logic;
		SEL : in std_logic_vector(2 downto 0);
		DIN : in std_logic_vector(7 downto 0);
		WE : in std_logic;
		OUTPUT : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component bcd_adder is
	port(
		A : in std_logic_vector(15 downto 0);
		B : in std_logic_vector(15 downto 0);
		SUM : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component bcd_substractor_2digits is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		DIFF : out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal reg, banknote, to_add : std_logic_vector(15 downto 0);
	signal sel : std_logic_vector(2 downto 0);
	signal banknotes_available, din_BanknotesNeeded, out_BanknotesNeeded, tmp, din_magazie : std_logic_vector(7 downto 0);
	signal write_select, we_magazie, we_needed : std_logic;

begin
	process(write_select)
		begin
			if(write_select = '0') then
				we_magazie <= '0';
				we_needed <= '1';
			else
				we_magazie <= '1';
				we_needed <= '0';
			end if;
		end process;
	
	with sel select
		banknote <= "0000010100000000" when "000", --500
				    "0000001000000000" when "001", --200
				    "0000000100000000" when "010", --100
				    "0000000001010000" when "011", --50
					"0000000000100000" when "100", --20
					"0000000000010000" when "101", --10
					"0000000000000101" when "110", --5
			 	    "0000000000000000" when others;
	
	ADD_BCD1 : bcd_adder
	port map(
			A => reg,
			B => banknote,
			SUM => to_add
			);
	SUB_BCD1 : bcd_substractor_2digits
	port map(
			A => banknotes_available,
			B => out_BankNotesNeeded,
			DIFF => din_magazie
			);
	
	MAGAZIE : MagazieBancnote
	port map(
			CLK => CLK,
			SEL => sel,
			DIN => din_magazie,
			WE => we_magazie,
			OUTPUT => banknotes_available
			);
			
	BANKNEEDED : BancnotesNeeded
	port map(
			CLK => CLK,
			SEL => sel,
			WE => we_needed,
			DIN => din_BanknotesNeeded,
			OUTPUT => out_BanknotesNeeded
			);
	
	din_BanknotesNeeded <= tmp;
	process(CLK, RESET)
		begin
			if(RESET = '1') then
				reg <= "0000000000000000";
				sel <= "000";
				OK <= '0';
				write_select <= '0';
				tmp <= "00000000";
			elsif(CLK' event and CLK = '1') then
				if(sel = "111") then
						if(reg = SumNeeded) then
							OK <= '1';
							if(write_select = '0') then
								write_select <= '1';
								sel <= "000";
							end if;
						else
							OK <= '0';
						end if;
				elsif(banknotes_available > "00000000") and (to_add <= SumNeeded) then
					reg <= to_add;
					tmp <= tmp + 1;
				else
					sel <= sel + 1;
					tmp <= "00000000";
				end if;
			end if;
		end process;
	
end bancnotes;