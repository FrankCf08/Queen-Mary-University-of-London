--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
--
-- Create Date:   19:53:08 10/28/2017
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
