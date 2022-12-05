library verilog;
use verilog.vl_types.all;
entity projeto_CL is
    port(
        IN_East         : in     vl_logic_vector(7 downto 0);
        IN_West         : in     vl_logic_vector(7 downto 0);
        IN_South        : in     vl_logic_vector(7 downto 0);
        IN_North        : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        OUT_East1       : out    vl_logic_vector(3 downto 0);
        OUT_East2       : out    vl_logic_vector(3 downto 0);
        OUT_West1       : out    vl_logic_vector(3 downto 0);
        OUT_West2       : out    vl_logic_vector(3 downto 0);
        OUT_South1      : out    vl_logic_vector(3 downto 0);
        OUT_South2      : out    vl_logic_vector(3 downto 0);
        OUT_North1      : out    vl_logic_vector(3 downto 0);
        OUT_North2      : out    vl_logic_vector(3 downto 0)
    );
end projeto_CL;
