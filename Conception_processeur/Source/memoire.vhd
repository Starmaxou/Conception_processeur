----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 10:00:18
-- Design Name: 
-- Module Name: memoire - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire is
 port (
    en_men : in std_logic;
    R_W : in std_logic;
    ce : in std_logic;
    clk : in std_logic;
    in_adr : in std_logic_vector(5 downto 0);
    in_data: in std_logic_vector(7 downto 0);
    out_data : out std_logic_vector(7 downto 0)
    );
        
end memoire;

architecture Behavioral of memoire is
type tab_mem is array (0 to 63) of std_logic_vector(7 downto 0);
signal my_table : tab_mem := (X"08", X"47", X"86", X"C4", X"C4", X"00", X"00", X"7E", X"FE", others => X"00");
begin
    mem : process(clk)
    begin
        if(clk = '0' and clk'event) then
         if(ce='1') then
            if(en_men='1')then
                if(R_W ='0') then
                    out_data <= my_table(to_integer(unsigned(in_adr)));
                else
                    my_table(to_integer(unsigned(in_adr)))<=in_data;
                end if;
            end if;
         end if;
        end if;
    end process;
end Behavioral;
