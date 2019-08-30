--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
--
-- Create Date:   19:53:08 10/28/2017
-- Design Name:   
-- Module Name:   C:/Users/Jayant/Desktop/Projects/QMUL/ECS615U/Lab 3 - Prep/Lab3/nbit_tri_buff_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nbit_tri_buff
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
 
ENTITY nbit_tri_buff_tb IS
END nbit_tri_buff_tb;
 
ARCHITECTURE behavior OF nbit_tri_buff_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_tri_buff
    PORT(
         Inputs : IN  std_logic_vector(3 downto 0);
         enable : IN  std_logic;
         Outputs : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Inputs : std_logic_vector(3 downto 0) := (others => '0');
   signal enable : std_logic := '0';

 	--Outputs
   signal Outputs : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_tri_buff PORT MAP (
          Inputs => Inputs,
          enable => enable,
          Outputs => Outputs
        );

	tb : PROCESS
	BEGIN

-- *** Comments on how this test bench works *** --		

		-- test cases for n-bit tristate buffer:

		--  enable Inputs :  Outputs
		------------------:------------
		--		0	  0100   :	Hi-Z    
   	--		0	  0101   :	Hi-Z    
	   --		1	  1000   :	1000    
   	--		1	  0001   :	0001    

-- ********************************************** --

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- test Hi-Z output (i.e. output disabled - high impedance)
		Inputs <= "0100";
		enable <= '0';

		wait for 100 ns;

		Inputs <= "0101";

		-- test normal output (i.e. output enabled)
		wait for 100 ns;

		Inputs <= "1000";
		enable <= '1';
				
		wait for 100 ns;

		Inputs <= "0001";

		wait; -- will wait forever
	END PROCESS;

END;
