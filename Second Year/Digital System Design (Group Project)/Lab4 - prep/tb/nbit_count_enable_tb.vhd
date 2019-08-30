--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   08:19:20 10/29/2008
-- Design Name:   n_bit_count_enable
-- Module Name:   nbit_count_enable_tb.vhd
-- Project Name:  Lab 4
-- Target Device: XCR3064xl-6pc44
-- Tool versions: Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter  
-- Description:  Test bench for n-bit counter with enable input    
-- 
-- VHDL Test Bench Created by ISE for module: n_bit_count_enable
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

ENTITY nbit_count_enable_tb_vhd IS
END nbit_count_enable_tb_vhd;

ARCHITECTURE behavior OF nbit_count_enable_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT nbit_count_enable
	PORT(
		enable : IN std_logic;
		CLK : IN std_logic;
		reset : IN std_logic;    
		Q_outputs : INOUT std_logic_vector(7 downto 0);      
		ripple_carry_out : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL enable :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL reset :  std_logic := '1';

	--BiDirs
	SIGNAL Q_outputs :  std_logic_vector(7 downto 0);

	--Outputs
	SIGNAL ripple_carry_out :  std_logic;

BEGIN

-- *************** Comments on how this test bench works ***************** --		

-- The circuit under test is an 8-bit synchronous counter with an enable input.
-- This test bench provides a 100ns clock signal to test the counting operation.
-- The counter is first reset then enabled 100ns afterwards. At time 1200ns, 
-- the counter is disabled and the output should stay stable for the following 
-- 500ns. After this, the counter is let to run all the way to the maximum 
-- value 11111111 after which it will overflow and wrap round to 00000000. 

-- NOTE: To test that this counter counts all the way to 11111111 without 
-- errors the test bench should be run for 30000ns (i.e. >256 clock cycles)

-- Also note the value of the ripple_carry_out - it can go to '1' when the
-- incrementer is calculating the next value in several states before it 
-- settles on the correct next state value.

-- ************************************************************************ --

	-- Instantiate the Unit Under Test (UUT)
	uut: nbit_count_enable PORT MAP(
		enable => enable,
		CLK => CLK,
		reset => reset,
		Q_outputs => Q_outputs,
		ripple_carry_out => ripple_carry_out
	);

	CLK <= not CLK after 50 ns;

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- release the reset signal
		-- (note that it is initialised to '1' on line 53) 
		reset <= '0';

		wait for 100 ns;

		-- start counting
		enable <= '1';

		wait for 1000 ns;

		-- stop counting (output should be 00001010)
		enable <= '0';

		wait for 500 ns;

		-- start counting again
		enable <= '1';

		-- keep counting for long enough that the counter overflows
		-- (this occurs at around 26200 ns)

		wait; -- will wait forever
	END PROCESS;

END;












































































