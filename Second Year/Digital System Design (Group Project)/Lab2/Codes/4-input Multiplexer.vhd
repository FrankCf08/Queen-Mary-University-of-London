--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Frank Cruz
--
-- Create Date:    
-- Design Name:    ECS527U
-- Module Name:    4-input Multiplexer
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:	4-input Multiplexer
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity four_input_Mux is
	Port (	a, b, c, d : in std_logic;
			Control1, Control2 : in std_logic_vector (1 downto 0);
			Output : out std_logic);
end component;

architecture  four_input_Arch of four_input_Mux is
begin
	Output <= (a and ((not Control1) and (not Control2))) or  (b and ((not Control1) and  Control2)) or (c and ( Control1 and (not Control2))) or (d and (Control1 and Control2));
end four_input_Arch;
	

	
	