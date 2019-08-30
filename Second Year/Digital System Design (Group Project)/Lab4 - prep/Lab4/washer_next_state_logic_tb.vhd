--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   23:01:20 11/14/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY washer_next_state_logic_tb IS
END washer_next_state_logic_tb;
 
ARCHITECTURE behavior OF washer_next_state_logic_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT washer_next_state_logic
    PORT(
         state : IN  std_logic_vector(2 downto 0);
         door_open : IN  std_logic;
         control : IN  std_logic;
         next_state : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal state : std_logic_vector(2 downto 0) := (others => '0');
   signal door_open : std_logic := '0';
   signal control : std_logic := '0';

 	--Outputs
   signal next_state : std_logic_vector(2 downto 0);
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is a combinational circuit representing the
--   clothes washer controller's next-state logic.

--	  The truth table for this component is given below:

--    Function    state  door_open  control : next_state 
-- -----------------------------------------:------------
--                 000       1         X    :     000    
--  Load clothes   000       0         0    :     000    
--                 000       0         1    :     001    
--    Wash fill    001       X         X    :     010    
--    Wash spin    010       X         X    :     011    
--      Drain      011       X         X    :     100    
--   Rinse fill    100       X         X    :     101    
--   Rinse spin    101       X         X    :     110    
--      Drain      110       X         0    :     000    
--      Drain      110       X         1    :     111    
--    Spin dry     111       X         X    :     000    
 
	
-- ******************************************************************** -- 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: washer_next_state_logic PORT MAP (
          state => state,
          door_open => door_open,
          control => control,
          next_state => next_state
        );
 

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		state <= "000";
		door_open <= '1';
		
		wait for 105 ns;
		-- Case 1
		
		assert (next_state = "000") report "Case 1 failed: next_state /= 000";
		
		door_open <= '0';
		
		wait for 105 ns;
		-- Case 2
		
		assert (next_state = "000") report "Case 2 failed: next_state /= 000";
		
		control <= '1';
		
		wait for 105 ns;
		-- Case 3
		
		assert (next_state = "001") report "Case 3 failed: next_state /= 001";
		
		state <= "001";
		
		wait for 105 ns;
		-- Case 4
		
		assert (next_state = "010") report "Case 4 failed: next_state /= 010";
		
		state <= "010";
		
		wait for 105 ns;
		-- Case 5
		
		assert (next_state = "011") report "Case 5 failed: next_state /= 011";
		
		state <= "011";
		
		wait for 105 ns;
		-- Case 6
		
		assert (next_state = "100") report "Case 6 failed: next_state /= 100";
		
		state <= "100";
		
		wait for 105 ns;
		-- Case 7
		
		assert (next_state = "101") report "Case 7 failed: next_state /= 101";
		
		state <= "101";
		
		wait for 105 ns;
		-- Case 8
		
		assert (next_state = "110") report "Case 8 failed: next_state /= 110";
		
		state <= "110";
		control <= '0';
		
		wait for 105 ns;
		-- Case 9
		
		assert (next_state = "000") report "Case 9 failed: next_state /= 000";
		
		control <= '1';
		
		wait for 105 ns;
		-- Case 10
		
		assert (next_state = "111") report "Case 10 failed: next_state /= 111";
		
		state <= "111";
		
		wait for 105 ns;
		-- Case 11
		
		assert (next_state = "000") report "Case 11 failed: next_state /= 000";

      wait;
   end process;

END;
