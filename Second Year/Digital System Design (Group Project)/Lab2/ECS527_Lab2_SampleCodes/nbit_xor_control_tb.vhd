--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   11:42:08 10/01/2008
-- Design Name:   527labs
-- Module Name:   nbit_xor_control_tb.vhd
-- Project Name:   Lab 2
-- Target Device:  xc7z020clg484-1 ( Zynq-7020 FPGA)
-- Tool versions:  Xilinx Vivado 2017.3
-- Description:    Test bench for the XOR control
-- 
-- VHDL Test Bench Created by ISE for module: nbit_xor_contol
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

ENTITY nbit_xor_control_tb_vhd IS
END nbit_xor_control_tb_vhd;

ARCHITECTURE behavior OF nbit_xor_control_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT nbit_xor_contol
	PORT(
		Input : IN std_logic_vector(3 downto 0);
		control : IN std_logic;          
		Output : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL control :  std_logic := '0';
	SIGNAL Input :  std_logic_vector(3 downto 0) := (others=>'0');

	--Outputs
	SIGNAL Output :  std_logic_vector(3 downto 0);

BEGIN

-- *** Comments on how this test bench works *** --		

-- Because we define a default value of 4 for our generic value
-- in the VHDL code for this device, the Xilinx ISE software will
-- automatically generate a test bench for an instance of the 
-- device of that width.
 
		-- truth table for the XOR control:

		--  control  Input  : Output
		--------------------:------------
		--		 0	      N    :	 N     
		--		 1	      N    :  not N     

		-- in this case, N is any 4-bit value

-- in this example we will use "0101" as the input so 
-- we expect to see:

		--  control  Input  : Output
		--------------------:------------
		--		 0	     0101  :  0101   
		--		 1	     0101  :  1010 
		
-- ********************************************** --    


-- Instantiate the Unit Under Test (UUT)
	uut: nbit_xor_contol PORT MAP(
		Input => Input,
		control => control,
		Output => Output
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		control <= '0';   -- set control to zero, device should buffer the input
		Input <= "0101";  -- note double quotes for n-bit values

		wait for 100 ns;

		control <= '1';	-- set control to 1, device should invert the input

		wait; -- will wait forever
	END PROCESS;

END;




























































































