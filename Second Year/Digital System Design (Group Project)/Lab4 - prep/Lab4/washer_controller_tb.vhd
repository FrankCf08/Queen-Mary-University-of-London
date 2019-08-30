--------------------------------------------------------------------------------
-- Company: Queen Mary University
-- Engineer: Chris Harte
--
-- Create Date:   11:36:16 10/29/2008
-- Design Name:   washer_controller
-- Module Name:   washer_controller_tb.vhd
-- Project Name:  Lab 4
-- Target Device: XCR3064xl-6pc44
-- Tool versions: Xilinx ISE	   7.104i and ModelSim XE III 6.0a starter  
-- Description:  Test bench for washing machine controller 
-- 
-- VHDL Test Bench Created by ISE for module: washer_controller
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

ENTITY washer_controller_tb_vhd IS
END washer_controller_tb_vhd;

ARCHITECTURE behavior OF washer_controller_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT washer_controller
	PORT(
		CLK : IN std_logic;
		spin_dry : IN std_logic;
		start_wash : IN std_logic;
		door_open : IN std_logic;
		reset : IN std_logic;          
		door_lock : OUT std_logic;
		water_pump : OUT std_logic;
		soap : OUT std_logic;
		rotate_drum : OUT std_logic;
		drain : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL spin_dry :  std_logic := '0';
	SIGNAL start_wash :  std_logic := '0';
	SIGNAL door_open :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';

	--Outputs
	SIGNAL door_lock :  std_logic;
	SIGNAL water_pump :  std_logic;
	SIGNAL soap :  std_logic;
	SIGNAL rotate_drum :  std_logic;
	SIGNAL drain :  std_logic;

BEGIN

-- *************** Comments on how this test bench works ***************** --		

-- After reset, the washer controller should remain in state 0 until the door
-- is closed and the start_wash button is pressed. 

-- This test bench tests two full cycles of the state machine - the first
-- should go through states 0, 1, 2, 3, 4, 5, 6 then return to s0 because the 
-- "spin_dry" option is '0'.

-- The second run through will go through all the states including state 7 
-- with the "spin_dry" input set to '1' then return to s0.

-- 						  |---------  Expected outputs ---------|                            
-- Function  	State    door_lock, water, soap, rotate, drain       

--Load clothes   0          0    	 0      0      0	 	 0
--Wash fill      1          1   		 1      1     	0      0
--Wash spin      2          1   		 0      0     	1      0
--Drain          3          1   		 0      0     	0      1
--Rinse fill     4          1   		 1      0     	0      0
--Rinse spin     5          1   		 0      0     	1      0
--Drain          6          1   		 0      0     	0      1
--Spin dry       7          1   		 0      0     	1      1
														 
-- NOTE: The clock is set to have a period of 100ns so this test bench must be 
-- run for 3000ns in order to see both cycles of the test complete.

-- ************************************************************************ --

	-- Instantiate the Unit Under Test (UUT)
	uut: washer_controller PORT MAP(
		CLK => CLK,
		spin_dry => spin_dry,
		start_wash => start_wash,
		door_open => door_open,
		reset => reset,
		door_lock => door_lock,
		water_pump => water_pump,
		soap => soap,
		rotate_drum => rotate_drum,
		drain => drain
	);

	CLK <= not CLK after 100 ns;

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- reset the state register
		reset <= '1';

		wait for 190 ns;

		-- release the reset control
		reset <= '0';

		wait for 200 ns;

		-- test door open and not start_wash
		-- (should stay in s0)
		door_open <= '1';
		start_wash <= '0';

		wait for 200 ns;

		-- test door closed and not start_wash
		-- (should stay in s0)
		door_open <= '0';
		start_wash <= '0';

		wait for 200 ns;
		-- test door closed and start_wash
		-- (should move to s1 on next clock)
		door_open <= '0';
		start_wash <= '1';

		wait for 200 ns;

		-- release the start_wash and set spin_dry to 0
		start_wash <= '0';
		spin_dry <= '0';

		wait for 1600 ns;

		-- during this time the controller should run through states 0-6 then 
		-- return to s0

		-- start the second cycle:
		door_open <= '0';
		start_wash <= '1';

		wait for 200 ns;

		-- release the start_wash control and set the spin_dry to '1'
		start_wash <= '0';
		spin_dry <= '1';

		wait for 1800 ns;

		-- during this time the controller should run through states 0-7 then 
		-- return to s0


		wait; -- will wait forever
	END PROCESS;

END;


















