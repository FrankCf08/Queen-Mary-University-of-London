--------------------------------------------------------------------------------
-- Company: Queen Mary Univerity
-- Engineer: Chris Harte
--
-- Create Date:   14:25:59 10/09/2008
-- Design Name:   nbit_shiftreg
-- Module Name:   nbit_shiftreg_tb.vhd
-- Project Name:  Lab 3
-- Target Device: XCR3064xl-6pc44
-- Tool versions: Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	n-bit shift register test bench   
-- 
-- VHDL Test Bench Created by ISE for module: nbit_shiftreg
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

ENTITY nbit_shiftreg_tb_vhd IS
END nbit_shiftreg_tb_vhd;

ARCHITECTURE behavior OF nbit_shiftreg_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT nbit_shiftreg
	PORT(
		shift_in : IN std_logic;
		CLK : IN std_logic;
		reset : IN std_logic;
		preset : IN std_logic;          
		Q_shift : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL shift_in :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';
	SIGNAL preset :  std_logic := '0';

	--Outputs
	SIGNAL Q_shift :  std_logic_vector(7 downto 0);

BEGIN

-- ************* Comments on how this test bench works ***************** --		

-- TEST BENCH STRATEGY
-- This test bench is designed to show that the shift register can convert a 
-- serial binary input signal (shift_in) into a parallel binary output signal 
-- (Q_shift). The internal flip-flops output state is initially undefined.
-- This is signified by the letter 'U' in VHDL and shows as a red signal in 
-- modelsim. The flip-flops are asynchronously reset (output Q set to '0') 
-- at the beginning so that we can be confident of their output value and thus
-- predict their subsequent behaviour.

-- The main part of the test bench demonstrates serial data being shifted into
-- the register on each clock edge. The clock period has been set to 100 ns.

-- At the end of the test bench, the asynchronous preset is enabled which sets
-- all the flip-flops to '1'.

-- SIMULATION RUN TIME
-- NOTE: This test bench is over 1000ns long (the default simulation run 
-- time). To run this test bench correctly, you will need to extend the 
-- simulation run time to 2000ns. This can be done by right-clicking the 
-- "Simulate Behavioral Model" option in the processes pane and selecting 
-- "Properties" to open the menu that contains this setting.
	
-- ********************************************************************* --

	-- Instantiate the Unit Under Test (UUT)
	uut: nbit_shiftreg PORT MAP(
		shift_in => shift_in,
		CLK => CLK,
		reset => reset,
		preset => preset,
		Q_shift => Q_shift
	);

	-- SET THE CLOCK PERIOD:
	clk <= not clk after 50 ns; -- define clock period 100ns

	tb : PROCESS
	BEGIN



		-- Wait 100 ns for global reset to finish
		wait for 100 ns;
		-- at this point the contents of the register's flip-flops are undefined
		-- register contains: UUUUUUUU


		-- apply asynchronous reset signal:
		reset <= '1';				  
		-- register now contains: 00000000

		wait for 50 ns;

		-- disable reset
		reset <=	'0';				  
		-- register still contains: 00000000

		wait for 25 ns; 
		-- after this wait time we have 25 ns left before the first clock that 
		-- the register will shift data on. Now set the shift_in input to '1'

		shift_in	<= '1';			  

		wait for 800 ns;	-- wait 8 clock periods
		-- register will shift a '1' in at each clock edge until the shift_in
		-- value changes: 		  
		-- clock edge 1: 00000001
		-- clock edge 2: 00000011
		-- clock edge 3: 00000111
		-- clock edge 4: 00001111
		-- clock edge 5: 00011111
		-- clock edge 6: 00111111
		-- clock edge 7: 01111111
		-- clock edge 8: 11111111

		shift_in <= '0';			
										  
		wait for 100 ns; -- wait 1 clock period
		-- clock edge: 11111110

		shift_in <= '1';			  
		
		wait for 300 ns;	-- wait 3 clock periods
		-- clock edge 1: 11111101
		-- clock edge 2: 11111011
		-- clock edge 3: 11110111
		
		shift_in <= '0';			

		wait for 200 ns; 
		-- clock edge 1: 11101110
		-- clock edge 2: 11011100
		
		shift_in <= '1';				

		wait for 100 ns; -- wait clock period
		-- clock edge: 10111001
		
		wait for 40 ns;
		-- asynchronous preset
		preset <= '1';					
		
		-- all flipflops are set to 1:
		-- register now contains: 11111111
		
		wait; -- will wait forever
	END PROCESS;

END;




























