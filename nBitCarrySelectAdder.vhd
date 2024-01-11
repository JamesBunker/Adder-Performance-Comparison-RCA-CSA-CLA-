library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity nBitCarrySelectAdder is
Generic(n:integer);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
		   Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end nBitCarrySelectAdder;

architecture Structural of nBitCarrySelectAdder is
    COMPONENT FullAdder
    PORT(
        A_FA : IN std_logic;
        B_FA : IN std_logic;
        Cin_FA : IN std_logic;          
        Sum_FA : OUT std_logic;
        Cout_FA : OUT std_logic
        );
    END COMPONENT;
	
	COMPONENT MUX
	PORT(
	A : in STD_LOGIC;
	B : in STD_LOGIC;
	Sel: in STD_LOGIC;
	Z: out STD_LOGIC
	);
	END COMPONENT;

    signal C : std_logic_vector(n/2 downto 0) := (others => '0');
    signal C0 : std_logic_vector(n/2 downto 0) := (others => '0');
	signal C1 : std_logic_vector(n/2 downto 0) := (others => '1');
	signal S0,S1 : std_logic_vector((n/2) downto 0);
	signal CoutFH : std_logic;

begin

C(0) <= Cin;

-- Generate Statement to instatiate full adders
FA_array: For i in 0 to (n/2)-1 generate
    FA_instant: FullAdder PORT MAP(
        A_FA => A(i),
        B_FA => B(i),
        Cin_FA => C(i),
        Sum_FA => S(i),
	-- Cout to Cin of the next FA
        Cout_FA => C(i+1) 
    );
end generate FA_array;
-- Final Cout/overflow 
CoutFH <= C(n/2);

-- Generate Statement to instatiate full adders with 0 as carry in
FA_array0: For i in 0 to (n/2)-1 generate
    FA_instant0: FullAdder PORT MAP(
        A_FA => A(i + n/2),
        B_FA => B(i + n/2),
        Cin_FA => C0(i),
        Sum_FA => S0(i),
		-- Cout to Cin of the next FA
        Cout_FA => C0(i+1) 
    );
end generate FA_array0;

-- Generate Statement to instatiate full adders with 1 as carry in
FA_array1: For i in 0 to (n/2)-1 generate
    FA_instant1: FullAdder PORT MAP(
        A_FA => A(i + n/2),
        B_FA => B(i + n/2),
        Cin_FA => C1(i),
        Sum_FA => S1(i),
		-- Cout to Cin of the next FA
        Cout_FA => C1(i+1) 
    );
end generate FA_array1;

-- Generate Statement to instatiate multiplexors
MUX_array: For i in 0 to (n/2)-1 generate
    MUX_instant: MUX PORT MAP(
        A => S0(i),
        B => S1(i),
        Sel => CoutFH,
        Z => S(i + n/2)
    );
end generate MUX_array;

MUX_Cout: MUX PORT MAP(
	A => C0(n/2),
	B => C1(n/2),
	Sel => CoutFH,
	Z => Cout
	);


end Structural;
