library verilog;
use verilog.vl_types.all;
entity projeto_CL_vlg_check_tst is
    port(
        OUT_East1       : in     vl_logic_vector(3 downto 0);
        OUT_East2       : in     vl_logic_vector(3 downto 0);
        OUT_North1      : in     vl_logic_vector(3 downto 0);
        OUT_North2      : in     vl_logic_vector(3 downto 0);
        OUT_South1      : in     vl_logic_vector(3 downto 0);
        OUT_South2      : in     vl_logic_vector(3 downto 0);
        OUT_West1       : in     vl_logic_vector(3 downto 0);
        OUT_West2       : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end projeto_CL_vlg_check_tst;
