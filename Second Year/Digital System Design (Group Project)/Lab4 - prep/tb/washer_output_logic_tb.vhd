--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
--
-- Create Date:   23:45:36 11/14/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY washer_output_logic_tb IS
END washer_output_logic_tb;
 
ARCHITECTURE behavior OF washer_output_logic_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT washer_output_logic
    PORT(
         state : IN  std_logic_vector(2 downto 0);
         door_lock : OUT  std_logic;
         water_pump : OUT  std_logic;
         soap : OUT  std_logic;
         rotate_drum : OUT  std_logic;
         drain : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal state : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal door_lock : std_logic;
   signal water_pump : std_logic;
   signal soap : std_logic;
   signal rotate_drum : std_logic;
   signal drain : std_logic;
 
BEGIN

-- ************* Comments on how this test bench works **************** --	

--	  The circuit under test is a combinational circuit representing the
--   clothes washer controller's output logic depending on the state.

--	  The truth table for this component is given below:

--    Function    state : door_lock  water_pump  soap  rotate_drum  drain 
-- ---------------------:-------------------------------------------------
--  Load clothes   000  :     0           0        0        0         0   
--    Wash fill    001  :     1           1        1        0         0   
--    Wash spin    010  :     1           0        0        1         0   
--      Drain      011  :     1           0        0        0         1   
--   Rinse fill    100  :     1           1        0        0         0   
--   Rinse spin    101  :     1           0        0        1         0   
--      Drain      110  :     1           0        0        0         1   
--    Spin dry     111  :     1           0        0        1         1   
	
-- ******************************************************************** -- 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: washer_output_logic PORT MAP (
          state => state,
          door_lock => door_lock,
          water_pump => water_pump,
          soap => soap,
          rotate_drum => rotate_drum,
          drain => drain
        );

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		state <= "000";
		
		wait for 50 ns;
		-- Case 1
		
		assert (door_lock = '0') report "Case 1 failed: door_lock /= 0";
		assert (water_pump = '0') report "Case 1 failed: water_pump /= 0";
		assert (soap = '0') report "Case 1 failed: soap /= 0";
		assert (rotate_drum = '0') report "Case 1 failed: rotate_drum /= 0";
		assert (drain = '0') report "Case 1 failed: drain /= 0";
		
		state <= "001";
		
		wait for 50 ns;
		-- Case 2
		
		assert (door_lock = '1') report "Case 2 failed: door_lock /= 1";
		assert (water_pump = '1') report "Case 2 failed: water_pump /= 1";
		assert (soap = '1') report "Case 2 failed: soap /= 1";
		assert (rotate_drum = '0') report "Case 2 failed: rotate_drum /= 0";
		assert (drain = '0') report "Case 2 failed: drain /= 0";
		
		state <= "010";
		
		wait for 50 ns;
		-- Case 3
		
		assert (door_lock = '1') report "Case 3 failed: door_lock /= 1";
		assert (water_pump = '0') report "Case 3 failed: water_pump /= 0";
		assert (soap = '0') report "Case 3 failed: soap /= 0";
		assert (rotate_drum = '1') report "Case 3 failed: rotate_drum /= 1";
		assert (drain = '0') report "Case 3 failed: drain /= 0";
		
		state <= "011";
		
		wait for 50 ns;
		-- Case 4
		
		assert (door_lock = '1') report "Case 4 failed: door_lock /= 1";
		assert (water_pump = '0') report "Case 4 failed: water_pump /= 0";
		assert (soap = '0') report "Case 4 failed: soap /= 0";
		assert (rotate_drum = '0') report "Case 4 failed: rotate_drum /= 0";
		assert (drain = '1') report "Case 4 failed: drain /= 1";
		
		state <= "100";
		
		wait for 50 ns;
		-- Case 5
		
		assert (door_lock = '1') report "Case 5 failed: door_lock /= 1";
		assert (water_pump = '1') report "Case 5 failed: water_pump /= 1";
		assert (soap = '0') report "Case 5 failed: soap /= 0";
		assert (rotate_drum = '0') report "Case 5 failed: rotate_drum /= 0";
		assert (drain = '0') report "Case 5 failed: drain /= 0";
		
		state <= "101";
		
		wait for 50 ns;
		-- Case 6
		
		assert (door_lock = '1') report "Case 6 failed: door_lock /= 1";
		assert (water_pump = '0') report "Case 6 failed: water_pump /= 0";
		assert (soap = '0') report "Case 6 failed: soap /= 0";
		assert (rotate_drum = '1') report "Case 6 failed: rotate_drum /= 1";
		assert (drain = '0') report "Case 6 failed: drain /= 0";
		
		state <= "110";
		
		wait for 50 ns;
		-- Case 7
		
		assert (door_lock = '1') report "Case 7 failed: door_lock /= 1";
		assert (water_pump = '0') report "Case 7 failed: water_pump /= 0";
		assert (soap = '0') report "Case 7 failed: soap /= 0";
		assert (rotate_drum = '0') report "Case 7 failed: rotate_drum /= 0";
		assert (drain = '1') report "Case 7 failed: drain /= 1";
		
		state <= "111";
		
		wait for 50 ns;
		-- Case 8
		
		assert (door_lock = '1') report "Case 8 failed: door_lock /= 1";
		assert (water_pump = '0') report "Case 8 failed: water_pump /= 0";
		assert (soap = '0') report "Case 8 failed: soap /= 0";
		assert (rotate_drum = '1') report "Case 8 failed: rotate_drum /= 1";
		assert (drain = '1') report "Case 8 failed: drain /= 1";

      wait;
   end process;

END;
