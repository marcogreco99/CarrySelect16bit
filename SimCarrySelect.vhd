

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity SimCarrySelect is
--  Port ( );
end SimCarrySelect;

architecture Behavioral of SimCarrySelect is
-- dichiararo il componente che voglio simulare:

signal IA,IB : STD_LOGIC_VECTOR (15 downto 0);
signal OSum : STD_LOGIC_VECTOR (16 downto 0);

component CarrySelect is

    Port (
           A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           C_IN: in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (16 downto 0)); --un bit è dedicato all'estensione del segno
           
end component;

begin

-- mi comporto come se sono in una gerarchia

    circuito: CarrySelect port map(IA,IB,'0',OSum);
 process
       begin
       --t=0
       
       for va in 32754 to 32769 loop
            IA <= conv_std_logic_vector(va,16);
            for vb in 32754 to 32769 loop
                IB <= conv_std_logic_vector(vb,16);
       wait for 10 ns;
            end loop;
       end loop;
 end process;
 

end Behavioral;

