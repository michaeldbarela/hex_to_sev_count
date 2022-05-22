library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pos_edge_det is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        level       : in std_logic;
        ped         : out std_logic
    );
end pos_edge_det;

architecture rtl of pos_edge_det is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal delay_q : std_logic_vector(1 DOWNTO 0);
    signal delay_d : std_logic_vector(1 DOWNTO 0);
    
begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    -- current state logic
    process(clk, reset) begin
        if(clk'event and clk = '1') then
            if(reset = '0') then
                delay_q <= (others=>'0');
            else
                delay_q <= delay_d;
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    -- next state logic
    delay_d <= delay_q(0) & level;
    -- output
    ped <= not(delay_q(1)) and delay_q(0);

end rtl;
