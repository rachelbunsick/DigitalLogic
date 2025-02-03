library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity wrapper_tb is
end wrapper_tb;

architecture behavioral of wrapper_tb is

	component rachel_ruddy_wrapper is
		Port (reset   : in std_logic;
				clk     : in std_logic;
				HEX0    : out std_logic_vector(6 downto 0);
				HEX5    : out std_logic_vector(6 downto 0));
	end component;
	
	signal reset_tb : std_logic := '0';
	signal clk_tb : std_logic := '0';
	signal HEX0_tb : std_logic_vector(6 downto 0);
	signal HEX5_tb : std_logic_vector(6 downto 0);
	
	constant clk_period : time := 10 ns;
	
	begin
	
	uut: rachel_ruddy_wrapper
		port map (
				reset => reset_tb,
				clk => clk_tb,
				HEX0 => HEX0_tb,
				HEX5 => HEX5_tb
			);
		
	clk_process: process
	begin
		while true loop
			clk_tb <= '0';
			wait for clk_period / 2;
			clk_tb <= '1';
			wait for clk_period / 2;
		end loop;
	end process;
	
	stimulus_process: process
	begin
		
		reset_tb <= '0';
		wait until rising_edge(clk_tb);
	
		reset_tb <= '1';
		wait until rising_edge(clk_tb);
		
		wait for 300 sec;
		
		wait;
		
	end process;
	
end behavioral;