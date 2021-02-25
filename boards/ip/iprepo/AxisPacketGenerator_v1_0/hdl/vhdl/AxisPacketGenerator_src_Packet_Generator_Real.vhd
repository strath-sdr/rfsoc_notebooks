-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\axis_packet_generator\AxisPacketGenerator_src_Packet_Generator_Real.vhd
-- Created: 2021-02-09 12:52:35
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: AxisPacketGenerator_src_Packet_Generator_Real
-- Source Path: axis_packet_generator/AXI-Stream Packet Generator/Packet Generator Real
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY AxisPacketGenerator_src_Packet_Generator_Real IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Packet_Size                       :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        Valid_In                          :   IN    std_logic;
        Data_In                           :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
        End_Out                           :   OUT   std_logic;
        Start_Out                         :   OUT   std_logic;
        Valid_Out                         :   OUT   std_logic;
        Data_Out                          :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
        );
END AxisPacketGenerator_src_Packet_Generator_Real;


ARCHITECTURE rtl OF AxisPacketGenerator_src_Packet_Generator_Real IS

  -- Signals
  SIGNAL Packet_Size_unsigned             : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL HDL_Counter_out1                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Unit_Delay_Enabled_Synchronous_out1 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL AND2_out1                        : std_logic;
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL AND1_out1                        : std_logic;
  SIGNAL AND_out1                         : std_logic;

BEGIN
  Packet_Size_unsigned <= unsigned(Packet_Size);

  -- Free running, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  HDL_Counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter_out1 <= to_unsigned(1, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF Relational_Operator_relop1 = '1' THEN 
          HDL_Counter_out1 <= to_unsigned(1, 32);
        ELSIF Valid_In = '1' THEN 
          HDL_Counter_out1 <= HDL_Counter_out1 + to_unsigned(1, 32);
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Relational_Operator_relop1 <= '1' WHEN Unit_Delay_Enabled_Synchronous_out1 <= HDL_Counter_out1 ELSE
      '0';

  Unit_Delay_Enabled_Synchronous_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous_out1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND Relational_Operator_relop1 = '1' THEN
        Unit_Delay_Enabled_Synchronous_out1 <= Packet_Size_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_Synchronous_process;


  
  Compare_To_Constant1_out1 <= '1' WHEN Unit_Delay_Enabled_Synchronous_out1 /= to_unsigned(0, 32) ELSE
      '0';

  AND2_out1 <= Relational_Operator_relop1 AND (Valid_In AND Compare_To_Constant1_out1);

  
  Compare_To_Constant_out1 <= '1' WHEN HDL_Counter_out1 = to_unsigned(1, 32) ELSE
      '0';

  AND1_out1 <= Compare_To_Constant_out1 AND (Valid_In AND Compare_To_Constant1_out1);

  AND_out1 <= Compare_To_Constant1_out1 AND Valid_In;

  End_Out <= AND2_out1;

  Start_Out <= AND1_out1;

  Valid_Out <= AND_out1;

  Data_Out <= Data_In;

END rtl;

