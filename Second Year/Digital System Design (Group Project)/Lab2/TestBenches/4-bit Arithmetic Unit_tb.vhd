--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Frank Cruz
--
-- Create Date:   15:12:20 13/02/2018
-- Design Name:   4-bit Arithmetic Unit
-- Module Name:   4-bit Arithmetic Unit_td.vhd
-- Project Name:  Lab 2
-- Target Device: xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions: Xilinx Vivado 2017.3
-- Description:	4-bit Arithmetic Unit Test Bench  
-- 
-- VHDL Test Bench Created by ISE for module: 4-bit Arithmetic Unit
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
--This test bench has been created using types std_logic and st_logic_vector for the input
--and output ports. 
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY four_bit_arithmetic_tb_vhd IS
END four_bit_arithmetic_tb_vhd;

ARCHITECTURE behavior OF four_bit_arithmetic_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT four_bit_arit
	PORT(
			InA, InB : in std_logic_vector(3 downto 0);
		    Control : in std_logic_vector(1 downto 0);
			Sum : out std_logic_vector(3 downto 0);
			C_out : out std_logic);
	END COMPONENT;

	--Inputs
	SIGNAL InA :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL InB :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL Control :  std_logic_vector(2 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Sum :  std_logic_vector(3 downto 0);
	SIGNAL C_out :  std_logic;

BEGIN

-- *** Comments on how this test bench works *** --		

-- function table for the 4 bit Arithmetic Unit with example inputs and expected outputs:

		-- Function   Control    InA   InB  :  Sum  C_out
		------------------------------:------------------
		--	A + 1		0 0	
		--	A + B		0 1
		--	A - 1		1 0
		--	A - B		1 1



		-- 

		-- Test bench should check each of these examples		

-- ********************************************** --


	-- Instantiate the Unit Under Test (UUT)
	uut: four_bit_alu PORT MAP(
		InA => InA,
		InB => InB,
		F => F,
		Output => Output,
		C_out => C_out
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		F <= "000";		  -- test NOT A
		InA <= "0101";
		
		wait for 100 ns;

		F <= "001";		  -- test A AND B
		InA <= "0011";
		InB <= "0101";

		wait for 100 ns;

		F <= "010";		  -- test A XOR B
		InA <= "0011";
		InB <= "0101";

		wait for 100 ns;

		F <= "011";		  -- test A OR B
		InA <= "0011";
		InB <= "0101";

		wait for 100 ns;

		F <= "100";		  -- test Inc A
		InA <= "0000";
		
		wait for 100 ns;

		F <= "101";		  -- test A + B
		InA <= "0001";
		InB <= "1111";

		wait for 100 ns;

		F <= "110";		  -- test Dec A
		InA <= "0000";
		InB <= "0000";

		wait for 100 ns;

		F <= "111";		  -- test A - B
		InA <= "1111";
		InB <= "0001";


		wait; -- will wait forever
	END PROCESS;

END;
