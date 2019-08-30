--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
--
-- Create Date:   13:24:09 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_incrementer_tb IS
END nbit_incrementer_tb;
 
ARCHITECTURE behavior OF nbit_incrementer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_incrementer
    PORT(
         InA : IN  std_logic_vector(3 downto 0);
         C_in : IN  std_logic;
         Sum : OUT  std_logic_vector(3 downto 0);
         C_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal InA : std_logic_vector(3 downto 0) := (others => '0');
   signal C_in : std_logic := '0';

 	--Outputs
   signal Sum : std_logic_vector(3 downto 0);
   signal C_out : std_logic;
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is an n-bit incrementer. This circuit will
--   either increment InA by 1 when C_in is '1' and leave it unchanged
--	  if otherwise. It will also give an appropriate carry in C_out.

--	  n-bit incrementer test cases (for n=4):

--         Comments          InA  C_in :  Sum   C_out 
-- ------------------------------------:--------------
--         Unchanged        1110    0  :  1110    0   
--  Inc, with no out carry  1110    1  :  1111    0   
--    Inc, with out carry   1111    1  :  0000    1   
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_incrementer PORT MAP (
          InA => InA,
          C_in => C_in,
          Sum => Sum,
          C_out => C_out
        );

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		C_in <= '0';
		InA <= "1110";
		
		wait for 50 ns;	-- Wait until change has propagated
		-- Case 1 : Unchanged
		
		assert (Sum = "1110") report "Case 1 failed: Sum /= 1110";
		assert (C_out = '0') report "Case 1 failed: C_out /= 0";
		
		C_in <= '1';
		
		wait for 50 ns;	-- Wait until change has propagated
		-- Case 2 : Inc, with no out carry
		
		assert (Sum = "1111") report "Case 2 failed: Sum /= 1111";
		assert (C_out = '0') report "Case 2 failed: C_out /= 0";
		
		C_in <= '1';
		InA <= "1111";
		
		wait for 50 ns;	-- Wait until change has propagated
		-- Case 2 : Inc, with out carry
		
		assert (Sum = "0000") report "Case 3 failed: Sum /= 0000";
		assert (C_out = '1') report "Case 3 failed: C_out /= 1";

      wait;
   end process;

END;
