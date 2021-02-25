-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\axis_packet_generator\AxisPacketGenerator_src_Rising_Edge_Detector.vhd
-- Created: 2021-02-09 12:52:35
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: AxisPacketGenerator_src_Rising_Edge_Detector
-- Source Path: axis_packet_generator/AXI-Stream Packet Generator/Packet Inspector Real/Rising Edge Detector
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AxisPacketGenerator_src_Rising_Edge_Detector IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Signal_rsvd                       :   IN    std_logic;
        Rise                              :   OUT   std_logic
        );
END AxisPacketGenerator_src_Rising_Edge_Detector;


ARCHITECTURE rtl OF AxisPacketGenerator_src_Rising_Edge_Detector IS

  -- Signals
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL AND1_out1                        : std_logic;

BEGIN
  NOT_out1 <=  NOT Signal_rsvd;

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_out1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Delay_out1 <= NOT_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  AND1_out1 <= Signal_rsvd AND Delay_out1;

  Rise <= AND1_out1;

END rtl;

