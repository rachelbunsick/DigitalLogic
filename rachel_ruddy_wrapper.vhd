library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rachel_ruddy_wrapper is
	Port (reset   : in std_logic;
			clk     : in std_logic;
			HEX0    : out std_logic_vector(6 downto 0);
			HEX5    : out std_logic_vector(6 downto 0));
end rachel_ruddy_wrapper;

architecture behavior of rachel_ruddy_wrapper is
	
	component ROM is
		port(
		 clk : in std_logic;
		 reset : in std_logic;
		 data : out std_logic);
	end component;
	
	
	component seven_segment_decoder is
		Port   (code : in std_logic_vector (3 downto 0);
				  segments_out: out std_logic_vector(6 downto 0));
	end component;
	
	
	component rachel_ruddy_sequence_detector is
		Port (seq : in std_logic; 
				enable: in std_logic; 
				reset : in std_logic; 
				clk : in std_logic; 
				cnt_1 : out std_logic_vector(2 downto 0); -- Count for "1011" 
				cnt_2 : out std_logic_vector(2 downto 0) -- Count for "0010"
			); 
	end component;
	
	
	component rachel_ruddy_clock_divider is
		port (enable  : in std_logic;
		   reset   : in std_logic;
			clk     : in std_logic;
			en_out  : out std_logic);
	end component;
	
	signal enable : std_logic := '1';
	signal clk2   : std_logic := '0';
	signal data   : std_logic := '0';
	signal cnt_1  : std_logic_vector(2 downto 0);
	signal cnt_2  : std_logic_vector(2 downto 0);
	signal u_cnt_1  : unsigned(3 downto 0);
	signal u_cnt_2  : unsigned(3 downto 0);
	signal new_cnt_1  : std_logic_vector(3 downto 0) := "0000";
	signal new_cnt_2  : std_logic_vector(3 downto 0) := "0000";
	signal decoded_cnt1   : std_logic_vector(6 downto 0);
	signal decoded_cnt2   : std_logic_vector(6 downto 0);
	
	begin
	
	i1: rachel_ruddy_clock_divider port map (enable, reset, clk, clk2);
	i2: ROM port map (clk2, reset, data);
	i3: rachel_ruddy_sequence_detector port map (data, enable, reset, clk2, cnt_1, cnt_2);
	
	u_cnt_1 <= '0' & unsigned(cnt_1);
	new_cnt_1 <= std_logic_vector(u_cnt_1);
	u_cnt_2 <= '0' & unsigned(cnt_2);
	new_cnt_2 <= std_logic_vector(u_cnt_2);
	
	i4: seven_segment_decoder port map (new_cnt_1, decoded_cnt1);
	i5: seven_segment_decoder port map (new_cnt_2, decoded_cnt2);
	
	HEX0 <= decoded_cnt1;
	HEX5 <= decoded_cnt2;
	
end behavior;
		