--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   15:38:51 10/01/2008
-- Design Name:   four_bit_shifter
-- Module Name:   four_bit_shifter_tb.vhd
-- Project Name:  Lab 2
-- Target Device: xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions: Xilinx Vivado 2017.3
-- Description:	Four-bit shifter unit test bench    
-- 
-- VHDL Test Bench Created by ISE for module: four_bit_shifter
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

ENTITY four_bit_shifter_tb_vhd IS
END four_bit_shifter_tb_vhd;

ARCHITECTURE behavior OF four_bit_shifter_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT four_bit_shifter
	PORT(
		Data_In : IN std_logic_vector(3 downto 0);
		G : IN std_logic_vector(2 downto 0);          
		Output : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL Data_In :  std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL G :  std_logic_vector(2 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Output :  std_logic_vector(3 downto 0);

BEGIN

-- *** Comments on how this test bench works *** --		

-- function table for the ALU with example inputs and expected outputs:

		-- Function   		 	 G    Data_In  :  Output  
		------------------------------------:----------
		--	Pass      			000     0101   :	 0101     
		--	Rotate left	 		001  	  0101   :	 1010     
		--	Shift Left (0) 	010	  1111   :	 1110     
		--	Shift Left (1) 	011     0000   :   0001     
	  	--	Pass      			100     1010   :	 1010     
		--	Rotate right	 	101  	  1010   :	 0101     
		--	Shift right (0) 	110	  1111   :	 0111     
		--	Shift right (1) 	111     0000   :   1000     

		-- Test bench should check each of these examples		

-- ********************************************** --

	-- Instantiate the Unit Under Test (UUT)
	uut: four_bit_shifter PORT MAP(
		Data_In => Data_In,
		G => G,
		Output => Output
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

	   G <= "000";		    -- test Pass
		Data_In <= "0101";
		
		wait for 100 ns;

	   G <= "001";		    -- test rotate left
		Data_In <= "0101";
		
		wait for 100 ns;
		
	   G <= "010";		    -- test shift left (insert 0)
		Data_In <= "1111";

		wait for 100 ns;

	   G <= "011";		    -- test shift left (insert 1)
		Data_In <= "0000";
		
		wait for 100 ns;

	   G <= "100";		    -- test Pass
		Data_In <= "1010";
		
		wait for 100 ns;
		
	   G <= "101";		    -- test rotate right
		Data_In <= "1010";
		
		wait for 100 ns;

		
	   G <= "110";		    -- test shift right (insert 0)
		Data_In <= "1111";
		
		wait for 100 ns;

	   G <= "111";		    -- test shift right (insert 1)
		Data_In <= "0000";
		
		wait for 100 ns;
		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;

































































