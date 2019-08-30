--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Frank Cruz
--
-- Create Date:    
-- Design Name:    ECS527U
-- Module Name:    4-bit LAC Adder
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:	4-bit LAC Adder
--
-- Dependencies: 4-bit LAC and 4-bit Adder.
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

entity four_bit_LAC_Adder is
	Port (InA, InB : in std_logic_vector(3 downto 0);
			C_In : in std_logic;
			Sum : out std_logic_vector (3 downto 0);
			C_out : out std_logic);
end component;

architecture  four_bitLAC_arch of four_bit_LAC_Adder is
-- It is created two components
-- 4-bit LAC 
	component four_bit_LAC
		port(
			InA, InB : in std_logic_vector(3 downto 0);
			Cin : in std_logic;
			C_terms: out std_logic_vector (3 downto 0));
	end component;
-- 4-bit adder
	component four_bit_Adder
		port(
			InA, InB : in std_logic_vector (3 downto 0);
			C_terms : in std_logic_vector (3 downto 0);
			Sum : out std_logic_vector (3 downto 0);
			C_out : out std_logic);
	end component;
	
-- Signal

signal four_bitLAC_terms : std_logic_vector (3 downto 0);

begin

--Instances

	-- instantiate the 4-bit LAC
	four_bit_L_A_C: four_bit_LAC port map (InA,InB, Cin, four_bitLAC_terms);

	-- instance 4-bit Adder
	fourbit_adder: four_bit_Adder port map (InA, InB, four_bitLAC_terms, Sum, C_out);
	

	
	