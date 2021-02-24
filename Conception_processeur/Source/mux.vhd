----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:46:14
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    port(
        sel_mux :in STD_LOGIC;
        in_dataA : in STD_LOGIC_VECTOR (5 downto 0);
        in_dataB : in STD_LOGIC_VECTOR (5 downto 0);
        out_data : out STD_LOGIC_VECTOR (5 downto 0)
        );
--  Port ( );
end mux;

architecture Behavioral of mux is

begin
    mux : process(sel_mux,in_dataA,in_dataB)
        begin
        if(sel_mux='1')then
             out_data<= in_dataA;
        else
             out_data<= in_dataB;
        end if;
    end process;
    
    
    


end Behavioral;
