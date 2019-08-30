--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   15:52:57 10/09/2008
-- Design Name:   t_flipflop
-- Module Name:   t_flipflop_tb.vhd
-- Project Name:  Lab 3
-- Target Device: XCR3064xl-6pc44
-- Tool versions: Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter 
-- Description:	T-type flip-flop test bench  
-- 
-- VHDL Test Bench Created by ISE for module: t_flipflop
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

ENTITY t_flipflop_tb_vhd IS
END t_flipflop_tb_vhd;

ARCHITECTURE behavior OF t_flipflop_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT t_flipflop
	PORT(
		reset : IN std_logic;
		Clk : IN std_logic;       
		Q : INOUT std_logic;
		Q_bar : INOUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL reset :  std_logic := '0';
	SIGNAL Clk :  std_logic := '0';

	--BiDirs
	SIGNAL Q :  std_logic;
	SIGNAL Q_bar :  std_logic;

BEGIN
 
-- ************* Comments on how this test bench works **************** --		

-- The T-type or "Toggle" flip-flop is designed to invert its output 
-- value on each rising clock edge. 

-- At the begining of the test bench, the outputs of the flip-flop
-- are undefined. This is signified by the letter 'U' in VHDL and
-- shows as a red signal in modelsim. For the behaviour of the device
-- to be predictable, we must put it into a defined state so we use 
-- the asynchronous reset to set the Q output to '0' (and Q_bar = '1').

-- 	 CLK	reset	: 		Q  		Q_bar 
--    ------------:------------------------
--      X	  1	:		0	  			1
--		rising  0   :  last Q_bar  last Q
	
-- ******************************************************************** --

	-- Instantiate the Unit Under Test (UUT)
	uut: t_flipflop PORT MAP(
		reset => reset,
		Clk => Clk,
		Q => Q,
		Q_bar => Q_bar
	);

-- SET CLOCK PERIOD
	clk <= not clk after 50 ns; -- period = 100ns

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;
		-- both outputs start undefined 'U'

		reset <= '1';
		-- this sets Q to '0' and Q_bar to '1'
		-- note that while reset is asserted, the flip-flop
		-- does not react to the clock signal

		wait for 120ns;

		reset <= '0';
		
		-- after reset changes to 0, the Q output value will toggle 
		-- on each rising clock edge. 

		wait; -- will wait forever
	END PROCESS;

END;
























































































