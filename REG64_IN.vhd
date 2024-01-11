library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REG64_INA is
    Port ( SEL    : in std_logic_vector(1 DOWNTO 0);
            clk : in std_logic;
           Z  : out std_logic_vector(63 DOWNTO 0)
           );
end REG64_INA;

architecture RTL of REG64_INA is
    TYPE MEMORY IS ARRAY (0 TO 2) OF std_logic_vector(63 DOWNTO 0);
    CONSTANT ROM_VAL : MEMORY := (
        x"FAFAFAFAFAFAFAFA",
        x"0000000000000001",
        x"2B502B502B502B50"
    );
begin
main : PROCESS (SEL,clk)
	BEGIN
	  if clk='1' and clk'event then
      Z <= ROM_VAL(to_integer(unsigned(SEL)));
    end if;
end process;

end RTL;
