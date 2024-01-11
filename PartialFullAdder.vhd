library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PartialFullAdder is
    Port ( A_PFA : in  STD_LOGIC;
           B_PFA : in  STD_LOGIC;
           P_PFA : out  STD_LOGIC;
		   G_PFA : out  STD_LOGIC);
end PartialFullAdder;

architecture Behavioral of PartialFullAdder is
begin
	P_PFA <= A_PFA xor B_PFA;
	G_PFA <= A_PFA and B_PFA;
end Behavioral;