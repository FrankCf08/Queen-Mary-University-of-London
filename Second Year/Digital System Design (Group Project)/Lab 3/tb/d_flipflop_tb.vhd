--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
--
-- Create Date:   18:34:50 10/28/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY d_flipflop_tb IS
END d_flipflop_tb;
 
ARCHITECTURE behavior OF d_flipflop_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT D_flipflop
    PORT(
         D : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         CLK : IN  std_logic;
         Q : INOUT  std_logic;
         Q_bar : INOUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';
   signal CLK : std_logic := '0';

	--BiDirs
   signal Q : std_logic;
   signal Q_bar : std_logic;
 
BEGIN

-- ************* Comments on how this test bench works **************** --		
--	  Truth Table for D Flip flop:

-- 	 CLK	  D	  Preset  	Reset	: 		Q  		Q_bar 
--    ------------------------------:------------------------
--    rising  0		  0		  0	:		0	  			1
--		rising  1		  0		  0	:   	1  			0
--			0	  X		  0		  0	: 	last Q 		last Q_bar
--			1	  X		  0		  0	: 	last Q		last Q_bar
--			X	  X		  1		  0	:  	1  			0
--			X	  X		  X		  1	:  	0  			1
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: D_flipflop PORT MAP (
          D => D,
          reset => reset,
          preset => preset,
          CLK => CLK,
          Q => Q,
          Q_bar => Q_bar
        );

   -- SET CLOCK PERIOD
	clk <= not clk after 50 ns; -- period = 100ns
 
   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

		D <= '1';

      wait for 120ns;
		
		D <= '0';
		
		wait for 120ns;
		
		preset <= '1';
		
		wait for 120ns;
		
		reset <= '1';

      wait;
   end process;

END;
