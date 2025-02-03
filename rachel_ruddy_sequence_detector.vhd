library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity rachel_ruddy_sequence_detector is 
	Port (seq : in std_logic; 
		enable: in std_logic; 
		reset : in std_logic; 
		clk : in std_logic; 
		cnt_1 : out std_logic_vector(2 downto 0); -- Count for "1011" 
		cnt_2 : out std_logic_vector(2 downto 0) -- Count for "0010"
		); 
end rachel_ruddy_sequence_detector;

Architecture Behavioral of rachel_ruddy_sequence_detector is

	component rachel_ruddy_FSM is
		Port (seq    : in std_logic;
			enable : in std_logic;
			reset  : in std_logic;
			clk    : in std_logic;
			out_1  : out std_logic;
			out_2  : out std_logic);
	end component;

	signal out_1, out_2: std_logic := '0';
	signal count_1, count_2: unsigned(2 downto 0) := "000";
	
	begin

	FSM_inst: rachel_ruddy_FSM -- instantiate the sequence detector
		Port map (seq => seq, 
					 enable => enable, 
					 reset => reset, 
					 clk => clk, 
					 out_1 => out_1, 
					 out_2 => out_2 
					);
					
	Process (clk, reset)
		begin
			If reset = '0' then --overrides everything:
				count_2 <= "000"; --reset both counts to 0
				count_2 <= "000";
			elsif rising_edge(clk) then -- if not reset, then check to see what happens on rising edge 
				If enable = '1' then --if enable is on and sequence detected, add 1 to count(s)
					if out_1 = '1' then
						count_1 <= count_1 + 1;
					end if;
					If out_2 = '1' then 
					count_2 <= count_2 + 1;
					end if;
				end if;
			end if;
	end process;

		cnt_1 <= std_logic_vector(count_1); 
		cnt_2 <= std_logic_vector(count_2); 

end Behavioral;
