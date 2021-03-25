
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( 
           Z : in STD_LOGIC;
           U : in STD_LOGIC;
           CIN : in STD_LOGIC;
           S : out STD_LOGIC);
end MUX;

architecture Behavioral of MUX is

begin

S <= ((U and CIN) or (Z and (not CIN)));

end Behavioral;
