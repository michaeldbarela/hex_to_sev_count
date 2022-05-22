library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_top is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        noisy       : in std_logic;
        clean       : out std_logic
    );
end debounce_top;

architecture rtl of debounce_top is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal m_tick       : std_logic;

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------
    component pulse_gen
        generic(
            -- Default values correspond to 10ms pulse
            BIT_WIDTH   : integer := 20;
            COUNT       : integer := 999999
        );
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            m_tick      : out std_logic     -- pulse_gen_10ms -> debounce
        );
    end component;

    component debounce
        port( 
            reset       : in std_logic;
            clk         : in std_logic;
            noisy       : in std_logic;
            m_tick      : in std_logic;     -- pulse_gen_10ms -> debounce
            clean       : out std_logic
        );
    end component;

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------
    u_pulse_gen_10ms: pulse_gen
        generic map(
            BIT_WIDTH => 20,
            COUNT     => 999999
        )
        port map(
            reset   => reset,
            clk     => clk,
            m_tick  => m_tick
        );

    -- debounce
    u_debounce: debounce
        port map(
            reset   => reset,
            clk     => clk,
            noisy   => noisy,
            m_tick  => m_tick,
            clean   => clean
        );

end rtl;
