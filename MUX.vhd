library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( A	 : in  STD_LOGIC;
           B 	 : in  STD_LOGIC;
           SEL	 : in STD_LOGIC;
           Z 	 : out  STD_LOGIC);
end MUX;

architecture Behavioural of MUX is

begin
	process(A,B,SEL)
	begin
	if SEL = '0' then
		Z <= A;
	else
		Z <= B;
	end if;
	end process;
end Behavioural;