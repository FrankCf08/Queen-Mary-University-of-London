--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
--
-- Create Date:   16:50:00 11/12/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_count_parallel_load_tb IS
END nbit_count_parallel_load_tb;
 
ARCHITECTURE behavior OF nbit_count_parallel_load_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_count_parallel_load
    PORT(
         D_inputs : IN  std_logic_vector(7 downto 0);
         load_count : IN  std_logic;
         count_enable : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_inputs : std_logic_vector(7 downto 0) := (others => '0');
   signal load_count : std_logic := '0';
   signal count_enable : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';

	--BiDirs
   signal Q_outputs : std_logic_vector(7 downto 0);
 
BEGIN
 
-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is an n-bit synchronous counter with parallel
--   load input. This circuit is similar to the synchronous counter with
--	  enable circuit, but now in addition, it allows the counter to be set
--   to any given state value when the load/~count input is '1'.

--	  n-bit synchronous counter with parallel load input test cases:

--  Comments    CLK   reset  load_count  count_enable  D_inputs :  Q_outputs 
-- -------------------------------------------------------------:------------
--    Reset      X      1         X            X           X    :  00000000  
--    Hold    Rising    0         0            0           X    :   last Q   
--    Count   Rising    0         0            1           X    : last Q + 1 
--    Load    Rising    0         1            X           Q    :      Q     
	
-- ******************************************************************** --

	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_count_parallel_load PORT MAP (
          D_inputs => D_inputs,
          load_count => load_count,
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
		
		wait for 100 ns;
		-- Case 1: Count
		
		assert (Q_outputs = "00000001") report "Case 1 failed: Q_outputs /= 00000001";
		
		wait for 100 ns;
		-- Case 2: Count
		
		assert (Q_outputs = "00000010") report "Case 2 failed: Q_outputs /= 00000010";
		
				
		D_inputs <= "11111100";
		count_enable <= '0';
		load_count <= '1';
		
		wait for 100 ns;
		-- Case 3: Load
		
		assert (Q_outputs = "11111100") report "Case 3 failed: Q_outputs /= 11111100";
		
		load_count <= '0';
		
		wait for 300 ns;
		-- Case 4: Hold for 3 clock cycles

		assert (Q_outputs = "11111100") report "Case 4 failed: Q_outputs /= 11111100";
		
		count_enable <= '1';

		wait for 100 ns;
		-- Case 5: Count
		
		assert (Q_outputs = "11111101") report "Case 5 failed: Q_outputs /= 11111101";
		
		reset <= '1';
		
		wait for 100 ns;
		-- Case 6: Reset
		
		assert (Q_outputs = "00000000") report "Case 6 failed: Q_outputs /= 00000000";

      wait;
   end process;

END;
