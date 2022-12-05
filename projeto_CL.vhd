library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Projeto final de Circuitos Lógicos
entity projeto_CL is
	port ( IN_East, IN_West, IN_South, IN_North : in std_logic_vector(7 downto 0);
			 clk, clr : in std_logic;
			 OUT_East, OUT_West, OUT_South, OUT_North : out std_logic_vector(7 downto 0)
	);
end projeto_CL;

architecture structural of projeto_CL is
	component buffer_regs
		port ( IN_Package : in std_logic_vector(7 downto 0);
				 clk, clr : in std_logic;
			    arb : in std_logic;
			    OUT_Package : out std_logic_vector(7 downto 0)
		);
	end component;
	
	for all : buffer_regs use entity work.buffer_regs(structural);
	-- 
	component roteamento
		port ( IN_Package1, IN_Package2 : in signed(3 downto 0);
				 clk : in std_logic;
				 arbiter : out std_logic_vector(3 downto 0)
		);
	end component;
	
	for all : roteamento use entity work.roteamento(structural);
	-- 
	component arbiter
		port ( IN_Package_East1, IN_Package_East2 : in signed(3 downto 0);
				 IN_Package_West1, IN_Package_West2 : in signed(3 downto 0);
				 IN_Package_South1, IN_Package_South2 : in signed(3 downto 0);
				 IN_Package_North1, IN_Package_North2 : in signed(3 downto 0);
				 Router : in std_logic_vector(3 downto 0);
				 clk, clr : in std_logic;
				 OUT_Arbiter : out std_logic_vector(3 downto 0);
				 OUT_Package1, OUT_Package2 : out signed(3 downto 0)
		);
	end component;
	
	for all : arbiter use entity work.arbiter(structural);
	-- Sinal do Árbitro
	signal AUX_BUFFE, AUX_BUFFW, AUX_BUFFS, AUX_BUFFN : std_logic := '0';
	
	-- Roteamento
	signal AUX_ROUTERE, AUX_ROUTERW, AUX_ROUTERS, AUX_ROUTERN : std_logic_vector(3 downto 0);
	
	signal AUX_ROUTERE2, AUX_ROUTERW2, AUX_ROUTERS2, AUX_ROUTERN2 : std_logic_vector(3 downto 0);
	
	-- Árbitro
	signal AUX_ARBE, AUX_ARBW, AUX_ARBS, AUX_ARBN : std_logic_vector(3 downto 0);
	
	-- IN_Packages
	signal AUX_PACKAGEE, AUX_PACKAGEW, AUX_PACKAGES, AUX_PACKAGEN : std_logic_vector(7 downto 0);
	
	signal AUX_PACKAGEE1, AUX_PACKAGEE2 : signed(3 downto 0);
	
	signal AUX_PACKAGEW1, AUX_PACKAGEW2 : signed(3 downto 0);
	
	signal AUX_PACKAGES1, AUX_PACKAGES2 : signed(3 downto 0);
	
	signal AUX_PACKAGEN1, AUX_PACKAGEN2 : signed(3 downto 0);
	
	-- OUT_Packages
	signal AUX_OUT_PACKAGEE1, AUX_OUT_PACKAGEE2 : signed(3 downto 0);
	
	signal AUX_OUT_PACKAGEW1, AUX_OUT_PACKAGEW2 : signed(3 downto 0);
	
	signal AUX_OUT_PACKAGES1, AUX_OUT_PACKAGES2 : signed(3 downto 0);
	
	signal AUX_OUT_PACKAGEN1, AUX_OUT_PACKAGEN2 : signed(3 downto 0);
	
