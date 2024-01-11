library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity nBitCarryLookAheadAdder is
Generic(n:integer);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end nBitCarryLookAheadAdder;

architecture Structural of nBitCarryLookAheadAdder is
    COMPONENT PartialFullAdder
    Port ( A_PFA : in  STD_LOGIC;
           B_PFA : in  STD_LOGIC;
           P_PFA : out  STD_LOGIC;
		   G_PFA : out  STD_LOGIC);
    END COMPONENT;
	

    signal C : std_logic_vector(n downto 0) := (others => '0');
	signal P,G : std_logic_vector(n-1 downto 0);

begin


-- Generate Statement to instatiate partial full adders
PFA_array: For i in 0 to n-1 generate
    PFA_instant: PartialFullAdder PORT MAP(
        A_PFA => A(i),
        B_PFA => B(i),
		P_PFA => P(i),
		G_PFA => G(i)
    );
end generate PFA_array;

process(C,P,G,Cin)
	begin
	C(0) <= Cin;
	for i in 0 to n-1 loop
		C(i+1) <= G(i) or (P(i) and C(i));
	end loop;

end process;
S <= A xor B xor C(n-1 downto 0);
-- Final Cout/overflow 
Cout <= C(n);

end Structural;
