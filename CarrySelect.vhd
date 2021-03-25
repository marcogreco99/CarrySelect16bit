----------------------------------------------------------------------------------
-- Company: Università della calabria
-- Engineer: Marco Greco 200901
-- 
-- Create Date: 07.11.2020 13:21:49
-- Project Name: Carry Select Adder 16 bit
-- Description: 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarrySelect is

    Port (
           A,B : in STD_LOGIC_VECTOR (15 downto 0); 
           C_IN: in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (16 downto 0)); 
           
end CarrySelect;

architecture Behavioral of CarrySelect is

signal C_BLOCCHI : STD_LOGIC_VECTOR(5 downto 0); --il quinto è dell'estensione del segno che sarà inutile


-- blocco rc singolo [0-1]

component RippleCarry is
generic(
        N:integer);
    Port ( 
           A : in STD_LOGIC_VECTOR (N-1 downto 0);
           B : in STD_LOGIC_VECTOR (N-1 downto 0);
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;



component BLOCCO_RC is
    generic(
           NB:integer ); 
    Port ( 
           A : in STD_LOGIC_VECTOR (NB-1 downto 0);
           B : in STD_LOGIC_VECTOR (NB-1 downto 0);
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (NB-1 downto 0));
end component;


begin
--creo inizialmente il blocco iniziale con un solo ripplecarry:
 
BLOCCO_INIZIALE : RippleCarry generic map(2)
                              port map(A(1 downto 0),B(1 downto 0),C_IN,C_BLOCCHI(0),S(1 downto 0));

-- creo i restanti blocchi con i relativi ripplecarry (RC_Z,RC_U) in parallelo

for_blocchi: for i in 0 to 3 generate

            BLOCCOx: BLOCCO_RC generic map(i+2)
            -- per gli indici MSB posso sfruttare la formula di gauss che ci consente di ricavare la sequenza 1,3,6,10,15... (a noi ci interessa da 3 in su quindi: n=i+2) 
                               port map(
                                        A => A(((i+2)*(i+2+1))/2 downto (((i+2)*(i+2+1))/2)-(1+i) ),
                                        B => B(((i+2)*(i+2+1))/2 downto (((i+2)*(i+2+1))/2)-(1+i)),
                                        CIN => C_BLOCCHI(i),
                                        COUT => C_BLOCCHI(i+1),
                                        S => S(((i+2)*(i+2+1))/2 downto (((i+2)*(i+2+1))/2)-(1+i))
                                        ); 
end generate for_blocchi;

--gestione estensione del segno

B_ESTENSIONE_SEGNO : BLOCCO_RC generic map(1)
                 port map(A(15 downto 15),B(15 downto 15),C_BLOCCHI(4),C_BLOCCHI(5),S(16 downto 16));


end Behavioral;
