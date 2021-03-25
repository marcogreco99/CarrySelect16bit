
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BLOCCO_RC is
    generic(
           NB:integer ); 
    Port ( 
           A : in STD_LOGIC_VECTOR (NB-1 downto 0);
           B : in STD_LOGIC_VECTOR (NB-1 downto 0);
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (NB-1 downto 0));
end BLOCCO_RC;

architecture Behavioral of BLOCCO_RC is

signal S_U , S_Z : STD_LOGIC_VECTOR(NB-1 downto 0); --rispettivamente l'uscita S del primo e del secondo rc 
signal C_U , C_Z : STD_LOGIC; --rispettivamente il carry out del primo e secondo rc

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

component MUX is
    Port ( 
           Z : in STD_LOGIC;
           U : in STD_LOGIC;
           CIN : in STD_LOGIC;
           S : out STD_LOGIC);
end component;

begin

RC_U : RippleCarry generic map( N => NB)
                    port map(A,B,'1',C_U,S_U);
RC_Z : RippleCarry generic map( N => NB)
                    port map(A,B,'0',C_Z,S_Z);

-- adesso gestisco quale dei due rirrple carry devo utilizzare. In pratica la gestione dei multiplexer che 

for_mux : for i in 0 to NB-1 generate
            Mx: MUX port map(S_Z(i),S_U(i),CIN,S(i));         
end generate for_mux;

-- Gestione MUX del riporto in uscita

M:MUX port map(C_Z,C_U,CIN,COUT);

end Behavioral;
