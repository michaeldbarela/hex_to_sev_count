library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        noisy       : in std_logic;
        m_tick      : in std_logic;
        clean       : out std_logic
    );
end debounce;

architecture rtl of debounce is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal deb_in       : std_logic;
    type t_state is (zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3);
    signal state_q      : t_state;
    signal state_d      : t_state;
    
begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    -- current state logic
    process(clk, reset) begin
        if(clk'event and clk = '1') then
            if(reset = '0') then
                state_q <= zero;
            else
                state_q <= state_d;
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    -- next state logic
    process(state_q, m_tick, noisy)
        variable cat : std_logic_vector(4 DOWNTO 0);
    begin
        case?(cat) is
            -- zero
            when "000-0" =>
                state_d <= zero;
                deb_in <= '0';
            when "000-1" =>
                state_d <= wait1_1;
                deb_in <= '0';
            -- wait1_1
            when "001-0" =>
                state_d <= zero;
                deb_in <= '0';
            when "00101" =>
                state_d <= wait1_1;
                deb_in <= '0';
            when "00111" =>
                state_d <= wait1_2;
                deb_in <= '0';
            -- wait1_2
            when "010-0" =>
                state_d <= zero;
                deb_in <= '0';
            when "01001" =>
                state_d <= wait1_2;
                deb_in <= '0';
            when "01011" =>
                state_d <= wait1_3;
                deb_in <= '0';
            -- wait1_3
            when "011-0" =>
                state_d <= zero;
                deb_in <= '0';
            when "01101" =>
                state_d <= wait1_3;
                deb_in <= '0';
            when "01111" =>
                state_d <= one;
                deb_in <= '1';
            -- one
            when "100-0" =>
                state_d <= wait0_1;
                deb_in <= '1';
            when "100-1" =>
                state_d <= one;
                deb_in <= '1';
            -- wait0_1
            when "10100" =>
                state_d <= wait0_1;
                deb_in <= '1';
            when "10110" =>
                state_d <= wait0_2;
                deb_in <= '1';
            when "101-1" =>
                state_d <= one;
                deb_in <= '1';
            -- wait0_2
            when "11000" =>
                state_d <= wait0_2;
                deb_in <= '1';
            when "11010" =>
                state_d <= wait0_3;
                deb_in <= '1';
            when "110-1" =>
                state_d <= one;
                deb_in <= '1';
            -- wait0_3
            when "11100" =>
                state_d <= wait0_3;
                deb_in <= '1';
            when "11110" =>
                state_d <= zero;
                deb_in <= '0';
            when "111-1" =>
                state_d <= one;
                deb_in <= '1';
            -- default
            when others =>
                state_d <= zero;
                deb_in  <= '0';
        end case?;
    end process;

    -- output debounced signal
    clean <= deb_in;

end rtl;
