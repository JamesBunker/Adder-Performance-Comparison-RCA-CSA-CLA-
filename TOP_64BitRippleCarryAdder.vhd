library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_64BitRippleCarryAdder is
Generic(n:integer:=64);
    Port (
       REG_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
       clk : in std_logic;
       LED : out  std_logic_vector(n-1 DOWNTO 0));
end TOP_64BitRippleCarryAdder;

architecture Behavioral of TOP_64BitRippleCarryAdder is

component nBitRippleCarryAdder is
Generic(n:integer);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
	       Cin : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end component nBitRippleCarryAdder;

component REG64_INA is
    Port ( SEL    : in STD_LOGIC_VECTOR(1 downto 0);
    clk : in std_logic;
           Z  : out std_logic_vector(n-1 DOWNTO 0)
           );
end component REG64_INA;

component REG64_INB is
    Port ( SEL    : in STD_LOGIC_VECTOR(1 downto 0);
    clk : in std_logic;
           Z  : out std_logic_vector(n-1 DOWNTO 0)
           );
end component REG64_INB;

component REG_OUT is
Generic(n:integer);
    Port ( REG_IN    : in std_logic_vector(n-1 DOWNTO 0);
    clk : in std_logic;
	   REG_OUTPUT   : out std_logic_vector(n-1 DOWNTO 0)
           );
end component REG_OUT;

signal A_temp,B_temp,S_temp : std_logic_vector(n-1 downto 0);
signal Cout_temp : std_logic;
signal Cin_temp : std_logic := '1';


begin
REG64_A: REG64_INA PORT MAP(
	SEL => REG_SEL,
	clk =>clk,
	Z => A_temp
	);
	
REG64_B: REG64_INB PORT MAP(
    SEL => REG_SEL,
    clk =>clk,
    Z => B_temp
    );

Bit64RippleCarryAdder: nBitRippleCarryAdder 
Generic map(n=>n)
PORT MAP( 
    A => A_temp,
    B => B_temp,
    Cin => Cin_temp,
    S => S_temp,
    Cout => Cout_temp);
    
REG64_OUT: REG_OUT 
generic map (n => n)
PORT MAP(
    REG_IN => S_temp,
    clk =>clk,
    REG_OUTPUT => LED
    );

end Behavioral;
