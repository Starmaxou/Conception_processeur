-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.2.2021 10:03:10 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_memoire is
end tb_memoire;

architecture tb of tb_memoire is

    component memoire
        port (en_men   : in std_logic;
              R_W      : in std_logic;
              ce       : in std_logic;
              clk      : in std_logic;
              in_adr   : in std_logic_vector (5 downto 0);
              in_data  : in std_logic_vector (7 downto 0);
              out_data : out std_logic_vector (7 downto 0));
    end component;

    signal en_men   : std_logic;
    signal R_W      : std_logic;
    signal ce       : std_logic;
    signal clk      : std_logic;
    signal in_adr   : std_logic_vector (5 downto 0);
    signal in_data  : std_logic_vector (7 downto 0);
    signal out_data : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 1 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : memoire
    port map (en_men   => en_men,
              R_W      => R_W,
              ce       => ce,
              clk      => clk,
              in_adr   => in_adr,
              in_data  => in_data,
              out_data => out_data);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en_men <= '0';
        R_W <= '0';
        ce <= '0';
        in_adr <= (others => '0');
        in_data <= (others => '0');

        -- EDIT Add stimuli here
        wait for 10 * TbPeriod;
        en_men<='1';
        ce <= '1';
        R_W <= '0';
        in_adr <= "000001";
        
        wait for 10 * TbPeriod;
        en_men<='1';
        ce <= '1';
        R_W <= '0';
        in_adr <= "000010";
       
       wait for 10 * TbPeriod;
       en_men<='1';
       ce <= '1';
       R_W <= '0';
       in_adr <= "000011";
       
       wait for 10 * TbPeriod;
       en_men<='1';
       ce <= '1';
       R_W <= '1';
       in_data <= "10101010";
       in_adr <= "000011";
       
       wait for 10 * TbPeriod;
       en_men<='1';
       ce <= '1';
       R_W <= '0';
       in_data <= "10101010";
       in_adr <= "000011";
        
       
        
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;