begin
	BE : buffer_regs port map (IN_East, clk, clr, AUX_BUFFE, AUX_PACKAGEE);
	BW : buffer_regs port map (IN_West, clk, clr, AUX_BUFFW, AUX_PACKAGEW);
	BS : buffer_regs port map (IN_South, clk, clr, AUX_BUFFS, AUX_PACKAGES);
	BN : buffer_regs port map (IN_North, clk, clr, AUX_BUFFN, AUX_PACKAGEN);
	
	AUX_PACKAGEE1 <= signed(AUX_PACKAGEE(3 downto 0));
	AUX_PACKAGEE2 <= signed(AUX_PACKAGEE(7 downto 4));
	
	AUX_PACKAGEW1 <= signed(AUX_PACKAGEW(3 downto 0));
	AUX_PACKAGEW2 <= signed(AUX_PACKAGEW(7 downto 4));
	
	AUX_PACKAGES1 <= signed(AUX_PACKAGES(3 downto 0));
	AUX_PACKAGES2 <= signed(AUX_PACKAGES(7 downto 4));
	
	AUX_PACKAGEN1 <= signed(AUX_PACKAGEN(3 downto 0));
	AUX_PACKAGEN2 <= signed(AUX_PACKAGEN(7 downto 4));
	
	RE : roteamento port map (AUX_PACKAGEE1, AUX_PACKAGEE2, clk, AUX_ROUTERE);
	RW : roteamento port map (AUX_PACKAGEW1, AUX_PACKAGEW2, clk, AUX_ROUTERW);
	RS : roteamento port map (AUX_PACKAGES1, AUX_PACKAGES2, clk, AUX_ROUTERS);
	RN : roteamento port map (AUX_PACKAGEN1, AUX_PACKAGEN2, clk, AUX_ROUTERN);
	
	AUX_ROUTERE2(3) <= AUX_ROUTERE(3);
	AUX_ROUTERE2(2) <= AUX_ROUTERW(3);
	AUX_ROUTERE2(1) <= AUX_ROUTERS(3);
	AUX_ROUTERE2(0) <= AUX_ROUTERN(3);
	
	AUX_ROUTERW2(3) <= AUX_ROUTERE(2);
	AUX_ROUTERW2(2) <= AUX_ROUTERW(2);
	AUX_ROUTERW2(1) <= AUX_ROUTERS(2);
	AUX_ROUTERW2(0) <= AUX_ROUTERN(2);
	
	AUX_ROUTERS2(3) <= AUX_ROUTERE(1);
	AUX_ROUTERS2(2) <= AUX_ROUTERW(1);
	AUX_ROUTERS2(1) <= AUX_ROUTERS(1);
	AUX_ROUTERS2(0) <= AUX_ROUTERN(1);
	
	AUX_ROUTERN2(3) <= AUX_ROUTERE(0);
	AUX_ROUTERN2(2) <= AUX_ROUTERW(0);
	AUX_ROUTERN2(1) <= AUX_ROUTERS(0);
	AUX_ROUTERN2(0) <= AUX_ROUTERN(0);
	
	AE : arbiter port map (AUX_PACKAGEE1, AUX_PACKAGEE2, AUX_PACKAGEW1, AUX_PACKAGEW2, AUX_PACKAGES1, AUX_PACKAGES2, AUX_PACKAGEN1, AUX_PACKAGEN2, AUX_ROUTERE2, clk, clr, AUX_ARBE, AUX_OUT_PACKAGEE1, AUX_OUT_PACKAGEE2);
	AW : arbiter port map (AUX_PACKAGEE1, AUX_PACKAGEE2, AUX_PACKAGEW1, AUX_PACKAGEW2, AUX_PACKAGES1, AUX_PACKAGES2, AUX_PACKAGEN1, AUX_PACKAGEN2, AUX_ROUTERW2, clk, clr, AUX_ARBW, AUX_OUT_PACKAGEW1, AUX_OUT_PACKAGEW2);
	AS : arbiter port map (AUX_PACKAGEE1, AUX_PACKAGEE2, AUX_PACKAGEW1, AUX_PACKAGEW2, AUX_PACKAGES1, AUX_PACKAGES2, AUX_PACKAGEN1, AUX_PACKAGEN2, AUX_ROUTERS2, clk, clr, AUX_ARBS, AUX_OUT_PACKAGES1, AUX_OUT_PACKAGES2);
	AN : arbiter port map (AUX_PACKAGEE1, AUX_PACKAGEE2, AUX_PACKAGEW1, AUX_PACKAGEW2, AUX_PACKAGES1, AUX_PACKAGES2, AUX_PACKAGEN1, AUX_PACKAGEN2, AUX_ROUTERN2, clk, clr, AUX_ARBN, AUX_OUT_PACKAGEN1, AUX_OUT_PACKAGEN2);
	
	OUT_East(3 downto 0) <= std_logic_vector(AUX_PACKAGEE1);
	OUT_East(7 downto 4) <= std_logic_vector(AUX_PACKAGEE2);
	
	OUT_West(3 downto 0) <= std_logic_vector(AUX_PACKAGEW1);
	OUT_West(7 downto 4) <= std_logic_vector(AUX_PACKAGEW2);
	
	OUT_South(3 downto 0) <= std_logic_vector(AUX_PACKAGES1);
	OUT_South(7 downto 4) <= std_logic_vector(AUX_PACKAGES2);
	
	OUT_North(3 downto 0) <= std_logic_vector(AUX_PACKAGEN1);
	OUT_North(7 downto 4) <= std_logic_vector(AUX_PACKAGEN2);
	
	AUX_BUFFE <= AUX_BUFFE or AUX_ARBE(3) or AUX_ARBW(3) or AUX_ARBS(3) or AUX_ARBN(3);
	AUX_BUFFW <= AUX_BUFFW or AUX_ARBE(2) or AUX_ARBW(2) or AUX_ARBS(2) or AUX_ARBN(2);
	AUX_BUFFS <= AUX_BUFFS or AUX_ARBE(1) or AUX_ARBW(1) or AUX_ARBS(1) or AUX_ARBN(1);
	AUX_BUFFN <= AUX_BUFFN or AUX_ARBE(0) or AUX_ARBW(0) or AUX_ARBS(0) or AUX_ARBN(0);
	
end structural;