----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:55:42
-- Design Name: 
-- Module Name: UAL - Behavioral
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

entity UAL is
    port(
        sel_UAL : in STD_LOGIC;
        in_dataA : in std_logic_vector(7 downto 0);
        in_dataB : in std_logic_vector(7 downto 0);
        out_carry : out STD_LOGIC;
        out_data : out std_logic_vector(7 downto 0)
        );
end UAL;

architecture Behavioral of UAL is
 signal save_data : std_logic_vector (8 downto 0);
begin
    UAL : process(sel_UAL,in_dataA, in_dataB)
        begin 
            if(sel_UAL='0')then
             save_data(7 downto 0) <= in_dataA NOR in_dataB;
             save_data(8)<='0';
            else
             save_data <= std_logic_vector( resize(unsigned(in_dataA), 9) + resize(unsigned(in_dataB), 9));
            end if;
    end process;
         out_data<= save_data(7 downto 0);
         out_carry<= save_data(8);
end Behavioral;
