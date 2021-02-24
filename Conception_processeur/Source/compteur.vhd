----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:33:14
-- Design Name: 
-- Module Name: compteur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur is
    Port ( CE : in STD_LOGIC;   -- Signal générique
           H : in STD_LOGIC;    -- Signal générique
           RST : in STD_LOGIC;  -- Signal générique
           load_cpt : in STD_LOGIC; -- Signal FSM
           en_cpt : in STD_LOGIC;   -- Signal FSM
           init_cpt : in STD_LOGIC; -- Signal FSM
           datain : in STD_LOGIC_VECTOR (5 downto 0);
           dataout : out STD_LOGIC_VECTOR (5 downto 0));
end compteur;

architecture Behavioral of compteur is

begin

    process(H,RST)
    variable cpt_value: integer range 0 to 63;
    begin
        if(RST = '1') then
            cpt_value := 0;
            dataout <= "000000";
        elsif (H'event and H ='1') then
            if (CE = '1') then
                if(init_cpt = '1') then
                    cpt_value := 0;
                elsif(load_cpt = '1') then
                    cpt_value := to_integer(unsigned( datain ));
                elsif(en_cpt = '1') then
                        cpt_value := cpt_value + 1;
                end if;
                
                dataout <= std_logic_vector(to_unsigned(cpt_value, 6));
            end if;
        end if;
        
    end process;


end Behavioral;
