library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter32 is
    Port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        en    : in  std_logic;
        q     : out std_logic_vector(31 downto 0)
    );
end counter32;

architecture Behavioral of counter32 is
    signal count : unsigned(31 downto 0) := (others => '0');
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count <= (others => '0');                 -- rst
        elsif rising_edge(clk) then
            if en = '1' then
                count <= count + 1;                   -- counter++
            end if;
        end if;
    end process;

    q <= std_logic_vector(count);                     -- casting
end Behavioral;
