library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mult4x3plus3 is
    port (Clk, St: in std_logic;
    BusValue : in std_logic_vector(3 downto 0);
    Rst : in std_logic;
    Done: out std_logic;
    W: out std_logic_vector (6 downto 0));
end mult4x3plus3;

architecture Wproduct of mult4x3plus3 is
    signal State: integer range 0 to 12;
    signal ACC : std_logic_vector(7 downto 0);
    signal Y, Z : std_logic_vector(2 downto 0);
    alias M: std_logic is ACC(0);
    begin
       W <= ACC(6 downto 0);
       process(Clk, Rst)
       begin
         if Clk'event and Clk = '1' and Rst = '0' then
         case State is
         when 0 =>
            if St = '1' then
               ACC(7 downto 4) <= "0000";
               ACC(3 downto 0) <= BusValue;
               State <= 1;
            end if;
         when 1 =>
            Y <= BusValue(2 downto 0);
            State <= 2;
         when 2 =>
            Z <= BusValue(2 downto 0);
            State <= 3;
         when 3|5|7|9 =>
            if M = '1' then
               ACC(7 downto 4) <= ('0'&ACC(6 downto 4)) + Y;
               State <= State + 1;
            else ACC <= '0'&ACC(7 downto 1);
               State <= State + 2;
            end if;
         when 4|6|8|10 =>
            ACC <= '0'&ACC(7 downto 1);
            State <= State + 1;
         when 11 =>
            ACC <= ('0'&ACC(6 downto 0)) + ("00000"&Z);
            State <= 12;
         when 12 =>
            State <= 0;
         end case;
         elsif Rst = '1' then
            ACC(7 downto 0) <= "00000000";
            State <= 0;
         end if;
       end process;
       Done <= '1' when State = 12 else '0';
    end Wproduct;
