library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library SimUAid_synthesis;
use SimUAid_synthesis.SimuAid_synthesis_pack.all;


entity SM is 
    port(X, clk, rst: in bit;
           Z: out bit);
end SM;

architecture SM_a of SM is
    signal state, nextstate: integer range 0 to 4:=0;
    signal state_output: std_logic_vector(2 downto 0);
    signal Q1, Q2, Q3: std_logic;

begin
    process(state, X)
    begin

        state_output <= conv_std_logic_vector(state,3);
        Q3 <= state_output(2);
        Q2 <= state_output(1);
        Q1 <= state_output(0);

        case state is
        when 0 =>
            if ( X = '0' ) then 
                Z <= '0';
                nextstate <= 2;
            else
                Z <= '0';
                nextstate <= 0;
            end if;
        when 1 =>
            if ( X = '0' ) then 
                Z <= '1';
                nextstate <= 3;
            else
                Z <= '0';
                nextstate <= 0;
            end if;
        when 2 =>
            if ( X = '0' ) then 
                Z <= '1';
                nextstate <= 3;
            else
                Z <= '0';
                nextstate <= 4;
            end if;
        when 3 =>
            if ( X = '0' ) then 
                Z <= '0';
                nextstate <= 3;
            else
                Z <= '0';
                nextstate <= 3;
            end if;
        when 4 =>
            if ( X = '0' ) then 
                Z <= '1';
                nextstate <= 2;
            else
                Z <= '0';
                nextstate <= 0;
            end if;
        end case;
    end process;


    process(clk , rst)
    begin
        if   (rst = '0') then
            state <= 0;
        elsif (clk'event and clk = '1') then 
            state <= nextstate; 
        end if;
    end process;
end SM_a;
