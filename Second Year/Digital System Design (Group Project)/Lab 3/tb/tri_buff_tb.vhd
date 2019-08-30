--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   18:34:38 10/01/2008
-- Design Name:   335labs
-- Module Name:   tri_buff_tb.vhd
-- Project Name:  Lab 3
-- Target Device:  XCR3064xl-6pc44
-- Tool versions:  Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	 tristate buffer test bench  
-- 
-- VHDL Test Bench Created by ISE for module: tri_buff
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

ENTITY tri_buff_tb_vhd IS
END tri_buff_tb_vhd;

ARCHITECTURE behavior OF tri_buff_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT tri_buff
	PORT(
		Input : IN std_logic;
		enable : IN std_logic;          
		Output : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL Input :  std_logic := '0';
	SIGNAL enable :  std_logic := '0';

	--Outputs
	SIGNAL Output :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: tri_buff PORT MAP(
		Input => Input,
		enable => enable,
		Output => Output
	);

	tb : PROCESS
	BEGIN

-- *** Comments on how this test bench works *** --		

		-- truth table for a tristate buffer:

		--  enable input :  output
		-----------------:------------
		--		0	 	 0   :	Hi-Z    
   	--		0	 	 1   :	Hi-Z    
	   --		1	 	 0   :	 0    
   	--		1	 	 1   :	 1    

-- ********************************************** --

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- test Hi-Z output (i.e. output disabled - high impedance)
		input <= '0';
		enable <= '0';

		wait for 100 ns;

		input <= '1';

		-- test normal output (i.e. output enabled)
		wait for 100 ns;

		input <= '0';
		enable <= '1';
				
		wait for 100 ns;

		input <= '1';

		wait; -- will wait forever
	END PROCESS;

END;
