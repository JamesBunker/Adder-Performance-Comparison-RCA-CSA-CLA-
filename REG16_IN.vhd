library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG16_INA is
    Port ( SEL    : in std_logic_vector(1 downto 0);
    clk : in std_logic;
           Z  : out std_logic_vector(15 DOWNTO 0)
           );
end REG16_INA;

architecture RTL of REG16_INA is
    TYPE MEMORY IS ARRAY (0 TO 2) OF std_logic_vector(15 DOWNTO 0);
    CONSTANT ROM_VAL : MEMORY := (
        x"FAFA",
        x"FFFF",
        x"2B50"
    );
begin
main : PROCESS (SEL,clk)
	BEGIN
	  if clk='1' and clk'event then
      Z <= ROM_VAL(to_integer(unsigned(SEL)));
    end if;
		
END PROCESS main;

end RTL;
