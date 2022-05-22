library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sev_seg_ctrl is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        count       : in std_logic_vector(15 DOWNTO 0);
        cathode     : out std_logic_vector(6 DOWNTO 0);
        anode       : out std_logic_vector(7 DOWNTO 0)
    );
end sev_seg_ctrl;

architecture rtl of sev_seg_ctrl is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal tick             : std_logic;
    signal counter_anode    : std_logic_vector(1 DOWNTO 0);
    signal hex_value        : std_logic_vector(3 DOWNTO 0);

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------
    component pulse_gen
        generic(
            -- Default values correspond to 4ms pulse
            BIT_WIDTH   : integer := 19;
            COUNT       : integer := 416667
        );
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            m_tick      : out std_logic     -- pulse_gen -> up_cnt_2b
        );
    end component;

    component up_cnt_2b
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            tick        : in std_logic;                     -- pulse_gen -> up_cnt_2b
            count       : out std_logic_vector(1 DOWNTO 0)  -- up_cnt_2b -> decoder_2to4 & mux_4to1
        );
    end component;

    component decoder_2to4
        port(
            counter     : in std_logic_vector(1 DOWNTO 0);  -- up_cnt_2b -> decoder_2to4
            anode       : out std_logic_vector(7 DOWNTO 0)  
        );
    end component;

    component mux_4to1
        port(
            sel     : in std_logic_vector(1 DOWNTO 0);      -- up_cnt_2b -> mux_4to1
            count   : in std_logic_vector(15 DOWNTO 0);     
            hex     : out std_logic_vector(3 DOWNTO 0)      -- mux_4to1 -> sev_seg_disp
        );
    end component;

    component sev_seg_disp
        port(
            value       : in std_logic_vector(3 DOWNTO 0);  -- mux_4to1 -> sev_seg_disp
            cathode     : out std_logic_vector(6 DOWNTO 0)
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
    u_pulse_gen_4ms: pulse_gen
        generic map(
            BIT_WIDTH => 19,
            COUNT     => 416667
        )
        port map(
            reset   => reset,
            clk     => clk,
            m_tick  => tick
        );

    u_up_cnt_2b: up_cnt_2b
        port map(
            reset   => reset,
            clk     => clk,
            tick    => tick,
            count   => counter_anode
        );

    u_decoder_2to4: decoder_2to4
        port map(
            counter => counter_anode,
            anode   => anode
        );

    u_mux_4to1: mux_4to1
        port map(
            sel     => counter_anode,
            count   => count,
            hex     => hex_value
        );

    u_sev_seg_disp: sev_seg_disp
        port map(
            value   => hex_value,
            cathode => cathode
        );

end rtl;
