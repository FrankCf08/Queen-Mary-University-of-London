--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   19:58:38 10/29/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY four_bit_linear_feedback_shiftreg_tb IS
END four_bit_linear_feedback_shiftreg_tb;
 
ARCHITECTURE behavior OF four_bit_linear_feedback_shiftreg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT four_bit_linear_feedback_shiftreg
    PORT(
         CLK : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

	--BiDirs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: four_bit_linear_feedback_shiftreg PORT MAP (
          CLK => CLK,
          reset => reset,
          preset => preset,
          Q_outputs => Q_outputs
        );

   -- SET CLOCK PERIOD
	clk <= not clk after 50 ns; -- period = 100ns
	
   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- Initial value 1111
		
		-- Should give the following repeating sequence:
		-- 1111, 1110, 1100, 1000. 0001, 0010, 0100,
      -- 1001, 0011, 0110, 1101, 1010, 0101, 1011,
		-- 0111, 1111

      wait;
   end process;

END;
