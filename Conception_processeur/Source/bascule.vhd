----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:34:47
-- Design Name: 
-- Module Name: bascule - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bascule is
    
    Port ( 
       in_carry : in STD_LOGIC;
       load : in STD_LOGIC;
       clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       ce : in STD_LOGIC;
       init_carry : in STD_LOGIC;
       out_carry : out STD_LOGIC
       );
end bascule;


architecture Behavioral of bascule is

begin
    bascule : process(clk,reset)
        begin
            if(reset='1')then
                 out_carry <= '0';
            elsif clk = '1' and clk'event then
                if(ce='1')then
                    if( init_carry = '1') then
                        out_carry <= '0';                           
                    elsif(load = '1') then
                        out_carry <= in_carry;
                    end if;
                end if;
            end if;
    end process;


end Behavioral;
