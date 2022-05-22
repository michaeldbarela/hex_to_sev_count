library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sev_seg_disp is
    port( 
        value       : in std_logic_vector(3 DOWNTO 0);
        cathode     : out std_logic_vector(6 DOWNTO 0)
    );
end sev_seg_disp;

architecture rtl of sev_seg_disp is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal cathode_d : std_logic_vector(6 DOWNTO 0);

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    process(value)
    begin
        case(value) is
            when "0000" => cathode_d <= "0000001";
            when "0001" => cathode_d <= "1001111";
            when "0010" => cathode_d <= "0010010";
            when "0011" => cathode_d <= "0000110";
            when "0100" => cathode_d <= "1001100";
            when "0101" => cathode_d <= "0100100";
            when "0110" => cathode_d <= "0100000";
            when "0111" => cathode_d <= "0001111";
            when "1000" => cathode_d <= "0000000";
            when "1001" => cathode_d <= "0001100";
            when "1010" => cathode_d <= "0001000";
            when "1011" => cathode_d <= "1100000";
            when "1100" => cathode_d <= "0110001";
            when "1101" => cathode_d <= "1000010";
            when "1110" => cathode_d <= "0110000";
            when "1111" => cathode_d <= "0111000";
            when others => cathode_d <= "0000001";
        end case;
    end process;

    cathode <= cathode_d;

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
