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
        variable cat : std_logic_vector(1 DOWNTO 0) := m_tick & noisy;
    begin
        case(state_q) is
            -- zero
            when zero =>
                case?(cat) is
                    when "-0" =>
                        state_d <= zero;
                        deb_in <= '0';
                    when "-1" =>
                        state_d <= wait1_1;
                        deb_in <= '0';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait1_1
            when wait1_1 =>
                case?(cat) is
                    when "-0" =>
                        state_d <= zero;
                        deb_in <= '0';
                    when "01" =>
                        state_d <= wait1_1;
                        deb_in <= '0';
                    when "11" =>
                        state_d <= wait1_2;
                        deb_in <= '0';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait1_2
            when wait1_2 =>
                case?(cat) is
                    when "-0" =>
                        state_d <= zero;
                        deb_in <= '0';
                    when "01" =>
                        state_d <= wait1_2;
                        deb_in <= '0';
                    when "11" =>
                        state_d <= wait1_3;
                        deb_in <= '0';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait1_3
            when wait1_3 =>
                case?(cat) is
                    when "-0" =>
                        state_d <= zero;
                        deb_in <= '0';
                    when "01" =>
                        state_d <= wait1_3;
                        deb_in <= '0';
                    when "11" =>
                        state_d <= one;
                        deb_in <= '1';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- one
            when one =>
                case?(cat) is
                    when "-0" =>
                        state_d <= wait0_1;
                        deb_in <= '1';
                    when "-1" =>
                        state_d <= one;
                        deb_in <= '1';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait0_1
            when wait0_1 =>
                case?(cat) is
                    when "00" =>
                        state_d <= wait0_1;
                        deb_in <= '1';
                    when "10" =>
                        state_d <= wait0_2;
                        deb_in <= '1';
                    when "-1" =>
                        state_d <= one;
                        deb_in <= '1';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait0_2
            when wait0_2 =>
                case?(cat) is
                    when "00" =>
                        state_d <= wait0_2;
                        deb_in <= '1';
                    when "10" =>
                        state_d <= wait0_3;
                        deb_in <= '1';
                    when "-1" =>
                        state_d <= one;
                        deb_in <= '1';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- wait0_3
            when wait0_3 =>
                case?(cat) is
                    when "00" =>
                        state_d <= wait0_3;
                        deb_in <= '1';
                    when "10" =>
                        state_d <= zero;
                        deb_in <= '0';
                    when "-1" =>
                        state_d <= one;
                        deb_in <= '1';
                    when others =>
                        state_d <= zero;
                        deb_in <= '0';
                end case?;
            -- default
            when others =>
                state_d <= zero;
                deb_in  <= '0';
        end case;
    end process;

    -- output debounced signal
    clean <= deb_in;

end rtl;
