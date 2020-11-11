library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SumComparator is
port(
	Available : in std_logic_vector(15 downto 0);
	Needed : in std_logic_vector(15 downto 0);
	SoldOK : out std_logic
	);
end SumComparator;

architecture S of SumComparator is

begin
	process(Available, Needed)
		begin
			if(Available(15 downto 12) > Needed(15 downto 12)) then
				SoldOK <= '1';
			elsif(Available(15 downto 12) = Needed(15 downto 12)) then
				if(Available(11 downto 8) > Needed(11 downto 8)) then
					SoldOK <= '1';
				elsif(Available(11 downto 8) = Needed(11 downto 8)) then
					if(Available(7 downto 4) > Needed(7 downto 4)) then
						SoldOK <= '1';
					elsif(Available(7 downto 4) = Needed(7 downto 4)) then
						if(Available(3 downto 0) > Needed(3 downto 0)) then
							SoldOK <= '1';
						elsif(Available(3 downto 0) = Needed(3 downto 0)) then
							SoldOK <= '1';
						else
							SoldOK <= '0';
						end if;
					else
						SoldOK <= '0';
					end if;
				else
					SoldOK <= '0';
				end if;
			else
				SoldOK <= '0';
			end if;
		end process;

end S;