
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.2.2021 08:45:34 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_UAL is
end tb_UAL;

architecture tb of tb_UAL is

    component UAL
        port (sel_UAL   : in std_logic;
              in_dataA  : in std_logic_vector (7 downto 0);
              in_dataB  : in std_logic_vector (7 downto 0);
              out_carry : out std_logic;
              out_data  : out std_logic_vector (7 downto 0));
    end component;

    signal sel_UAL   : std_logic;
    signal in_dataA  : std_logic_vector (7 downto 0);
    signal in_dataB  : std_logic_vector (7 downto 0);
    signal out_carry : std_logic;
    signal out_data  : std_logic_vector (7 downto 0);

begin

    dut : UAL
    port map (sel_UAL   => sel_UAL,
              in_dataA  => in_dataA,
              in_dataB  => in_dataB,
              out_carry => out_carry,
              out_data  => out_data);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        sel_UAL <= '0';
        in_dataA <= (others => '0');
        in_dataB <= (others => '0');
        wait for 100ns;
        sel_UAL <= '0';
        in_dataA <= "00001000";
        in_dataB <= "00001011";
        wait for 100ns;
        sel_UAL <= '0';
        in_dataA <= "11111111";
        in_dataB <= "11101001";
        wait for 100ns;
        sel_UAL <= '1';
        in_dataA <= "00111111";
        in_dataB <= "00001001";
        wait for 100ns;
        sel_UAL <= '1';
        in_dataA <= "11111111";
        in_dataB <= "00000001";
        wait for 100ns;
        sel_UAL <= '1';
        in_dataA <= "11111111";
        in_dataB <= "11111111";
        
        -- EDIT Add stimuli here
       
        wait;
    end process;

end tb;