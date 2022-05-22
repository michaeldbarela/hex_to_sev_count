library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        uph_dnl     : in std_logic;
        inc         : in std_logic;
        cathode     : out std_logic_vector(6 DOWNTO 0);
        anode       : out std_logic_vector(7 DOWNTO 0)
    );
end top;

architecture rtl of top is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal aiso_rst   : std_logic;
    signal clean      : std_logic;
    signal ped        : std_logic;
    signal count      : std_logic_vector(15 DOWNTO 0);

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------
    component aiso_reset
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            aiso_reset  : out std_logic
        );
    end component;

    component debounce_top
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            noisy       : in std_logic;
            clean       : out std_logic
        );
    end component;

    component pos_edge_det
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            level       : in std_logic;
            ped         : out std_logic
        );
    end component;

    component counter
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            ped         : in std_logic;
            uph_dnl     : in std_logic;
            count       : out std_logic_vector(15 DOWNTO 0)
        );
    end component;

    component sev_seg_ctrl
        port(
            reset       : in std_logic;
            clk         : in std_logic;
            count       : in std_logic_vector(15 DOWNTO 0);
            cathode     : out std_logic_vector(6 DOWNTO 0);
            anode       : out std_logic_vector(7 DOWNTO 0)
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
    u_aiso_reset: aiso_reset
        port map(
            reset       => reset,
            clk         => clk,
            aiso_reset  => aiso_rst
        );

    u_debounce_top: debounce_top
        port map(
            reset       => aiso_rst,
            clk         => clk,
            noisy       => inc,
            clean       => clean
        );

    u_pos_edge_det: pos_edge_det
        port map(
            reset       => aiso_rst,
            clk         => clk,
            level       => clean,
            ped         => ped
        );

    u_counter: counter
        port map(
            reset       => aiso_rst,
            clk         => clk,
            ped         => ped,
            uph_dnl     => uph_dnl,
            count       => count
        );

    u_sev_seg_ctrl: sev_seg_ctrl
        port map(
            reset       => aiso_rst,
            clk         => clk,
            count       => count,
            cathode     => cathode,
            anode       => anode
        );

end rtl;
