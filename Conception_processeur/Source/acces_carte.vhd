library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity acces_carte is
    port (
	 	  clk       : in std_logic;
	 	  reset     : in std_logic;
          AdrLSB    : in std_logic_vector(3 downto 0);
          AdrMSB    : in std_logic_vector(1 downto 0);
          DataLSB   : in std_logic_vector(3 downto 0);
          DataMSB   : in std_logic_vector(3 downto 0);
          DataInMem : in std_logic_vector(7 downto 0);
	 	  ce1s      : out std_logic;
	 	  ce25M     : out std_logic;
	 	  AN        : out std_logic_vector(7 downto 0);
	 	  Sseg      : out std_logic_vector(7 downto 0);
	 	  LED       : out std_logic_vector(7 downto 0);
		  LEDg      : out std_logic);

end acces_carte;

architecture acces_carte_a of acces_carte is

signal AdrMSB_4bits : std_logic_vector(3 downto 0);
signal ssegAdrLSB : std_logic_vector(6 downto 0);
signal ssegAdrMSB : std_logic_vector(6 downto 0);
signal ssegDataInMemLSB : std_logic_vector(6 downto 0);
signal ssegDataInMemMSB : std_logic_vector(6 downto 0);
signal ssegDataLSB : std_logic_vector(6 downto 0);
signal ssegDataMSB : std_logic_vector(6 downto 0);
signal commande_mux8_1 : std_logic_vector(2 downto 0);
signal ce195k : std_logic;

constant tiret: std_logic_vector(6 downto 0) := "0111111";


component Bin27s is
    Port ( BIN    : in std_logic_vector(3 downto 0);
           SevenS : out std_logic_vector(6 downto 0));
end component;

component mux8_1 is
    port ( E1       : in Std_Logic_Vector(6 downto 0);
           E2       : in Std_Logic_Vector(6 downto 0);
           E3       : in Std_Logic_Vector(6 downto 0);
           E4       : in Std_Logic_Vector(6 downto 0);
           E5       : in Std_Logic_Vector(6 downto 0);
           E6       : in Std_Logic_Vector(6 downto 0);
           E7       : in Std_Logic_Vector(6 downto 0);
           E8       : in Std_Logic_Vector(6 downto 0);
           COMMANDE : in Std_Logic_Vector(2 downto 0);
           S        : out Std_Logic_Vector(7 downto 0) 
         );
end component;
		
component modulo8
    port (clk       : in std_logic;
          raz       : in std_logic;
          ce        : in std_logic;
          sortie    : out std_logic_vector(2 downto 0);
          parallel  : out std_logic_vector(7 downto 0)
         );
end component;
		
component gen_ce is
    Port ( H    : in std_logic;
           raz  : in std_logic;
		   S_8  : out std_logic;
		   S_1  : out std_logic;
           S_25 : out std_logic);
end component;
		
		
begin  

AdrMSB_4bits <= "00"&AdrMSB;

i_Bin27s_AdrLSB       : Bin27s port map(AdrLSB,ssegAdrLSB);
i_Bin27s_AdrMSB       : Bin27s port map(AdrMSB_4bits,ssegAdrMSB);
i_Bin27s_DataInMemLSB : Bin27s port map(DataInMem(3 downto 0),ssegDataInMemLSB);
i_Bin27s_DataInMemMSB : Bin27s port map(DataInMem(7 downto 4),ssegDataInMemMSB);
i_Bin27s_DataLSB      : Bin27s port map(DataLSB,ssegDataLSB);
i_Bin27s_DataMSB      : Bin27s port map(DataMSB,ssegDataMSB);
--i_mux4_1 : mux4_1 port map(ssegDataMSB,ssegDataLSB,ssegAdrMSB,ssegAdrLSB,commande_mux4_1,Sseg);
--i_mux4_1 : mux4_1 port map(ssegDataMSB,ssegDataLSB,ssegDataInMemMSB,ssegDataInMemLSB,commande_mux4_1,Sseg);
i_mux8_1              : mux8_1 port map(tiret,ssegAdrMSB,ssegAdrLSB,tiret,ssegDataInMemMSB,ssegDataInMemLSB,ssegDataMSB,ssegDataLSB,commande_mux8_1,Sseg);
i_modulo8             : modulo8 port map(clk,reset,ce195k,commande_mux8_1,AN);
i_gen_ce              : gen_ce  port map(clk,reset,ce195k,ce25M,ce1s);

