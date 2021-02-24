----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 09:38:01
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( CE : in STD_LOGIC;
           H : in STD_LOGIC;
           RST : in STD_LOGIC;
           carry : in STD_LOGIC;
           code_op : in STD_LOGIC_VECTOR (1 downto 0);
           A_sel_UAL : out STD_LOGIC;
           B_load_reg_accu : out STD_LOGIC;
           C_load_reg_data : out STD_LOGIC;
           D_load_carry : out STD_LOGIC;
           E_init_carry : out STD_LOGIC;
           F_load_reg_inst : out STD_LOGIC;
           G_sel_mux : out STD_LOGIC;
           H_load_cpt_adr : out STD_LOGIC;
           I_en_cpt_adr : out STD_LOGIC;
           J_init_cpt_adr : out STD_LOGIC;
           K_en_mem : out STD_LOGIC;
           L_RW_mem : out STD_LOGIC );
end FSM;

architecture Behavioral of FSM is

    type Etat is ( Etat_init, Etat_Fetch_Inst, Etat_Decode, Etat_Fetch_Ope, Etat_Ex_UAL, Etat_Ex_STA, Etat_Ex_JCC );
	signal pr_state , nx_state : Etat := Etat_init;
	
begin

    maj_etat : process ( H , RST )
    begin
        if (RST ='1') then
            pr_state <= Etat_init ;
        elsif ( H' event and H ='1') then
            if(CE = '1') then
            	pr_state <= nx_state ;
            end if;
        end if;
    end process maj_etat;
    
    cal_nx_state : process (pr_state, code_op)
        begin
            case pr_state is
                when Etat_init =>
                    --if (RST = '0') then
                        nx_state <= Etat_Fetch_Inst;
                    --end if;
                    
                when Etat_Fetch_Inst =>
                    nx_state <= Etat_Decode;
                    
                when Etat_Decode =>
                    if(code_op = "10") then
                        nx_state <= Etat_Ex_STA;
                    elsif(code_op = "11") then
                        nx_state <= Etat_Ex_JCC;
                    else -- code_op(1) = '0'
                        nx_state <= Etat_Fetch_Ope;
                    end if;
                    
                when Etat_Fetch_Ope =>
                    nx_state <= Etat_Ex_UAL;
                    
                when others =>
                    nx_state <= Etat_Fetch_Inst;
            end case;
        end process cal_nx_state;
    
    cal_output : process( pr_state, code_op, carry )
        begin
            case pr_state is
                when Etat_Init =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '0';
                    D_load_carry <= '0';
                    E_init_carry <= '1';    -- actif
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '0';
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '1';  -- actif
                    K_en_mem <= '0';
                    L_RW_mem <= '0';
                                    
                when Etat_Fetch_Inst =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '0';
                    D_load_carry <= '0';
                    E_init_carry <= '0';
                    F_load_reg_inst <= '1'; -- actif
                    G_sel_mux <= '0';
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '1';    -- actif
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '1';        -- actif
                    L_RW_mem <= '0';
                    
                    
                when Etat_Decode =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '0';
                    D_load_carry <= '0';
                    E_init_carry <= '0';
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '1';       -- actif
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '0';
                    L_RW_mem <= '0';
                                        
                when Etat_Fetch_Ope =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '1'; -- actif
                    D_load_carry <= '0';
                    E_init_carry <= '0';
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '1';       -- actif
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '1';        -- actif
                    L_RW_mem <= '0';
                             
                when Etat_Ex_UAL =>
                    A_sel_UAL <= code_op(0);    -- actif
                    B_load_reg_accu <= '1';     -- actif
                    C_load_reg_data <= '0';
                    D_load_carry <= code_op(0); -- actif
                    E_init_carry <= '0';
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '1';           -- actif
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '0';
                    L_RW_mem <= '0';
                                                           
                when Etat_Ex_STA =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '0';
                    D_load_carry <= '0';
                    E_init_carry <= '0';
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '1';       -- actif
                    H_load_cpt_adr <= '0';
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '1';        -- actif
                    L_RW_mem <= '1';        -- actif
                    
                when Etat_Ex_JCC =>
                    A_sel_UAL <= '0';
                    B_load_reg_accu <= '0';
                    C_load_reg_data <= '0';
                    D_load_carry <= '0';
                    E_init_carry <= carry;  -- actif
                    F_load_reg_inst <= '0';
                    G_sel_mux <= '1';       -- actif
                    H_load_cpt_adr <= not(carry);   -- actif
                    I_en_cpt_adr <= '0';
                    J_init_cpt_adr <= '0';
                    K_en_mem <= '0';
                    L_RW_mem <= '0';
                                                    
            end case;
        end process cal_output;

end Behavioral;
