library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_gen is
    generic(
        -- default values corresepond to 10ms pulse
        BIT_WIDTH   : integer := 19;
        COUNT       : integer := 999999
    );
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        m_tick      : out std_logic
    );
end pulse_gen;

architecture rtl of debounce_top is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal count_q  : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);
    signal count_d  : std_logic_vector(BIT_WIDTH-1 DOWNTO 0);

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    -- current-state logic
    process(clk, reset)
    begin
        if(clk'event and clk = '1') then
            if(reset = '0') then
                count_q <= (others=>'0');
            else
                count_q <= count_d;
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    -- next-state logic
    count_d <= (others=>'0') when to_integer(unsigned(count_q)) = COUNT
                else std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) + 1), count_d'length);

    -- output tick
    m_tick <= '1' when to_integer(unsigned(count_q)) = COUNT
                else '0';

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
