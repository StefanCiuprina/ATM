library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumToBeExtracted3 is
port(
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	ActivateB : in std_logic;
	CLK1 : in std_logic;
	SumNeeded : out std_logic_vector(15 downto 0)
	);
end SumToBeExtracted3;

architecture S of SumToBeExtracted3 is

	signal D, tmp : std_logic_vector(15 downto 0);

begin
	process(ActivateB, A, B)
		begin
			if(ActivateB = '1') then
				D <= B;
			else
				D <= A;
			end if;
		end process;
	
	process(CLK1)
		begin
			if(CLK1' event and CLK1 = '1') then
				 tmp <= D;
			end if;
		end process;
	SumNeeded <= tmp;
			
end S;