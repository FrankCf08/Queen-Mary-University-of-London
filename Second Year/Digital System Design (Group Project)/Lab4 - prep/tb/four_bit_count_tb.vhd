--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
--
-- Create Date:   15:06:58 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY four_bit_count_tb IS
END four_bit_count_tb;
 
ARCHITECTURE behavior OF four_bit_count_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT four_bit_count
    PORT(
         CLK : IN  std_logic;
         reset : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is a 4-bit synchronous counter. This circuit 
--   counts from 0000 in steps of 1 until it reaches 1111. It starts the
--	  cycle again once it reaches the highest value.

--	  4-bit synchronous counter test cases:

--        Comments          CLK   reset :  Q_outputs 
-- -------------------------------------:------------
--  Increment last state  rising    0   : last Q + 1 
--          Reset            X      1   :    0000    
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: four_bit_count PORT MAP (
          CLK => CLK,
          reset => reset,
          Q_outputs => Q_outputs
        );
		  
   -- SET CLOCK PERIOD
	CLK <= not CLK after 50 ns; -- period = 100ns

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- Reset output to 0
		reset <= '1';
		
		wait for 20 ns;
		-- Deactivate reset
		reset <= '0';
		
		wait for 100 ns;
		-- Case 1: State 1
		
		assert (Q_outputs = "0001") report "Case 1 failed: Q_outputs /= 0001";
		
		wait for 100 ns;
		-- Case 2: State 2
		
		assert (Q_outputs = "0010") report "Case 2 failed: Q_outputs /= 0010";
		
		wait for 600 ns;
		-- Case 3: State 8
		
		assert (Q_outputs = "1000") report "Case 3 failed: Q_outputs /= 1000";
		
		wait for 700 ns;
		-- Case 4: State 15

		assert (Q_outputs = "1111") report "Case 4 failed: Q_outputs /= 1111";

		wait for 100 ns;
		-- Case 5: Back to State 0
		
		assert (Q_outputs = "0000") report "Case 5 failed: Q_outputs /= 0000";
		
		wait for 100 ns;
		-- Case 6: Back to State 1
		
		assert (Q_outputs = "0001") report "Case 6 failed: Q_outputs /= 0001";
		
		reset <= '1';

      wait;
   end process;

END;
