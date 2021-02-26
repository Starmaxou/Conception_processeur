-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 26.2.2021 07:53:26 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_CPU_8bits is
end tb_CPU_8bits;

architecture tb of tb_CPU_8bits is

    component CPU_8bits
        port (reset    : in std_logic;
              clk100M  : in std_logic;
              AN       : out std_logic_vector (7 downto 0);
              Sevenseg : out std_logic_vector (7 downto 0);
              LED      : out std_logic_vector (7 downto 0));
    end component;

    signal reset    : std_logic;
    signal clk100M  : std_logic;
    signal AN       : std_logic_vector (7 downto 0);
    signal Sevenseg : std_logic_vector (7 downto 0);
    signal LED      : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : CPU_8bits
    port map (reset    => reset,
              clk100M  => clk100M,
              AN       => AN,
              Sevenseg => Sevenseg,
              LED      => LED);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk100M is really your main clock signal
    clk100M <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '0';
        wait for 100 ns;
        reset <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 10000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;