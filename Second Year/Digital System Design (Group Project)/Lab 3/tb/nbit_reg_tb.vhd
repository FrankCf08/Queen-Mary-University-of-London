--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
--
-- Create Date:   19:20:24 10/28/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_reg_tb IS
END nbit_reg_tb;
 
ARCHITECTURE behavior OF nbit_reg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_reg
    PORT(
         CLK : IN  std_logic;
         D_inputs : IN  std_logic_vector(3 downto 0);
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : INOUT  std_logic_vector(3 downto 0);
         Q_bar_outputs : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal D_inputs : std_logic_vector(3 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(3 downto 0);
   signal Q_bar_outputs : std_logic_vector(3 downto 0);
 
BEGIN

-- ************* Comments on how this test bench works **************** --		
--	  n-bit register test cases:

-- 	 CLK	  D_inputs	  Preset  	Reset	: 	Q_outputs  	Q_bar_outputs
--    ------------------------------------:----------------------------
--    rising  	 1010		  	  0		  0	:	  1010	  		 0101
--		rising  	 1011		  	  0		  0	:    1011  			 0100
--			0	  		X		  	  0		  0	: 	 last Q 		  last Q_bar
--			1	  		X		  	  0		  0	: 	 last Q		  last Q_bar
--			X	 		X		  	  1		  0	:    1111  			 0000
--			X	  		X		  	  X		  1	:    0000  			 1111
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_reg PORT MAP (
          CLK => CLK,
          D_inputs => D_inputs,
          reset => reset,
          preset => preset,
          Q_outputs => Q_outputs,
          Q_bar_outputs => Q_bar_outputs
        );
 
   -- SET CLOCK PERIOD
	clk <= not clk after 50 ns; -- period = 100ns

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		D_inputs <= "1010";

      wait for 120ns;
		
		D_inputs <= "1011";
		
		wait for 120ns;
		
		preset <= '1';
		
		wait for 120ns;
		
		reset <= '1';

      wait;
   end process;

END;
