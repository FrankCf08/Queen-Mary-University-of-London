--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   10:57:51 11/12/2017
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_ripple_counter_tb IS
END nbit_ripple_counter_tb;
 
ARCHITECTURE behavior OF nbit_ripple_counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_ripple_counter
    PORT(
         CLK : IN  std_logic;
         reset : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(7 downto 0);
         Q_bar_outputs : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';

	--Outputs
   signal Q_outputs : std_logic_vector(7 downto 0);
   signal Q_bar_outputs : std_logic_vector(7 downto 0);
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is an n-bit ripple counter, an asynchronous 
--   counter where only the first flip-flop is clocked by an external 
--   clock. All subsequent flip-flops are clocked by the output of the
--   preceding flip-flop. 

--	  n-bit ripple counter test cases (for n=8, the test bench will only 
--   test till four bits however to limit the timing diagram length):

--     Comments      CLK   reset : Q_outpus  Q_bar_outputs 
-- ------------------------------:--------------------------
--     Initial        -      0   : 		U     		U   
--     Cycle 1     rising    0   : 00000001     11111110   
--     Cycle 2     rising    0   : 00000010     11111101   
--     Cycle 3     rising    0   : 00000011     11111100   
--     Cycle 4     rising    0   : 00000100     11111011   
--        .           .      .   :     .           .       
--        .           .      .   :     .           .       
--        .           .      .   :     .           .       
--     Cycle 8     rising    0   : 00001000     11110111   
--  Reset (async)     -      1   : 00000000     11111111   
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_ripple_counter PORT MAP (
          CLK => CLK,
          reset => reset,
          Q_outputs => Q_outputs,
          Q_bar_outputs => Q_bar_outputs
        );
 
   -- SET CLOCK PERIOD
	CLK <= not CLK after 50 ns; -- period = 100ns
	
   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- Initial
		-- Since we are using T flip flops, outputs start as undefined
		-- To define the outputs, we reset it first
		reset <= '1';
		
		wait for 20 ns;
		-- Deactivate reset
		reset <= '0';

      wait for 100ns;
		-- Cycle 1
		
		assert (Q_outputs = "00000001") report "Failed case for Cycle 1";
		assert (Q_bar_outputs = "11111110") report "Failed case for Cycle 1";
		
		wait for 100ns;
		-- Cycle 2
		
		assert (Q_outputs = "00000010") report "Failed case for Cycle 2";
		assert (Q_bar_outputs = "11111101") report "Failed case for Cycle 2";
		
		wait for 100ns;
		-- Cycle 3
		
		assert (Q_outputs = "00000011") report "Failed case for Cycle 3";
		assert (Q_bar_outputs = "11111100") report "Failed case for Cycle 3";
		
		wait for 100ns;
		-- Cycle 4
		
		assert (Q_outputs = "00000100") report "Failed case for Cycle 4";
		assert (Q_bar_outputs = "11111011") report "Failed case for Cycle 4";
		
		wait for 400ns; -- Wait until 8th cycle
		-- Cycle 8
		
		assert (Q_outputs = "00001000") report "Failed case for Cycle 8";
		assert (Q_bar_outputs = "11110111") report "Failed case for Cycle 8";
		
		reset <= '1';	-- async reset, should happen independent of clock edge
		
		wait for 20 ns;
		
		assert (Q_outputs = "00000000") report "Failed case for Reset";
		assert (Q_bar_outputs = "11111111") report "Failed case for Reset";		

      wait;
   end process;

END;
