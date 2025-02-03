library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_tb is
end FSM_tb;

architecture behavioral of FSM_tb is

	component rachel_ruddy_FSM
		Port (seq    : in std_logic;
			enable : in std_logic;
			reset  : in std_logic;
			clk    : in std_logic;
			out_1  : out std_logic;
			out_2  : out std_logic);
	end component;
	
	signal seq_tb : std_logic := '0';
	signal enable_tb : std_logic := '0';
	signal reset_tb : std_logic := '0';
	signal clk_tb : std_logic := '0';
	signal out_1tb : std_logic := '0';
	signal out_2tb : std_logic := '0';
	
	constant clk_period : time := 10 ns;
	
	begin
	
	uut: rachel_ruddy_FSM
		port map (
				seq => seq_tb,
				enable => enable_tb,
				reset => reset_tb,
				clk => clk_tb,
				out_1 => out_1tb,
				out_2 => out_2tb
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
	
	-- initialize
	reset_tb <= '0';
	wait for clk_period * 2;
	
	reset_tb <= '1';
	wait for clk_period * 2;
	
	-- enable FSM
	enable_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	-- try reset
	reset_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	wait for clk_period * 20;
	
	wait;
	end process;
	
end behavioral;
	