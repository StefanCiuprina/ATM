library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MagazieBancnote is
port(
	CLK : in std_logic;
	SEL : in std_logic_vector(2 downto 0);
	DIN : in std_logic_vector(7 downto 0);
	WE : in std_logic;
	OUTPUT : out std_logic_vector(7 downto 0)
	);
end MagazieBancnote;

architecture A1 of MagazieBancnote is

	type T is array(7 downto 0) of std_logic_vector(7 downto 0);
	signal content : T := ("00000000", "00000001", "10000101", "00100010", "01010011", "10010010", "10000101", "10010110");  
																																														
begin
	process(CLK)
		begin
			if(CLK' event and CLK = '1') then
					if(WE = '1') then
						content(conv_integer(SEL)) <= DIN;
					end if;
				end if;
		end process;
	OUTPUT <= content(conv_integer(SEL));
end A1;