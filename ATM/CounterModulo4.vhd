library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Modulo4Counter is
port(
	UP : in std_logic;
	RESET : in std_logic;
	TC : out std_logic; --terminal count
	Q : out std_logic_vector(1 downto 0)
	);
end Modulo4Counter;

architecture M of Modulo4Counter is

signal tmp : std_logic_vector(1 downto 0);

begin
	process(UP, RESET)
		begin
			if(RESET = '1') then
				tmp <= "00";
			elsif(UP' event and UP = '1') then
				tmp <= tmp + 1;	
			end if;
		end process;
	Q <= tmp;
	TC <= '1' when tmp = "11" else
		  '0';
end M;