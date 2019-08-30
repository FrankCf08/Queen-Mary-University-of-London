--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   19:36:00 10/29/2017
-- Design Name:   
-- Module Name:   C:/Users/Jayant/Desktop/Projects/QMUL/ECS615U/Lab 3 - Prep/Lab3/nbit_twisted_ring_counter_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nbit_twisted_ring_counter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_twisted_ring_counter_tb IS
END nbit_twisted_ring_counter_tb;
 
ARCHITECTURE behavior OF nbit_twisted_ring_counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_twisted_ring_counter
    PORT(
         CLK : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

	--BiDirs
   signal Q_outputs : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_twisted_ring_counter PORT MAP (
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

		reset <= '1';
		
		wait for 120 ns;
		
		reset <= '0';

      wait;
   end process;

END;
