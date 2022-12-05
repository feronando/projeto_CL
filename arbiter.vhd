library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Árbitro
entity arbiter is
	port ( IN_Package_East1, IN_Package_East2 : in signed(3 downto 0);
			 IN_Package_West1, IN_Package_West2 : in signed(3 downto 0);
			 IN_Package_South1, IN_Package_South2 : in signed(3 downto 0);
			 IN_Package_North1, IN_Package_North2 : in signed(3 downto 0);
			 Router : in std_logic_vector(3 downto 0);
			 clk, clr : in std_logic;
			 OUT_Arbiter : out std_logic_vector(3 downto 0);
			 OUT_Package1, OUT_Package2 : out signed(3 downto 0)
	);
end arbiter;

architecture structural of arbiter is
	
	signal AUX : std_logic_vector(3 downto 0) := "0000";
	
	type state_type is (stateEast, stateWest, stateSouth, stateNorth);
	signal state : state_type;

begin 
	arb : process(clk)
		variable buff_router : std_logic_vector(3 downto 0);
	begin
		if (clr = '1') then
			buff_router := "0000";
			AUX <= "0000";
			OUT_Package1 <= "0000";
			OUT_Package2 <= "0000";
			state <= stateEast;
		elsif (clk'event and clk = '1') then
			buff_router := Router;
			AUX <= "0000";
			OUT_Package1 <= "0000";
			OUT_Package2 <= "0000";
			case state is
				when stateEast =>
					if buff_router(3) = '1' then
						OUT_Package1 <= IN_Package_East1 - 1;
						OUT_Package2 <= IN_Package_East2;
						AUX(3) <= '1';
						buff_router(3) := '0';
					end if;
					state <= stateWest;
				when stateWest =>
					if buff_router(2) = '1' then
						OUT_Package1 <= IN_Package_West1 + 1;
						OUT_Package2 <= IN_Package_West2;
						AUX(2) <= '1';
						buff_router(2) := '0';
					end if;
					state <= stateSouth;
				when stateSouth =>
					if buff_router(1) = '1' then
						OUT_Package1 <= IN_Package_South1;
						OUT_Package2 <= IN_Package_South2 - 1;
						AUX(1) <= '1';
						buff_router(1) := '0';
					end if;
					state <= stateNorth;
				when stateNorth =>
					if buff_router(0) = '1' then
						OUT_Package1 <= IN_Package_North1;
						OUT_Package2 <= IN_Package_North2 + 1;
						AUX(0) <= '1';
						buff_router(0) := '0';
					end if;
					state <= stateEast;
				end case;
		end if;
	end process;
	
	OUT_Arbiter <= AUX;
	
end structural;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--
---- Árbitro
--entity arbiter is
--	port ( -- Package_East, Package_West, Package_South, Package_North : in std_logic_vector(7 downto 0);
--			 IN_Package : in std_logic_vector(7 downto 0);
--			 Router : in std_logic_vector(0 to 3);
--			 clk, clr : in std_logic;
--			 OUT_Arbiter : out std_logic_vector(0 to 3);
--			 OUT_Package : out std_logic_vector(7 downto 0)
--	);
--end arbiter;
--
--architecture structural of arbiter is
--
--	--type state_type is (stateNorth, stateSouth, stateEast, stateWest);
--	--signal state : state_type;
--	--shared variable buffNorth, buffSouth, buffEast, buffWest : std_logic;
--	
--	signal buff_router : std_logic_vector(0 to 3) := "0000";
--	
--	signal X : signed(3 downto 0) := signed(IN_Package(7 downto 4));
--	signal Y : signed(3 downto 0) := signed(IN_Package(3 downto 0));
--	
--	signal AUX : std_logic_vector(0 to 3) := "0000";
--	
--begin 
--	arbiter : process(clk, clr, buff_router, AUX, X, Y)
--		variable ptr : natural range 0 to 3 := 0;
--	begin
--		if (clr = '1') then
--			X <= "0000";
--			Y <= "0000";
--			buff_router <= "0000";
--			AUX <= "0000";
--			ptr := 0;
--		elsif (clk'event and clk = '1') then
--		
--			buff_router <= Router;
--		
--			if (buff_router(ptr) = '1') then
--				buff_router(ptr) <= '0';
--				AUX <= "0000";
--				case ptr is
--					when 0 =>
--						X <= X - 1;
--						AUX(0) <= '1';
--					when 1 =>
--						X <= X + 1;
--						AUX(1) <= '1';
--					when 2 =>
--						Y <= Y - 1;
--						AUX(2) <= '1';
--					when 3 =>
--						Y <= Y + 1;
--						AUX(3) <= '1';
--				end case;
--			end if;
--			
--			ptr := (ptr + 1) rem 4;
--			
--		end if;
--	end process;
--	
--	OUT_Package(7 downto 4) <= std_logic_vector(X);
--	OUT_Package(3 downto 0) <= std_logic_vector(Y);
--	OUT_Arbiter <= AUX;
--	
--end structural;