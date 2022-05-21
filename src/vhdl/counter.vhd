library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        ped         : in std_logic;
        uph_dnl     : in std_logic;
        count       : out std_logic_vector(15 DOWNTO 0)
    );
end counter;

architecture rtl of counter is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal count_q : std_logic_vector(15 DOWNTO 0);
    signal count_d : std_logic_vector(15 DOWNTO 0);
    
begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    -- current state logic
    process(clk, reset) begin
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
    -- next state logic
    process(count_q, ped, uph_dnl)
        variable cat : std_logic_vector(1 DOWNTO 0) := ped & uph_dnl;
    begin
        case(cat) is
            when "00" => count_d <= count_q;
            when "01" => count_d <= count_q;
            when "10" => count_d <= std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) - 1, count_d'length));
            when "11" => count_d <= std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) + 1, count_d'length));
            when others => count_d <= count_q;
        end case;
    end process;

    -- output count
    count <= count_q;

end rtl;
