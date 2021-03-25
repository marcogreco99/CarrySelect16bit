

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarry is
generic(
        N:integer);
    Port ( 
           A : in STD_LOGIC_VECTOR (N-1 downto 0);
           B : in STD_LOGIC_VECTOR (N-1 downto 0);
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 downto 0));
end RippleCarry;

architecture Behavioral of RippleCarry is

signal C : STD_LOGIC_VECTOR (N downto 0);

component FA is
    Port ( 
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           CIN : in STD_LOGIC;
           COUT : out STD_LOGIC;
           S : out STD_LOGIC);
end component;

begin

for_FA: for i in 0 to N-1 generate
            FAx : FA port map(A(i),B(i),C(i),C(i+1),S(i));
        end generate for_FA;
        
        C(0) <= CIN;
        COUT <= C(N);

end Behavioral;
