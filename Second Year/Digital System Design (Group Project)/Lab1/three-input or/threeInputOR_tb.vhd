--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Student ID: 150684871
-- Engineer: Frank Cruz Felix
--
-- Create Date:   19:06:32 23/01/2018
-- Design Name:   three_input_or
-- Module Name:   three_input_or_tb.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 test bench for a simple two input OR gate
-- 
-- VHDL Test Bench Created by ISE for module: two_input_or
--
-- Dependencies:	three_input_or.vhd
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

ENTITY three_input_or_tb_vhd IS
END three_input_or_tb_vhd;

ARCHITECTURE test_arch of three_input_or_tb_vhd IS

	--Component declaration for the Unit Under Test (UUT)
	COMPONENT three_InputOrgate
	PORT(
		a: IN std_logic;
		b: IN std_logic;
		c: IN std_logic;
		z: OUT std_logic
		);
	END COMPONENT;

	--Inputs

	SIGNAL sig_a: std_logic := '0';
	SIGNAL sig_b: std_logic := '0';
	SIGNAL sig_c: std_logic := '0';

	--Outputs

	SIGNAL sig_z: std_logic;

BEGIN

	--Instantiate the Unit Under Test (UUT)

	uut: three_InputOrgate PORT MAP (sig_a,sig_b,sig_c,sig_z);

	tb: PROCESS
	BEGIN

-- ********Comments on how this test bench works ************---

		-- truth table for an OR gate:
		--    	c    b    a  :   z
		----------------:--------------
		--	0    0    0  :   0
		--	0    0    1  :   1
		--  0    1    0  :   1
		--  0    1    1  :   1
		--	1    0    0  :   1
		--	1    0    1  :   1
		--  1    1    0  :   1
		--  1    1    1  :   1

	-- input test signal of the correct values to sig_a
		-- and sig_b at 100 ns intervals to check that sig_f
		-- gives the expected output.

------***************************************************--------

		wait for 100 ns; --waiting for global reset

		sig_a <= '0';
		sig_b <= '0';   
		sig_c <= '0';  -- check 0 or 0 or 0 = 0

		wait for 100 ns;

		sig_a <= '1';   -- check 0 or 0 or 1 = 1

		wait for 100 ns;

		sig_a <= '0';
		sig_b <= '1';   -- check 0 or 1 or 0 = 1

		wait for 100 ns;

		sig_a <= '1';   -- check 0 or 1 or 1 = 1

		wait for 100 ns;

		sig_a <= '0';
		sig_b <= '0';  
		sig_c <= '1';  -- check 1 or 0 or 0 = 1

		wait for 100 ns;

		sig_a <= '1';  -- check 1 or 0 or 1 = 1

		wait for 100 ns;

		sig_a <= '0';
		sig_b <= '1';   -- check 1 or 1 or 0 = 1

		wait for 100 ns;

		sig_a <= '1';   -- check 1 or 1 or 1 = 1

		wait ; -- end of test will wait forever

	END PROCESS;

END;
