library verilog;
use verilog.vl_types.all;
entity projeto_CL_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        IN_East         : in     vl_logic_vector(7 downto 0);
        IN_North        : in     vl_logic_vector(7 downto 0);
        IN_South        : in     vl_logic_vector(7 downto 0);
        IN_West         : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end projeto_CL_vlg_sample_tst;
