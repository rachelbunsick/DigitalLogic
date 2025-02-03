library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rachel_ruddy_FSM is
	Port (seq    : in std_logic;
			enable : in std_logic;
			reset  : in std_logic;
			clk    : in std_logic;
			out_1  : out std_logic;
			out_2  : out std_logic);
end rachel_ruddy_FSM;

architecture behavioral of rachel_ruddy_FSM is
	
	 -- States for FSM detecting "1011"
	 type fsm1_state_type is (S0, S1, S2, S3, S4);
    signal fsm1_state, fsm1_next_state : fsm1_state_type;

    -- States for FSM detecting "0010"
    type fsm2_state_type is (T0, T1, T2, T3, T4);
    signal fsm2_state, fsm2_next_state : fsm2_state_type;
	 
	 -- Active Low Reset
	 begin
		process(clk, reset)
		begin
			if reset = '0' then
            fsm1_state <= S0;
				fsm2_state <= T0;
			elsif rising_edge(clk) then
				if enable = '1' then
					fsm1_state <= fsm1_next_state;
					fsm2_state <= fsm2_next_state;
				else
					fsm1_state <= fsm1_state;
					fsm2_state <= fsm2_state;
            end if;
			end if;
		end process;
		
		-- FSM 1 Behavior
		process (fsm1_state, seq)
		begin
			out_1 <= '0';
			case fsm1_state is
            when S0 =>
                if seq = '1' then
                    fsm1_next_state <= S1;
                else
                    fsm1_next_state <= S0;
                end if;
            when S1 =>
                if seq = '0' then
                    fsm1_next_state <= S2;
                else
                    fsm1_next_state <= S1;
                end if;
            when S2 =>
                if seq = '1' then
                    fsm1_next_state <= S3;
                else
                    fsm1_next_state <= S0;
                end if;
				when S3 =>
                if seq = '1' then
                    fsm1_next_state <= S4;
                else
                    fsm1_next_state <= S2;
                end if;
            when S4 =>
                if seq = '1' then
                    fsm1_next_state <= S1;
						  out_1 <= '1';
                else
                    fsm1_next_state <= S2;
						  out_1 <= '1';
                end if;
            when others =>
                fsm1_next_state <= S0;
        end case;
    end process;
	 
	 -- FSM 2 Behavior
		process (fsm2_state, seq)
		begin
			out_2 <= '0';
			case fsm2_state is
            when T0 =>
                if seq = '0' then
                    fsm2_next_state <= T1;
                else
                    fsm2_next_state <= T0;
                end if;
            when T1 =>
                if seq = '0' then
                    fsm2_next_state <= T2;
                else
                    fsm2_next_state <= T0;
                end if;
            when T2 =>
                if seq = '1' then
                    fsm2_next_state <= T3;
                else
                    fsm2_next_state <= T2;
                end if;
				when T3 =>
                if seq = '0' then
                    fsm2_next_state <= T4;
                else
                    fsm2_next_state <= T1;
                end if;
            when T4 =>
                if seq = '1' then
                    fsm2_next_state <= T0;
						  out_2 <= '1';
                else
                    fsm2_next_state <= T2;
						  out_2 <= '1';
                end if;
            when others =>
                fsm2_next_state <= T0;
        end case;
    end process;
	
end behavioral;