library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light is
    Port (
        clk     : in  STD_LOGIC;   
        reset   : in  STD_LOGIC;   
        red     : out STD_LOGIC;    
        yellow  : out STD_LOGIC;  
        green   : out STD_LOGIC    
    );
end traffic_light;

architecture Behavioral of traffic_light is
    signal counter : unsigned(31 downto 0) := (others => '0'); -- 32-bit counter
    signal slow_clk : STD_LOGIC := '0';                        -- divided clock
    signal state : integer range 0 to 2 := 0;                  -- 0=red, 1=green, 2=yellow
begin

    -- counter
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    -- use bit 31 as divided clock
    slow_clk <= counter(31);

    -- FSM
    process(slow_clk, reset)
    begin
        if reset = '1' then
            state <= 0;
        elsif rising_edge(slow_clk) then
            if state = 2 then
                state <= 0;
            else
                state <= state + 1;
            end if;
        end if;
    end process;

    -- outputs
    red    <= '1' when state = 0 else '0';
    green  <= '1' when state = 1 else '0';
    yellow <= '1' when state = 2 else '0';

end Behavioral;
