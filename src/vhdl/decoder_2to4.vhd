library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_2to4 is
    port( 
        counter     : in std_logic_vector(1 DOWNTO 0);
        anode       : out std_logic_vector(7 DOWNTO 0)
    );
end decoder_2to4;

architecture rtl of decoder_2to4 is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal decoder  : std_logic_vector(7 DOWNTO 0);

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
    process(counter)
    begin
        case(counter) is
            when "00" => decoder <= "00000001";
            when "01" => decoder <= "00000010";
            when "10" => decoder <= "00000100";
            when "11" => decoder <= "00001000";
            when others => decoder <= "00000000";
        end case;
    end process;

    anode <= not(decoder);

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
