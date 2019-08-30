--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   15:06:55 10/01/2008
-- Design Name:   four_bit_alu
-- Module Name:   four_bit_alu_tb.vhd
-- Project Name:  Lab 2
-- Target Device: xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions: Xilinx Vivado 2017.3
-- Description:	Four-bit ALU test bench   
-- 
-- VHDL Test Bench Created by ISE for module: four_bit_alu
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY four_bit_alu_tb_vhd IS
END four_bit_alu_tb_vhd;

ARCHITECTURE behavior OF four_bit_alu_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT four_bit_alu
	PORT(
		InA : IN std_logic_vector(3 downto 0);
		InB : IN std_logic_vector(3 downto 0);
		F : IN std_logic_vector(2 downto 0);          
		Output : OUT std_logic_vector(3 downto 0);
		C_out : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL InA :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL InB :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL F :  std_logic_vector(2 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Output :  std_logic_vector(3 downto 0);
	SIGNAL C_out :  std_logic;

BEGIN

-- *** Comments on how this test bench works *** --		

-- function table for the ALU with example inputs and expected outputs:

		-- Function   F    InA   InB  :  Output  C_out
		------------------------------:------------------
		--	NOT A     000   0101  XXXX :	 1010     X
		--	A AND B	  001	0011  0101 :	 0001     X
		--	A XOR B   010	0011  0101 :	 0110     X
		--	A OR B    011   0011  0101 :     0111     X
		--	Inc A     100   0000  XXXX : 	 0001     0
		--	A + B     101   0001  1111 :     0000	  1
		--	Dec A     110   0000  XXXX :	 1111     1
		--	A - B	  111   1111  0001 :     1110	  0

		-- (X = "don't care")

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
