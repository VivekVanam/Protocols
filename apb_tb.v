module apb_tb;

  // Inputs
  reg        P_clk;
  reg        P_rst;
  reg [31:0] P_addr;
  reg        P_selx;
  reg        P_enable;
  reg        P_write;
  reg [31:0] P_wdata;

  // Outputs
  wire       P_ready;
  wire       P_slverr;
  wire [31:0] P_rdata;

  // DUT
  apb dut (
    P_clk, P_rst, P_addr,
    P_selx, P_enable, P_write,
    P_wdata, P_ready, P_slverr, P_rdata
  );

  // Clock
  always #5 P_clk = ~P_clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Initialization
    P_clk    = 0;
    P_rst    = 1;
    P_selx   = 0;
    P_enable = 0;
    P_write  = 0;
    P_addr   = 0;
    P_wdata  = 0;

    // Reset release
    #10 P_rst = 0;

    // =========================
    // WRITE 1
    // =========================
    @(posedge P_clk);
    P_selx   = 1;
    P_write  = 1;
    P_addr   = 0;
    P_wdata  = 11;
    P_enable = 0;   // SETUP

    @(posedge P_clk);
    P_enable = 1;   // ACCESS

    @(posedge P_clk);
    P_selx   = 0;
    P_enable = 0;

    // =========================
    // WRITE 2
    // =========================
    @(posedge P_clk);
    P_selx   = 1;
    P_write  = 1;
    P_addr   = 1;
    P_wdata  = 22;
    P_enable = 0;

    @(posedge P_clk);
    P_enable = 1;

    @(posedge P_clk);
    P_selx   = 0;
    P_enable = 0;

    // =========================
    // READ 1
    // =========================
    @(posedge P_clk);
    P_selx   = 1;
    P_write  = 0;
    P_addr   = 0;
    P_enable = 0;

    @(posedge P_clk);
    P_enable = 1;

    @(posedge P_clk);
    $display("READ Addr0 = %0d", P_rdata);
    P_selx   = 0;
    P_enable = 0;

    // =========================
    // READ 2
    // =========================
    @(posedge P_clk);
    P_selx   = 1;
    P_write  = 0;
    P_addr   = 1;
    P_enable = 0;

    @(posedge P_clk);
    P_enable = 1;

    @(posedge P_clk);
    $display("READ Addr1 = %0d", P_rdata);
    P_selx   = 0;
    P_enable = 0;

    #50 $finish;
  end

endmodule
