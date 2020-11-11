library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Modulo10Counter is
port(
	COUNT : in std_logic;
	UPDOWN : in std_logic;
	RESET : in std_logic;
	Q : out std_logic_vector(3 downto 0)
	);
end Modulo10Counter;

architecture M of Modulo10Counter is				 

signal tmp : std_logic_vector(3 downto 0);

begin
	process(COUNT, RESET)
		begin
			if(RESET = '1') then
				tmp <= "0000";
			else
				if(COUNT' event and COUNT = '1') then
					if(UPDOWN = '1') then
						if(tmp = "1001") then
							tmp <= "0000";
						else
							tmp <= tmp + 1;
						end if;
					else
						if(tmp = "0000") then
							tmp <= "1001";
						else
							tmp <= tmp - 1;
						end if;
					end if;
				end if;
			end if;
		end process;
	Q <= tmp;
end M;