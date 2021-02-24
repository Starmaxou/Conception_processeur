----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 11:57:56
-- Design Name: 
-- Module Name: Processing_Unit - Behavioral
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

entity Processing_Unit is
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

end Processing_Unit;

architecture Behavioral of Processing_Unit is
    component registre
        port ( in_data  : in std_logic_vector(7 downto 0);
               load_reg : in std_logic;
               ce       : in std_logic;
               clk      : in std_logic;
               reset    : in std_logic;
               out_data : out std_logic_vector(7 downto 0));
    end component;
    
    component bascule
        Port (  in_carry : in STD_LOGIC;
                load : in STD_LOGIC;
                clk : in STD_LOGIC;
                reset : in STD_LOGIC;
                ce : in STD_LOGIC;
                init_carry : in STD_LOGIC;
                out_carry : out STD_LOGIC);
    end component;
    
    component UAL
        port (  sel_UAL : in STD_LOGIC;
                in_dataA : in std_logic_vector(7 downto 0);
                in_dataB : in std_logic_vector(7 downto 0);
                out_carry : out STD_LOGIC;
                out_data : out std_logic_vector(7 downto 0));
    end component;
    
    signal reg_data_out : std_logic_vector(7 downto 0);
    signal reg_accu_out : std_logic_vector(7 downto 0);
    signal UAL_out : std_logic_vector(7 downto 0);
    signal UAL_carry : std_logic;
    
begin

    Registre_Data : registre
        port map ( in_data => read_mem,
               load_reg => C_load_reg_data,
               ce => CE,
               clk => H,
               reset => RST,
               out_data => reg_data_out
               );

    
    myUAL : UAL
        port map ( sel_UAL => A_sel_UAL,
                    in_dataA => reg_data_out,
                    in_dataB => reg_accu_out,
                    out_carry => UAL_carry,
                    out_data => UAL_out
                    );
    bascule_carry : bascule
        port map (
               in_carry => UAL_carry,
               load => D_load_carry,
               clk => H,
               reset => RST,
               ce => CE,
               init_carry => E_init_carry,
               out_carry => carry
        );
end Behavioral;
