library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
port(
	D : in std_logic; 
	CLK : in std_logic;
	Y : out std_logic
	);
end Debouncer;

architecture D of Debouncer is

	signal Q : std_logic_vector(2 downto 0);
	signal clk0_signal : std_logic;
	
	component freq_divider is
    port(
		 CLK : in std_logic;
         CLK0 : out std_logic
		 );
	end component;

begin
	FREQ : freq_divider
	port map(
			CLK => CLK,
			CLK0 => clk0_signal
			);
	process(clk0_signal)
		begin
			if(clk0_signal' event and clk0_signal = '1') then
				Q(2) <= Q(1);
				Q(1) <= Q(0);
				Q(0) <= D;
			end if;
		end process;
	Y <= Q(2) and Q(1) and Q(0);
end D;