--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:50:21 02/15/2011
-- Design Name:   
-- Module Name:   E:/Enseignement/Enseignement_ENSEIRB/Filiere-SEE/Semestre_S7/EN217/BE/MCPU/test_CPU_8bits.vhd
-- Project Name:  MCPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_8bits
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_CPU_8bits IS
END test_CPU_8bits;
 
ARCHITECTURE behavior OF test_CPU_8bits IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_8bits
    PORT(
           reset      : in  STD_LOGIC;
           clk100M 	  : in  STD_LOGIC;
           AN         : out std_logic_vector(7 downto 0);
           Sevenseg   : out  STD_LOGIC_VECTOR (7 downto 0);
           LED 		  : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset      : std_logic := '0';
   signal clk100M    : std_logic := '0';
   signal clk_switch : std_logic := '1';

 	--Outputs
   signal AN       : std_logic_vector(7 downto 0);
   signal Sevenseg : std_logic_vector(7 downto 0);
   signal LED      : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk100M_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_8bits PORT MAP (
          reset => reset,
          clk100M => clk100M,
		  AN => AN,
          Sevenseg => Sevenseg,
          LED => LED
        );

   -- Clock process definitions
   clk100M_process :process
   begin
		clk100M <= '0';
		wait for clk100M_period/2;
		clk100M <= '1';
		wait for clk100M_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '0';
      wait for 1000 ns;	
      reset <= '1';
      wait for clk100M_period*10000;
      reset <= '1';
      wait for 100 ns;	
      reset <= '1';
      wait for clk100M_period*1000;
      -- insert stimulus here 

      wait;
   end process;

END;