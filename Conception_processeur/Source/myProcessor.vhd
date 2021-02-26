----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 13:20:52
-- Design Name: 
-- Module Name: myProcessor - Behavioral
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

entity myProcessor is
     port ( CE : in std_logic;
            H : in std_logic;
            RST : in std_logic;
            mem_in : out std_logic_vector(7 downto 0);
            mem_out : out std_logic_vector(7 downto 0);
            adr : out std_logic_vector(5 downto 0)
            );
end myProcessor;


architecture Behavioral of myProcessor is

    component Processing_Unit
        Port (  CE : in std_logic;
                H : in std_logic;
                RST : in std_logic;     
                read_mem : in STD_LOGIC_VECTOR(7 downto 0);
                A_sel_UAL : in std_logic;
                B_load_reg_accu : in STD_LOGIC;
                C_load_reg_data : in STD_LOGIC;
                D_load_carry : in STD_LOGIC;
                E_init_carry : in STD_LOGIC;
                write_mem : out STD_LOGIC_VECTOR(7 downto 0);
                carry : out STD_LOGIC
                );
    end component;
    
    component Control_Unit
        Port (  CE : in std_logic;
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
    end component;
    
    component memoire
         Port ( en_men : in std_logic;
                R_W : in std_logic;
                ce : in std_logic;
                clk : in std_logic;
                in_adr : in std_logic_vector(5 downto 0);
                in_data: in std_logic_vector(7 downto 0);
                out_data : out std_logic_vector(7 downto 0)
                );
    end component;
    
    signal carry : std_logic;
    signal adr_mem : std_logic_vector(5 downto 0);
    signal read_mem : std_logic_vector(7 downto 0);
    signal write_mem: std_logic_vector(7 downto 0);
    signal A : std_logic;
    signal B : std_logic;
    signal C : std_logic;
    signal D : std_logic;
    signal E : std_logic;
    signal K : std_logic;
    signal L : std_logic;
    
begin

    UC : Control_Unit
        port map(  CE => CE,
                   H => H,
                   RST => RST,     
                   carry => carry,
                   read_mem =>read_mem,
                   A_sel_UAL => A,
                   B_load_reg_accu => B,
                   C_load_reg_data => C,
                   D_load_carry => D,
                   E_init_carry => E,
                   K_en_mem => K,
                   L_RW_mem => L,
                   adr_mem => adr_mem
               );
        
    UT : Processing_Unit
        Port map (
                CE => CE,
                H => H,
                RST => RST,     
                read_mem => read_mem,
                A_sel_UAL => A,
                B_load_reg_accu => B,
                C_load_reg_data => C,
                D_load_carry => D,
                E_init_carry => E,
                write_mem => write_mem,
                carry => carry 
                );
    
    Mem : memoire
        port map (
            en_men => K,
            R_W => L,
            ce => CE,
            clk => H,
            in_adr => adr_mem,
            in_data => write_mem,
            out_data => read_mem
        );
        
    mem_in <= write_mem;
    mem_out <= read_mem;
    adr <= adr_mem;

end Behavioral;
