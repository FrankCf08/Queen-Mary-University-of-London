--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
--
-- Create Date:   19:25:05 11/13/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY eight_bit_modulo_counter_sync_reset_tb IS
END eight_bit_modulo_counter_sync_reset_tb;
 
ARCHITECTURE behavior OF eight_bit_modulo_counter_sync_reset_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT eight_bit_modulo_counter_sync_reset
    PORT(
         M_value : IN  std_logic_vector(7 downto 0);
         count_enable : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal M_value : std_logic_vector(7 downto 0) := (others => '0');
   signal count_enable : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';

	--BiDirs
   signal Q_outputs : std_logic_vector(7 downto 0);
 
BEGIN
 
-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is an 8-bit modulo-m counter with 
--   synchronous reset. This circuit helps to count to any arbitrary
--   value by using a comparator to reset the counter when M_value
--   is reached. Note that the reset pin signal is itself asynchronous.
--   It is the reset that happens when the counter reaches M_value (by
--   loading 0s into the counter) which is synchronous.

--	  8-bit modulo-m counter with synchronous reset test cases:

--         Comments           CLK   reset  count_enable  M_value :  Q_outputs 
-- --------------------------------------------------------------:-------------
--           Reset             X      1          X          X    :  00000000    
--           Hold           Rising    0          0          X    :   last Q   
--   Count up (last Q < M)  Rising    0          1          M    : last Q + 1 
--  Count up  (last Q = M)  Rising    0          1          M    :  00000000
 
	
-- ******************************************************************** --

	-- Instantiate the Unit Under Test (UUT)
   uut: eight_bit_modulo_counter_sync_reset PORT MAP (
          M_value => M_value,
          count_enable => count_enable,
          CLK => CLK,
          reset => reset,
          Q_outputs => Q_outputs
        );
		  
   -- SET CLOCK PERIOD
	-- Note: we are using a period of 200 ns as the 
	-- propagation delay of the comparator is about
	-- 70 ns. When added to the other delays, changes
	-- take more than a clock period of say, 100 ns,
	-- to be propagated through to the output.
	CLK <= not CLK after 100 ns; -- period = 200ns

   tb: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;
		-- Reset output to 0
		reset <= '1';
		
		wait for 20 ns;
		-- Deactivate reset
		reset <= '0';
		
		count_enable <= '1';
		M_value <= "00000011";
		
		wait for 200 ns;
		-- Case 1: Count up
		
		assert (Q_outputs = "00000001") report "Case 1 failed: Q_outputs /= 00000001";
		
		wait for 200 ns;
		-- Case 2: Count up
		
		assert (Q_outputs = "00000010") report "Case 2 failed: Q_outputs /= 00000010";
		
		count_enable <= '0';
		
		wait for 600 ns;
		-- Case 3: Hold for three clock cycles
		
		assert (Q_outputs = "00000010") report "Case 3 failed: Q_outputs /= 00000010";
		
		count_enable <= '1';
		
		wait for 200 ns;
		-- Case 4: Q = M_value
		
		assert (Q_outputs = "00000011") report "Case 4 failed: Q_outputs /= 00000011";
		
		wait for 70 ns; -- Since reset is sync, value changes at next rising edge
		-- Case 5: Check reset hasn't happened async
		
		assert (Q_outputs = "00000011") report "Case 5 failed: Q_outputs /= 00000011";
		
		wait for 130 ns; -- Wait till next rising edge
		-- Case 6: Wrap back to 0
		
		assert (Q_outputs = "00000000") report "Case 6 failed: Q_outputs /= 00000000";

      wait;
   end process;

END;
