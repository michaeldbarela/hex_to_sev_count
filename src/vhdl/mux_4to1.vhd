library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_4to1 is
    port( 
        sel     : in std_logic_vector(1 DOWNTO 0);
        count   : in std_logic_vector(15 DOWNTO 0);
        hex     : out std_logic_vector(3 DOWNTO 0)
    );
end mux_4to1;

architecture rtl of mux_4to1 is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------

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
    process(sel, count)
    begin
        case(sel) is
            when "00" => hex <= count(3 DOWNTO 0);
            when "01" => hex <= count(7 DOWNTO 4);
            when "10" => hex <= count(11 DOWNTO 8);
            when "11" => hex <= count(15 DOWNTO 12);
            when others => hex <= "0000";
        end case;
    end process;

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
