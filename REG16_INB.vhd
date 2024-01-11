library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG16_INB is
    Port ( SEL    : in std_logic_vector(1 downto 0);
    clk : in std_logic;
           Z  : out std_logic_vector(15 DOWNTO 0)
           );
end REG16_INB;

architecture RTL of REG16_INB is
    TYPE MEMORY IS ARRAY (0 TO 2) OF std_logic_vector(15 DOWNTO 0);
    CONSTANT ROM_VAL : MEMORY := (
        x"0011",
        x"11FF",
        x"2222"
    );
begin

main : PROCESS (SEL,clk)
	BEGIN
	  if clk='1' and clk'event then
      Z <= ROM_VAL(to_integer(unsigned(SEL)));
    end if;
		
END PROCESS main;

end RTL;
