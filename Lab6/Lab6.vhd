entity SM is 
    port(RSI, LSI, R, L, clk, clrn: in bit;
           RSO, LSO: out bit);
end SM;

architecture Register6_bit of SM is
    signal R0, R1, R2, R3, R4, R5: bit;
    signal state, nextstate: integer range 0 to 2:=0;

begin
    process(state, R, L)
    begin
        case state is
        when 0 =>
            --Store value
            RSO <= RSI;
            LSO <= R5;
            --Shift Left
            R0 <= R1;
            R1 <= R2;
            R2 <= R3;
            R3 <= R4;
            R4 <= R5;
            R5 <= RSI;
            if ( R = '0' and L = '1' ) then 
               nextstate <= 0;
            elsif  ( R = '1' and L = '0') then
               nextstate <= 1;
            else
               nextstate <= 2;
            end if;
        when 1 =>
         --Store value
            RSO <= R5;
            LSO <= LSI;
            --Shift Right
            R5 <= R4;
            R4 <= R3;
            R3 <= R2;
            R2 <= R1;
            R1 <= R0;
            R0 <= LSI;
            if ( R = '0' and L = '1' ) then 
                nextstate <= 0;
            elsif  ( R = '1' and L = '0') then
                nextstate <= 1;
            else
                nextstate <= 2;
            end if;
       when 2 =>
            if ( R = '0' and L = '1' ) then 
                nextstate <= 0;
            elsif  ( R = '1' and L = '0') then
                nextstate <= 1;
            else
                nextstate <= 2;
            end if;
       when 3 =>
            RSO <= '0';
            LSO <= '0';
            R5 <= '0';
            R4 <= '0';
            R3 <= '0';
            R2 <= '0';
            R1 <= '0';
            R0 <= '0';
            if ( R = '0' and L = '1' ) then 
                nextstate <= 0;
            elsif  ( R = '1' and L = '0') then
                nextstate <= 1;
            else
                nextstate <= 2;
            end if;
        end case;
    end process;

    process(clk, clrn)
    begin
      
        if   (clrn = '1') then
            state <= 3;
        elsif (clk'event and clk = '1') then 
            state <= nextstate; 
        end if;
    end process;
end Register6_bit;
