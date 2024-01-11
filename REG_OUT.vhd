library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_OUT is
Generic(n:integer);
    Port ( REG_IN    : in std_logic_vector(n-1 DOWNTO 0);
    clk : in std_logic;
	   REG_OUTPUT    : out std_logic_vector(n-1 DOWNTO 0)
           );
end REG_OUT;

architecture RTL of REG_OUT is
signal reg : std_logic_vector(n-1 DOWNTO 0) :=( others=> '0');
begin
regFile : process (clk,REG_IN) is
begin
  reg <= REG_IN;
  if clk='1' and clk'event then
    REG_OUTPUT <= reg;
  end if;
end process;

end RTL;