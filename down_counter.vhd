library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity down_counter is
    Port ( enable  : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
			  clk     : in STD_LOGIC;
           count   : out STD_LOGIC_VECTOR (25 downto 0));     
end down_counter;

architecture Behavioral of down_counter is

signal counter : unsigned(25 downto 0) := (others => '0');

begin

	process(clk,reset)
	begin
		if reset = '0' then
			counter <= to_unsigned(49999999,26);
		elsif rising_edge(clk) then
			if enable = '1' then
				if counter > 0 then
					counter <= counter - 1;
				end if;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(counter);

end Behavioral;
