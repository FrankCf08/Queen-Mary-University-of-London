--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Frank Cruz
--
-- Create Date:    
-- Design Name:    ECS527U
-- Module Name:    4-bit Arithmetic Unit
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:	4-bit Arithmetic Unit
--
-- Dependencies: n-bit 2-input mux and 4-bit Adder/Subtractor.
-- 
-- Revision:
-- Revision 0.01- File created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity four_bit_arithmetic_unit is
	Port ( InA, InB : in std_logic_vector(3 downto 0);
		    Control : in std_logic_vector(1 downto 0);
			 Sum : out std_logic_vector(3 downto 0);
			 C_out : out std_logic);
end component;

architecture  fourbit_arch of four_bit_arithmetic_unit is
-- It is created two components
-- n bit 2 input MUX
	component n_bit_2_input_MUX
		port(
			InA, InB : in std_logic_vector(3 downto 0);
			Control : in std_logic_vector (1 downto 0);
			Output: out std_logic_vector (3 downto 0);
			);
	end component;
-- four-bit Adder/Substractor
	component four_bit_Adder_Substractor
		port(
			InA, InB : in std_logic_vector (3 downto 0);
			Control : in std_logic_vector (1 downto 0);
			Sum : out std_logic_vector (3 downto 0);
			C_out : out std_logic);
	end component;
	
-- Signal

signal n_bit2inputMux : std_logic_vector (3 downto 0);

begin

--Instances

	-- instantiate the n_bit_2_input_MUX 
	two_inputMux: n_bit_2_input_MUX port map (InA,InB, Control(1 downto 0), n_bit2inputMux);

	-- instance 4-bit Adder/Subtractor
	Adder_Subtractor: four_bit_Adder_Substractor port map (InA, n_bit2inputMux, Control(1 downto 0), Sum, C_out);
	

	
	