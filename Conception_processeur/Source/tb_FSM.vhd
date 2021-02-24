-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.2.2021 09:37:04 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_FSM is
end tb_FSM;

architecture tb of tb_FSM is

    component FSM
        port (CE              : in std_logic;
              H               : in std_logic;
              RST             : in std_logic;
              carry           : in std_logic;
              code_op         : in std_logic_vector (1 downto 0);
              A_sel_UAL       : out std_logic;
              B_load_reg_accu : out std_logic;
              C_load_reg_data : out std_logic;
              D_load_carry    : out std_logic;
              E_init_carry    : out std_logic;
              F_load_reg_inst : out std_logic;
              G_sel_mux       : out std_logic;
              H_load_cpt_adr  : out std_logic;
              I_en_cpt_adr    : out std_logic;
              J_init_cpt_adr  : out std_logic;
              K_en_mem        : out std_logic;
              L_RW_mem        : out std_logic);
    end component;

    signal CE              : std_logic;
    signal H               : std_logic;
    signal RST             : std_logic;
    signal carry           : std_logic;
    signal code_op         : std_logic_vector (1 downto 0);
    signal A_sel_UAL       : std_logic;
    signal B_load_reg_accu : std_logic;
    signal C_load_reg_data : std_logic;
    signal D_load_carry    : std_logic;
    signal E_init_carry    : std_logic;
    signal F_load_reg_inst : std_logic;
    signal G_sel_mux       : std_logic;
    signal H_load_cpt_adr  : std_logic;
    signal I_en_cpt_adr    : std_logic;
    signal J_init_cpt_adr  : std_logic;
    signal K_en_mem        : std_logic;
    signal L_RW_mem        : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : FSM
    port map (CE              => CE,
              H               => H,
              RST             => RST,
              carry           => carry,
              code_op         => code_op,
              A_sel_UAL       => A_sel_UAL,
              B_load_reg_accu => B_load_reg_accu,
              C_load_reg_data => C_load_reg_data,
              D_load_carry    => D_load_carry,
              E_init_carry    => E_init_carry,
              F_load_reg_inst => F_load_reg_inst,
              G_sel_mux       => G_sel_mux,
              H_load_cpt_adr  => H_load_cpt_adr,
              I_en_cpt_adr    => I_en_cpt_adr,
              J_init_cpt_adr  => J_init_cpt_adr,
              K_en_mem        => K_en_mem,
              L_RW_mem        => L_RW_mem);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    H <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        carry <= '0';
        code_op <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 10 * TbPeriod;
        CE <= '1';
        wait for 10 * TbPeriod;
        code_op <= "10";
        wait for 10 * TbPeriod;
        code_op <= "11";
        wait for 10 * TbPeriod;
        carry <= '1';
        wait for 100 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;