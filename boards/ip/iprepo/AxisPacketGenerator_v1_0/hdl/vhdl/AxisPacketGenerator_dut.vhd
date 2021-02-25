-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\axis_packet_generator\AxisPacketGenerator_dut.vhd
-- Created: 2021-02-09 12:52:42
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: AxisPacketGenerator_dut
-- Source Path: AxisPacketGenerator/AxisPacketGenerator_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AxisPacketGenerator_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        packet_size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        transfer                          :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        s_axis_re_tdata                   :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_re_tvalid                  :   IN    std_logic;  -- ufix1
        s_axis_im_tdata                   :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        s_axis_im_tvalid                  :   IN    std_logic;  -- ufix1
        m_axis_re_tready                  :   IN    std_logic;  -- ufix1
        m_axis_im_tready                  :   IN    std_logic;  -- ufix1
        ce_out                            :   OUT   std_logic;  -- ufix1
        m_axis_re_tdata                   :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_re_tvalid                  :   OUT   std_logic;  -- ufix1
        m_axis_re_tlast                   :   OUT   std_logic;  -- ufix1
        m_axis_im_tdata                   :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        m_axis_im_tvalid                  :   OUT   std_logic;  -- ufix1
        m_axis_im_tlast                   :   OUT   std_logic;  -- ufix1
        s_axis_re_tready                  :   OUT   std_logic;  -- ufix1
        s_axis_im_tready                  :   OUT   std_logic  -- ufix1
        );
END AxisPacketGenerator_dut;


ARCHITECTURE rtl OF AxisPacketGenerator_dut IS

  -- Component Declarations
  COMPONENT AxisPacketGenerator_src_AXI_Stream_Packet_Generator
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
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

  -- Component Configuration Statements
  FOR ALL : AxisPacketGenerator_src_AXI_Stream_Packet_Generator
    USE ENTITY work.AxisPacketGenerator_src_AXI_Stream_Packet_Generator(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL s_axis_re_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL s_axis_im_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL m_axis_re_tready_sig             : std_logic;  -- ufix1
  SIGNAL m_axis_im_tready_sig             : std_logic;  -- ufix1
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m_axis_re_tdata_sig              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_re_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL m_axis_re_tlast_sig              : std_logic;  -- ufix1
  SIGNAL m_axis_im_tdata_sig              : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL m_axis_im_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL m_axis_im_tlast_sig              : std_logic;  -- ufix1
  SIGNAL s_axis_re_tready_sig             : std_logic;  -- ufix1
  SIGNAL s_axis_im_tready_sig             : std_logic;  -- ufix1

BEGIN
  u_AxisPacketGenerator_src_AXI_Stream_Packet_Generator : AxisPacketGenerator_src_AXI_Stream_Packet_Generator
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              packet_size => packet_size,  -- ufix32
              transfer => transfer,  -- ufix32
              s_axis_re_tdata => s_axis_re_tdata,  -- ufix128
              s_axis_re_tvalid => s_axis_re_tvalid_sig,  -- ufix1
              s_axis_im_tdata => s_axis_im_tdata,  -- ufix128
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

  s_axis_re_tvalid_sig <= s_axis_re_tvalid;

  s_axis_im_tvalid_sig <= s_axis_im_tvalid;

  m_axis_re_tready_sig <= m_axis_re_tready;

  m_axis_im_tready_sig <= m_axis_im_tready;

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  m_axis_re_tdata <= m_axis_re_tdata_sig;

  m_axis_re_tvalid <= m_axis_re_tvalid_sig;

  m_axis_re_tlast <= m_axis_re_tlast_sig;

  m_axis_im_tdata <= m_axis_im_tdata_sig;

  m_axis_im_tvalid <= m_axis_im_tvalid_sig;

  m_axis_im_tlast <= m_axis_im_tlast_sig;

  s_axis_re_tready <= s_axis_re_tready_sig;

  s_axis_im_tready <= s_axis_im_tready_sig;

END rtl;

