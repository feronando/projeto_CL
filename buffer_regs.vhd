
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Buffer
entity buffer_regs is
	port ( IN_Package : in std_logic_vector(7 downto 0);
			 clk, clr : in std_logic;
			 arb : in std_logic;
			 OUT_Package : out std_logic_vector(7 downto 0)
	);
end buffer_regs;

architecture structural of buffer_regs is

	type fifo is array(0 to 3) of std_logic_vector(7 downto 0);
	signal stack : fifo;
	
	signal ena : std_logic := '1';
	
begin
	
	buff : process (clk, clr, stack, ena, arb)
		variable ptr : natural := 0;
	begin
		if (clr = '1') then
			for i in 0 to 3 loop
            stack(i) <= "00000000";
			end loop;
			ptr := 0;
		elsif (clk'event and clk = '1') then
			if (arb = '1') then
				for j in 0 to 3 loop
					if (j >= ptr) or (j = 3) then
						stack(j) <= "00000000";
					else
						stack(j) <= stack(j+1);
					end if;
				end loop;
				ptr := ptr - 1;
				if (ena = '0') then
					ena <= '1';
				end if;
			end if;
			
			if (ena = '1') and (stack(ptr-1) /= IN_Package)  then
				if (ptr < 4) then
					stack(ptr) <= IN_Package;
					ptr := ptr + 1;
				else
					ena <= '0';
				end if;
			end if;
		end if;
	end process;
	
	OUT_Package <= stack(0);
	
end structural;