--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
--
-- Create Date:   20:46:34 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY eightbit_module_counter_async_reset_tb IS
END eightbit_module_counter_async_reset_tb;
 
ARCHITECTURE behavior OF eightbit_module_counter_async_reset_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT eight_bit_modulo_counter_async_reset
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
--   asynchronous reset. This circuit helps to count to any arbitrary
--   value by using a comparator to reset the counter when M_value
--   is reached.

--	  8-bit modulo-m counter with asynchronous reset test cases:

--         Comments           CLK   reset  count_enable  M_value :  Q_outputs 
-- --------------------------------------------------------------:-------------
--           Reset             X      1          X          X    :  00000000    
--           Hold           Rising    0          0          X    :   last Q   
--   Count up (last Q < M)  Rising    0          1          M    : last Q + 1 
--  Count up  (last Q = M)     X      0          1          M    :  00000000
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: eight_bit_modulo_counter_async_reset PORT MAP (
          M_value => M_value,
          count_enable => count_enable,
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
		
		count_enable <= '1';
		M_value <= "00000011";
		
		wait for 100 ns;
		-- Case 1: Count up
		
		assert (Q_outputs = "00000001") report "Case 1 failed: Q_outputs /= 00000001";
		
		wait for 100 ns;
		-- Case 2: Count up
		
		assert (Q_outputs = "00000010") report "Case 2 failed: Q_outputs /= 00000010";
		
		count_enable <= '0';
		
		wait for 300 ns;
		-- Case 3: Hold for three clock cycles
		
		assert (Q_outputs = "00000010") report "Case 3 failed: Q_outputs /= 00000010";
		
		count_enable <= '1';
		
		wait for 100 ns;
		-- Case 4: Q = M_value
		
		assert (Q_outputs = "00000011") report "Case 4 failed: Q_outputs /= 00000011";
		
		wait for 70 ns; -- Since reset is async, value changes after comparator delay
		-- Case 5: Wrap back to 0
		
		assert (Q_outputs = "00000000") report "Case 5 failed: Q_outputs /= 00000000";
		
		reset <= '1';

      wait;
   end process;

END;
