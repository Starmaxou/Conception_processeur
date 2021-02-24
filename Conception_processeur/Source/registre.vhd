----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:25:40
-- Design Name: 
-- Module Name: registre - Behavioral
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

entity registre is
     port (
    in_data : in std_logic_vector(7 downto 0);
    load_reg : in std_logic;
    ce : in std_logic;
    clk : in std_logic;
    reset : in std_logic;
    out_data : out std_logic_vector(7 downto 0)
    );
end registre;

architecture Behavioral of registre is

begin

    resgistre : process(clk,reset)
        begin
            if(reset='1')then
                out_data <= (others => '0');
            elsif clk = '1' and clk'event then
                if(ce='1')then
                    if load_reg = '1' then
                        out_data <= in_data;
                    end if;
                end if;
            end if;
    end process;
end Behavioral;
