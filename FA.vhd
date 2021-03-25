
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FA is
    Port ( 
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

component MUX is
    Port ( 
           Z : in STD_LOGIC;
           U : in STD_LOGIC;
           CIN : in STD_LOGIC;
           S : out STD_LOGIC);
end component;

signal XOUT: STD_LOGIC;


begin

XOUT <= A xor B;
S <= XOUT xor CIN;
MUX_FA : MUX port map(B,CIN,XOUT,COUT); --COUT <=((CIN and XOUT) or (not XOUT and B));

end Behavioral; 
