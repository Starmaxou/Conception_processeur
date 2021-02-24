----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 11:08:56
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

entity Control_Unit is
    Port (     CE : in std_logic;
               H : in std_logic;
               RST : in std_logic;     
               carry : in STD_LOGIC;
               read_mem : in STD_LOGIC_VECTOR(7 downto 0);
               A_sel_UAL : out std_logic;
               B_load_reg_accu : out STD_LOGIC;
               C_load_reg_data : out STD_LOGIC;
               D_load_carry : out STD_LOGIC;
               E_init_carry : out STD_LOGIC;
               K_en_mem : out STD_LOGIC;
               L_RW_mem : out STD_LOGIC;
               adr_mem : out STD_LOGIC_VECTOR(5 downto 0));
               
end Control_Unit;

architecture Behavioral of Control_Unit is
    -- Déclaration des différents composant de l'unité de contrôle
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
    
    component mux
         port( sel_mux  :in STD_LOGIC;
               in_dataA : in STD_LOGIC_VECTOR (5 downto 0);
               in_dataB : in STD_LOGIC_VECTOR (5 downto 0);
               out_data : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    
    component registre
        port ( in_data  : in std_logic_vector(7 downto 0);
               load_reg : in std_logic;
               ce       : in std_logic;
               clk      : in std_logic;
               reset    : in std_logic;
               out_data : out std_logic_vector(7 downto 0));
    end component;
    
    -- Définition des signaux internes
    signal datain   : std_logic_vector (5 downto 0);
    signal cpt_out  : std_logic_vector (5 downto 0);
    
    signal code_op         : std_logic_vector (1 downto 0);

    signal F_load_reg_inst : std_logic;
    signal G_sel_mux       : std_logic;
    signal H_load_cpt_adr  : std_logic;
    signal I_en_cpt_adr    : std_logic;
    signal J_init_cpt_adr  : std_logic;

    signal add_mem : std_logic_vector(5 downto 0);
    signal cpt_adr_load : std_logic_vector(5 downto 0);
        
begin
                     
    Machine_Etat : FSM
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
                
     Compteur_Adresses : compteur
        port map (CE       => CE,
                  H        => H,
                  RST      => RST,
                  load_cpt => H_load_cpt_adr,
                  en_cpt   => I_en_cpt_adr,
                  init_cpt => J_init_cpt_adr,
                  datain   => cpt_adr_load,
                  dataout  => cpt_out);
                  
    Multiplexeur : mux
        port map(sel_mux => G_sel_mux,
                in_dataA => cpt_adr_load,
                in_dataB => cpt_out,
                out_data => adr_mem
                );
                
    Registre_instruction : registre
        port map(
                ce => CE,
                clk => H,
                reset => RST,
                in_data => read_mem,
                load_reg => F_load_reg_inst,
                out_data(7 downto 6) => code_op,
                out_data(5 downto 0) =>  cpt_adr_load
                );
end Behavioral;
