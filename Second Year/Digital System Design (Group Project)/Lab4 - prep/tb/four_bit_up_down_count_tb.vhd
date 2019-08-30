--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   17:50:43 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY four_bit_up_down_count_tb IS
END four_bit_up_down_count_tb;
 
ARCHITECTURE behavior OF four_bit_up_down_count_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT four_bit_up_down_count
    PORT(
         N_count : IN  std_logic_vector(3 downto 0);
         down_up : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal N_count : std_logic_vector(3 downto 0) := (others => '0');
   signal down_up : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';

	--BiDirs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN


-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is a 4-bit synchronous counter. This circuit 
--   counts in steps of N_count. It counts upward if down_up is 1 and 
--   downward if otherwise.

--	  4-bit synchronous up/down counter test cases:

--   Comments     CLK   reset  down_up  N_count :  Q_outputs 
-- ---------------------------------------------:------------
--     Reset       X      1       X        X    :    0000   
--     Hold     Rising    0       X       0000  :   last Q    
--   Count up   Rising    0       0        N    : last Q + N 
--  Count down  Rising    0       1        N    : last Q - N 
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: four_bit_up_down_count PORT MAP (
          N_count => N_count,
          down_up => down_up,
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
		
		N_count <= "0010";
		
		wait for 100 ns;
		-- Case 1: Count up by 2
		
		assert (Q_outputs = "0010") report "Case 1 failed: Q_outputs /= 0010";
		
		wait for 100 ns;
		-- Case 2: Count up by 2
		
		assert (Q_outputs = "0100") report "Case 2 failed: Q_outputs /= 0100";
		
		down_up <= '1';
		N_count <= "0001";
		
		wait for 100 ns;
		-- Case 3: Count down by 1
		
		assert (Q_outputs = "0011") report "Case 3 failed: Q_outputs /= 0011";
		
		N_count <= "0000";
		
		wait for 200 ns;
		-- Case 3: Hold for 2 cycles
		
		assert (Q_outputs = "0011") report "Case 3 failed: Q_outputs /= 0011";
		
		N_count <= "0001";
		
		wait for 100 ns;
		-- Case 4: Count down by 1
		
		assert (Q_outputs = "0010") report "Case 4 failed: Q_outputs /= 0010";
		
		reset <= '1';

      wait;
   end process;

END;
