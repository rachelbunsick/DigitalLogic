library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rachel_ruddy_clock_divider is 
	port (enable  : in std_logic;
		   reset   : in std_logic;
			clk     : in std_logic;
			en_out  : out std_logic);
end rachel_ruddy_clock_divider;

--The clock on the board has a frequency of 50MHz, so the
--clock will have a positive edge every 20 ns, so we need to
--wait 50,000,000 clock cycles before outputting 1, counter
--should start at 49,999,999 count downto 0

architecture behavioral of rachel_ruddy_clock_divider is

	component down_counter is
		port (enable  : in  STD_LOGIC;
				reset   : in  STD_LOGIC;
				clk     : in STD_LOGIC;
				count   : out STD_LOGIC_VECTOR (25 downto 0));     
	end component;
	
	signal count : STD_LOGIC_VECTOR(25 downto 0);

begin

	i1 : down_counter port map (enable, reset, clk, count);

	process(count)
		variable bit_in: boolean := false;
	begin
		bit_in := false;
		for i in 0 to 25 loop
			if count(i) = '1' then
				bit_in := true;
			end if;
		end loop;
		
		if bit_in = false then
			en_out <= '1';
		else
			en_out <= '0';
		end if;
	end process;
	
end behavioral;