-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\axis_packet_generator\AxisPacketGenerator.vhd
-- Created: 2021-02-09 12:52:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: -1
-- Target subsystem base rate: -1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: AxisPacketGenerator
-- Source Path: AxisPacketGenerator
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AxisPacketGenerator IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        AXI4_Stream_Real_Master_TREADY    :   IN    std_logic;  -- ufix1
        AXI4_Stream_Real_Slave_TDATA      :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_Real_Slave_TVALID     :   IN    std_logic;  -- ufix1
        AXI4_Stream_Imag_Master_TREADY    :   IN    std_logic;  -- ufix1
        AXI4_Stream_Imag_Slave_TDATA      :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_Imag_Slave_TVALID     :   IN    std_logic;  -- ufix1
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Stream_Real_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_Real_Master_TVALID    :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Real_Master_TLAST     :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Real_Slave_TREADY     :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Imag_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_Imag_Master_TVALID    :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Imag_Master_TLAST     :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Imag_Slave_TREADY     :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END AxisPacketGenerator;


ARCHITECTURE rtl OF AxisPacketGenerator IS

  -- Component Declarations
  COMPONENT AxisPacketGenerator_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          write_packet_size               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_transfer                  :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_axi4_stream_imag_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Imag_Master_TREADY  :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          user_TLAST                      :   IN    std_logic;  -- ufix1
          AXI4_Stream_Imag_Master_TDATA   :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_Imag_Master_TVALID  :   OUT   std_logic;  -- ufix1
          AXI4_Stream_Imag_Master_TLAST   :   OUT   std_logic;  -- ufix1
          user_ready                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_axi4_stream_imag_slave
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Imag_Slave_TDATA    :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_Imag_Slave_TVALID   :   IN    std_logic;  -- ufix1
          user_ready                      :   IN    std_logic;  -- ufix1
          AXI4_Stream_Imag_Slave_TREADY   :   OUT   std_logic;  -- ufix1
          user_data                       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_axi4_stream_real_slave
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Real_Slave_TDATA    :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_Real_Slave_TVALID   :   IN    std_logic;  -- ufix1
          user_ready                      :   IN    std_logic;  -- ufix1
          AXI4_Stream_Real_Slave_TREADY   :   OUT   std_logic;  -- ufix1
          user_data                       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          packet_size                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          transfer                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_re_tdata                 :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          s_axis_re_tvalid                :   IN    std_logic;  -- ufix1
          s_axis_im_tdata                 :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          s_axis_im_tvalid                :   IN    std_logic;  -- ufix1
          m_axis_re_tready                :   IN    std_logic;  -- ufix1
          m_axis_im_tready                :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          m_axis_re_tdata                 :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          m_axis_re_tvalid                :   OUT   std_logic;  -- ufix1
          m_axis_re_tlast                 :   OUT   std_logic;  -- ufix1
          m_axis_im_tdata                 :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          m_axis_im_tvalid                :   OUT   std_logic;  -- ufix1
          m_axis_im_tlast                 :   OUT   std_logic;  -- ufix1
          s_axis_re_tready                :   OUT   std_logic;  -- ufix1
          s_axis_im_tready                :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT AxisPacketGenerator_axi4_stream_real_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Real_Master_TREADY  :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          user_TLAST                      :   IN    std_logic;  -- ufix1
          AXI4_Stream_Real_Master_TDATA   :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_Real_Master_TVALID  :   OUT   std_logic;  -- ufix1
          AXI4_Stream_Real_Master_TLAST   :   OUT   std_logic;  -- ufix1
          user_ready                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : AxisPacketGenerator_reset_sync
    USE ENTITY work.AxisPacketGenerator_reset_sync(rtl);

  FOR ALL : AxisPacketGenerator_axi_lite
    USE ENTITY work.AxisPacketGenerator_axi_lite(rtl);

  FOR ALL : AxisPacketGenerator_axi4_stream_imag_master
    USE ENTITY work.AxisPacketGenerator_axi4_stream_imag_master(rtl);

  FOR ALL : AxisPacketGenerator_axi4_stream_imag_slave
    USE ENTITY work.AxisPacketGenerator_axi4_stream_imag_slave(rtl);

  FOR ALL : AxisPacketGenerator_axi4_stream_real_slave
    USE ENTITY work.AxisPacketGenerator_axi4_stream_real_slave(rtl);

  FOR ALL : AxisPacketGenerator_dut
    USE ENTITY work.AxisPacketGenerator_dut(rtl);

  FOR ALL : AxisPacketGenerator_axi4_stream_real_master
    USE ENTITY work.AxisPacketGenerator_axi4_stream_real_master(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL reset_before_sync                : std_logic;  -- ufix1
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL write_packet_size                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_transfer                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL const_1_1                        : std_logic;  -- ufix1
  SIGNAL m_axis_re_tlast_sig              : std_logic;  -- ufix1
  SIGNAL top_user_TLAST                   : std_logic;  -- ufix1
  SIGNAL m_axis_re_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL top_user_valid                   : std_logic;  -- ufix1
  SIGNAL m_axis_im_tlast_sig              : std_logic;  -- ufix1
  SIGNAL top_user_TLAST_1                 : std_logic;  -- ufix1
  SIGNAL m_axis_im_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL top_user_valid_1                 : std_logic;  -- ufix1
  SIGNAL m_axis_im_tdata_sig              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL AXI4_Stream_Imag_Master_TDATA_tmp : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL top_user_ready                   : std_logic;  -- ufix1
  SIGNAL m_axis_im_tready_sig             : std_logic;  -- ufix1
  SIGNAL top_user_ready_1                 : std_logic;  -- ufix1
  SIGNAL m_axis_re_tready_sig             : std_logic;  -- ufix1
  SIGNAL top_user_valid_2                 : std_logic;  -- ufix1
  SIGNAL s_axis_im_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL s_axis_im_tready_sig             : std_logic;  -- ufix1
  SIGNAL top_user_ready_2                 : std_logic;  -- ufix1
  SIGNAL top_user_data                    : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL top_user_valid_3                 : std_logic;  -- ufix1
  SIGNAL s_axis_re_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL s_axis_re_tready_sig             : std_logic;  -- ufix1
  SIGNAL top_user_ready_3                 : std_logic;  -- ufix1
  SIGNAL top_user_data_1                  : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m_axis_re_tdata_sig              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL AXI4_Stream_Real_Master_TDATA_tmp : std_logic_vector(127 DOWNTO 0);  -- ufix128

BEGIN
  u_AxisPacketGenerator_reset_sync_inst : AxisPacketGenerator_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_AxisPacketGenerator_axi_lite_inst : AxisPacketGenerator_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              write_packet_size => write_packet_size,  -- ufix32
              write_transfer => write_transfer,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_AxisPacketGenerator_axi4_stream_imag_master_inst : AxisPacketGenerator_axi4_stream_imag_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Imag_Master_TREADY => AXI4_Stream_Imag_Master_TREADY,  -- ufix1
              user_data => m_axis_im_tdata_sig,  -- ufix128
              user_valid => top_user_valid_1,  -- ufix1
              user_TLAST => top_user_TLAST_1,  -- ufix1
              AXI4_Stream_Imag_Master_TDATA => AXI4_Stream_Imag_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_Imag_Master_TVALID => AXI4_Stream_Imag_Master_TVALID,  -- ufix1
              AXI4_Stream_Imag_Master_TLAST => AXI4_Stream_Imag_Master_TLAST,  -- ufix1
              user_ready => top_user_ready  -- ufix1
              );

  u_AxisPacketGenerator_axi4_stream_imag_slave_inst : AxisPacketGenerator_axi4_stream_imag_slave
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Imag_Slave_TDATA => AXI4_Stream_Imag_Slave_TDATA,  -- ufix128
              AXI4_Stream_Imag_Slave_TVALID => AXI4_Stream_Imag_Slave_TVALID,  -- ufix1
              user_ready => top_user_ready_2,  -- ufix1
              AXI4_Stream_Imag_Slave_TREADY => AXI4_Stream_Imag_Slave_TREADY,  -- ufix1
              user_data => top_user_data,  -- ufix128
              user_valid => top_user_valid_2  -- ufix1
              );

  u_AxisPacketGenerator_axi4_stream_real_slave_inst : AxisPacketGenerator_axi4_stream_real_slave
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Real_Slave_TDATA => AXI4_Stream_Real_Slave_TDATA,  -- ufix128
              AXI4_Stream_Real_Slave_TVALID => AXI4_Stream_Real_Slave_TVALID,  -- ufix1
              user_ready => top_user_ready_3,  -- ufix1
              AXI4_Stream_Real_Slave_TREADY => AXI4_Stream_Real_Slave_TREADY,  -- ufix1
              user_data => top_user_data_1,  -- ufix128
              user_valid => top_user_valid_3  -- ufix1
              );

  u_AxisPacketGenerator_dut_inst : AxisPacketGenerator_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              packet_size => write_packet_size,  -- ufix32
              transfer => write_transfer,  -- ufix32
              s_axis_re_tdata => top_user_data_1,  -- ufix128
              s_axis_re_tvalid => s_axis_re_tvalid_sig,  -- ufix1
              s_axis_im_tdata => top_user_data,  -- ufix128
              s_axis_im_tvalid => s_axis_im_tvalid_sig,  -- ufix1
              m_axis_re_tready => m_axis_re_tready_sig,  -- ufix1
              m_axis_im_tready => m_axis_im_tready_sig,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              m_axis_re_tdata => m_axis_re_tdata_sig,  -- ufix128
              m_axis_re_tvalid => m_axis_re_tvalid_sig,  -- ufix1
              m_axis_re_tlast => m_axis_re_tlast_sig,  -- ufix1
              m_axis_im_tdata => m_axis_im_tdata_sig,  -- ufix128
              m_axis_im_tvalid => m_axis_im_tvalid_sig,  -- ufix1
              m_axis_im_tlast => m_axis_im_tlast_sig,  -- ufix1
              s_axis_re_tready => s_axis_re_tready_sig,  -- ufix1
              s_axis_im_tready => s_axis_im_tready_sig  -- ufix1
              );

  u_AxisPacketGenerator_axi4_stream_real_master_inst : AxisPacketGenerator_axi4_stream_real_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Real_Master_TREADY => AXI4_Stream_Real_Master_TREADY,  -- ufix1
              user_data => m_axis_re_tdata_sig,  -- ufix128
              user_valid => top_user_valid,  -- ufix1
              user_TLAST => top_user_TLAST,  -- ufix1
              AXI4_Stream_Real_Master_TDATA => AXI4_Stream_Real_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_Real_Master_TVALID => AXI4_Stream_Real_Master_TVALID,  -- ufix1
              AXI4_Stream_Real_Master_TLAST => AXI4_Stream_Real_Master_TLAST,  -- ufix1
              user_ready => top_user_ready_1  -- ufix1
              );

  ip_timestamp <= to_unsigned(2102091252, 32);

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  const_1_1 <= '1';

  top_user_TLAST <= m_axis_re_tlast_sig;

  top_user_valid <= m_axis_re_tvalid_sig;

  top_user_TLAST_1 <= m_axis_im_tlast_sig;

  top_user_valid_1 <= m_axis_im_tvalid_sig;

  m_axis_im_tready_sig <= top_user_ready;

  m_axis_re_tready_sig <= top_user_ready_1;

  s_axis_im_tvalid_sig <= top_user_valid_2;

  top_user_ready_2 <= s_axis_im_tready_sig;

  s_axis_re_tvalid_sig <= top_user_valid_3;

  top_user_ready_3 <= s_axis_re_tready_sig;

  AXI4_Stream_Real_Master_TDATA <= AXI4_Stream_Real_Master_TDATA_tmp;

  AXI4_Stream_Imag_Master_TDATA <= AXI4_Stream_Imag_Master_TDATA_tmp;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

