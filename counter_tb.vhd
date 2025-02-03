library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture behavioral of counter_tb is

	component rachel_ruddy_sequence_detector
		Port (seq    : in std_logic;
			enable : in std_logic;
			reset  : in std_logic;
			clk    : in std_logic;
			cnt_1  : out std_logic;
			cnt_2  : out std_logic);
	end component;
	
	signal seq_tb : std_logic := '0';
	signal enable_tb : std_logic := '0';
	signal reset_tb : std_logic := '0';
	signal clk_tb : std_logic := '0';
	signal cnt_1tb : std_logic := '0';
	signal cnt_2tb : std_logic := '0';
	
	constant clk_period : time := 10 ns;
	
	begin
	
	uut: rachel_ruddy_sequence_detector
		port map (
				seq => seq_tb,
				enable => enable_tb,
				reset => reset_tb,
				clk => clk_tb,
				cnt_1 => cnt_1tb,
				cnt_2 => cnt_2tb
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
	reset_tb <= '1';
	wait for clk_period * 2;
	
	report "Starting stimulus process" severity note;
	reset_tb <= '0';
	wait for clk_period * 2;
	

	reset_tb <= '1';
	wait for clk_period * 2;
	
	-- enable FSM
	enable_tb <= '1';
	wait for clk_period * 2;

	-- sequence: 1011001001010
	-- cnt1 : 1011
-- cnt2 : 0010
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '1'; -- sequence 1 detected- cnt_1 = 001
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2; -- sequence 2 detected- cnt_2 = 001
	
	seq_tb <= '0';
	wait for clk_period * 2;	

seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';  -- sequence 2 detected again - cnt_2 = 010
	wait for clk_period * 2;	

	--reset test! cnt_1 = 0, cnt_2 = 0

	reset_tb <= '0';
	wait for clk_period * 2;

	reset_tb <= '1';
	wait for clk_period * 2;
	-- finished reset test

-- Last sequence:  001011011
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2;
	
	seq_tb <= '1';
	wait for clk_period * 2;
	
	seq_tb <= '0';
	wait for clk_period * 2; -- sequence 2 detected cnt_2 = 001

	seq_tb <= '1';
	wait for clk_period * 2;

	seq_tb <= '1';
	wait for clk_period * 2; -- sequence 1 detected cnt_1 = 001

	seq_tb <= '0';
	wait for clk_period * 2;

	seq_tb <= '1';
	wait for clk_period * 2;

	seq_tb <= '1';
	wait for clk_period * 2; -- sequence 1 detected cnt_1 = 010

	wait for clk_period * 20;
	wait;
	end process;
	
end behavioral;
