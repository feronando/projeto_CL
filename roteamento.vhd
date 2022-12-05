library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Roteamento
entity roteamento is
	port ( IN_Package1, IN_Package2 : in signed(3 downto 0);
			 clk : in std_logic;
			 arbiter : out std_logic_vector(3 downto 0)
	);
end roteamento;

architecture structural of roteamento is
	
	signal AUX : std_logic_vector(3 downto 0) := "0000";

begin
	routing : process (clk, AUX)
	begin
		if (clk'event and clk = '1') then
			AUX <= "0000";
			if (IN_Package1 /= 0) then
				if (IN_Package1 > 0) then
					AUX(3) <= '1';
				else
					AUX(2) <= '1';
				end if;
			elsif (IN_Package2 /= 0) then
				if (IN_Package2 > 0) then
					AUX(1) <= '1';
				else
					AUX(0) <= '1';
				end if;
			end if;
		end if;
	end process;
	
	arbiter <= AUX;
end structural;