--LED <= not DataInMem(7) & not DataInMem(6) & not DataInMem(5) & not DataInMem(4) & not DataInMem(3) & not DataInMem(2) & not DataInMem(1) & not DataInMem(0);
--LED <= DataInMem;
--LED <= AdrMSB_4bits&AdrLSB;
LED <= DataMSB&DataLSB;
LEDg <= '1';
end acces_carte_a;

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bin27s is
    Port ( BIN    : in std_logic_vector(3 downto 0);
           SevenS : out std_logic_vector(6 downto 0));
end Bin27s;

architecture Behavioral of Bin27s is

-- Sseg:  (dp)(g f e d c b a)
begin
	with BIN select
		SevenS <= "1111001" when "0001", --1 	
		"0100100" when "0010", --2
		"0110000" when "0011", --3
		"0011001" when "0100", --4
		"0010010" when "0101", --5
		"0000010" when "0110", --6
		"1111000" when "0111", --7
		"0000000" when "1000", --8
		"0010000" when "1001", --9
		"0001000" when "1010", --A
		"0000011" when "1011", --b
		"1000110" when "1100", --C
		"0100001" when "1101", --d
		"0000110" when "1110", --E
		"0001110" when "1111", --F
		"1000000" when others; --0

end Behavioral;

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux8_1 is
    port ( E1       : in Std_Logic_Vector(6 downto 0);
           E2       : in Std_Logic_Vector(6 downto 0);
		   E3       : in Std_Logic_Vector(6 downto 0);
		   E4       : in Std_Logic_Vector(6 downto 0);
		   E5       : in Std_Logic_Vector(6 downto 0);
           E6       : in Std_Logic_Vector(6 downto 0);
           E7       : in Std_Logic_Vector(6 downto 0);
           E8       : in Std_Logic_Vector(6 downto 0);
           COMMANDE : in Std_Logic_Vector(2 downto 0);
		   S        : out Std_Logic_Vector(7 downto 0) );

end mux8_1;



architecture a_mux8_1 OF mux8_1 is
begin
process(E1,E2,E3,E4,E5,E6,E7,E8,COMMANDE)

        begin
				case COMMANDE is
						when "000"  => S<='1'&E1;
						when "001"  => S<='1'&E2;
						when "010"  => S<='1'&E3;
						when "011"  => S<='1'&E4;
                        when "100"  => S<='1'&E5;
                        when "101"  => S<='0'&E6;
                        when "110"  => S<='1'&E7;
						when others => S<='0'&E8;
				end case;

end process;
end a_mux8_1;

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity modulo8 is
    port (clk       : in std_logic;
	      raz       : in std_logic;
	 	  ce        : in std_logic;
          sortie    : out std_logic_vector(2 downto 0);
		  parallel  : out std_logic_vector(7 downto 0)
		  );
end modulo8;


architecture modulo8_a of modulo8 is

    signal cpt_val: std_logic_vector(2 downto 0);

begin  -- compteur_a

    mod8 : process (clk)
        
    begin  -- process cpt
            
        if clk'event and clk = '1' then 
		     
			  if raz = '1' then cpt_val <= "000";
			  
			  elsif ce ='1' then
              if cpt_val = "111" then
                cpt_val <= "000";
                                  else
               cpt_val <= cpt_val + 1;
              end if; 
				end if;  
           end if;        
    end process mod8;

    sortie <= cpt_val;

	 parallel_p : process (cpt_val)
	 begin 
	 			case cpt_val is
						when "000"  => parallel<="11111110";
						when "001"  => parallel<="11111101";
						when "010"  => parallel<="11111011";
						when "011"  => parallel<="11110111";
						when "100"  => parallel<="11101111";
						when "101"  => parallel<="11011111";
						when "110"  => parallel<="10111111";
						when others => parallel<="01111111";
				end case;

	 end process parallel_p;

end modulo8_a;

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity gen_ce is
    Port ( H    : in std_logic;
           raz  : in std_logic;
		   S_8  : out std_logic;
		   S_1  : out std_logic;
           S_25 : out std_logic);
end gen_ce;

architecture Behavioral of gen_ce is
signal compt : std_logic_vector (25 downto 0);
begin
   P1: process (H,raz)
		begin
		  if raz = '1' then 
		        compt <= (others => '0');
		  elsif H = '1' and H'event then
                compt <= compt + 1;
		  end if;
   end process;

   P2: process (compt)
		begin
		  if (compt(7 downto 0)="11111111") then S_8 <='1';
		                                    else S_8 <='0';
        end if;
	     if (compt(0)='1')                 then S_1 <='1';
		                                    else S_1 <='0';
        end if;
		  if (compt=((2**25)-1)) then S_25 <='1';
		                         else S_25 <='0';
        end if;
       end process;



end Behavioral;
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
