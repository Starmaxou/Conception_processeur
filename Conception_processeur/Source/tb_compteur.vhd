-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.2.2021 07:56:27 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_compteur is
end tb_compteur;

architecture tb of tb_compteur is

    component compteur
        port (CE       : in std_logic;
              H        : in std_logic;
              RST      : in std_logic;
              load_cpt : in std_logic;
              en_cpt   : in std_logic;
              init_cpt : in std_logic;
              datain   : in std_logic_vector (5 downto 0);
              dataout  : out std_logic_vector (5 downto 0));
    end component;

    signal CE       : std_logic;
    signal H        : std_logic;
    signal RST      : std_logic;
    signal load_cpt : std_logic;
    signal en_cpt   : std_logic;
    signal init_cpt : std_logic;
    signal datain   : std_logic_vector (5 downto 0);
    signal dataout  : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : compteur
    port map (CE       => CE,
              H        => H,
              RST      => RST,
              load_cpt => load_cpt,
              en_cpt   => en_cpt,
              init_cpt => init_cpt,
              datain   => datain,
              dataout  => dataout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    H <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        load_cpt <= '0';
        en_cpt <= '0';
        init_cpt <= '0';
        datain <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 10 * TbPeriod;
        en_cpt <='1';
        wait for 10 * TbPeriod;
        CE <= '1';
        wait for 100 * TbPeriod;
        init_cpt <= '1';
        wait for 10 * TbPeriod;
        init_cpt <= '0';
        wait for 10 * TbPeriod;
        datain <= std_logic_vector(to_unsigned(12, 6));
        wait for 100 * TbPeriod;
        load_cpt <= '1';
        wait for 10 * TbPeriod;
        load_cpt <= '0';
        wait for 100 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;