library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity PinMemory is
port(
	CLK : in std_logic;
	SEL : in std_logic_vector(2 downto 0);
	DIN : in std_logic_vector(15 downto 0);
	OUTPUT : out std_logic_vector(15 downto 0)
	);
end PinMemory;

architecture A1 of PinMemory is

	type T is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal content : T := ("0110001100110110", "0100001101110111", "0101011110000011", "0010010001010001", "0111011100100100", "0101000110000100", "0011001000100000", "0101100001100001");

begin
	process(CLK)
		begin
			if(CLK' event and CLK = '1') then
					content(conv_integer(SEL)) <= DIN;
				end if;
		end process;
	OUTPUT <= content(conv_integer(SEL));
end A1;
