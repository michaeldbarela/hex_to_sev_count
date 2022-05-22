library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up_cnt_2b is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        tick        : in std_logic;
        count       : out std_logic_vector(1 DOWNTO 0)
    );
end up_cnt_2b;

architecture rtl of up_cnt_2b is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal count_q  : std_logic_vector(1 DOWNTO 0);
    signal count_d  : std_logic_vector(1 DOWNTO 0);

----------------------------------------------------------------------------------
-- COMPONENT DECLARATIONS
----------------------------------------------------------------------------------

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
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
    process(tick, count_q)
    begin
        case(tick) is
            when '0' => count_d <= count_q;
            when '1' => 
                count_d <= (others=>'0') when count_q = "11" 
                            else std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) + 1, count_d'length));
            when others => count_d <= count_q;
        end case;
    end process;

    count <= count_q;

----------------------------------------------------------------------------------
-- COMPONENT INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
