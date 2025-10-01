library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity traffic_light is
    Port (
        clk     : in  STD_LOGIC;   -- کلاک اصلی
        reset   : in  STD_LOGIC;   -- ریست
        red     : out STD_LOGIC;   -- چراغ قرمز
        yellow  : out STD_LOGIC;   -- چراغ زرد
        green   : out STD_LOGIC    -- چراغ سبز
    );
end traffic_light;

architecture Behavioral of traffic_light is
    signal counter : unsigned(31 downto 0) := (others => '0'); -- کانتر ۳۲ بیتی
    signal slow_clk : STD_LOGIC := '0';                        -- کلاک تقسیم‌شده
    signal state : integer range 0 to 2 := 0;                  -- وضعیت چراغ (0=قرمز, 1=سبز, 2=زرد)
begin

    -- کانتر
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    -- استفاده از بیت 31 به عنوان کلاک تقسیم‌شده (چون اندیس از 0 شروع میشه، بیت 31 همون بیت 32 امه)
    slow_clk <= counter(31);

    -- FSM چراغ راهنما
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

    -- خروجی چراغ‌ها
    red    <= '1' when state = 0 else '0';
    green  <= '1' when state = 1 else '0';
    yellow <= '1' when state = 2 else '0';

end Behavioral;