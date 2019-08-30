--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
--
-- Create Date:   20:13:35 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY eight_bit_comparator_tb IS
END eight_bit_comparator_tb;
 
ARCHITECTURE behavior OF eight_bit_comparator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT eight_bit_comparator
    PORT(
         InA : IN  std_logic_vector(7 downto 0);
         InB : IN  std_logic_vector(7 downto 0);
         Output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal InA : std_logic_vector(7 downto 0) := (others => '0');
   signal InB : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic;
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is an 8-bit synchronous comparator. This
--   circuit compares InA and InB, returning 1 if equal and 0 otherwise.

--	  4-bit synchronous counter test cases:

--        Comments		InA   	 InB	  :  Output
-- --------------------------------------:----------
--  		 Not Equal      X  		  Y 	  :    0
--          Equal	    	 Q 		  Q	  :    1   
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: eight_bit_comparator PORT MAP (
          InA => InA,
          InB => InB,
          Output => Output
        );

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		InA <= "10100011";
		InB <= "10100011";
		
		wait for 100 ns;	-- Wait until output has propagated
		-- Case 1 : Equal
		
		assert (Output = '1') report "Case 1 failed : Output /= 1";
		
		InA <= "11110000";
		InB <= "00001111";
		
		wait for 100 ns;	-- Wait until output has propagated
		-- Case 2 : Not Equal
		
		assert (Output = '0') report "Case 1 failed : Output /= 0";

      wait;
   end process;

END;
