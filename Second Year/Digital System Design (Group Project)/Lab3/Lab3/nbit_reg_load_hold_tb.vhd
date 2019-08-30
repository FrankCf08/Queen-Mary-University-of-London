--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jairful Hoque
--
-- Create Date:   20:33:50 10/28/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_reg_load_hold_tb IS
END nbit_reg_load_hold_tb;
 
ARCHITECTURE behavior OF nbit_reg_load_hold_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_reg_load_hold
    PORT(
         D_inputs : IN  std_logic_vector(3 downto 0);
         load_hold : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_inputs : std_logic_vector(3 downto 0) := (others => '0');
   signal load_hold : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN

-- ************* Comments on how this test bench works **************** --		
--	  n-bit register with load/~hold control test cases:

-- 	 CLK		load_hold	  D_inputs	  Preset  	Reset	: 	Q_outputs
--    ---------------------------------------------------:-------------
--    rising		0			  	 1000		  	  0		  0	:	 last Q	
--		rising		1			  	 1011		  	  0		  0	:    1011 	
--			X			X			 		X		  	  1		  0	:    1111  	
--			X	 		X			 		X		  	  X		  1	:    0000  	
	
-- ******************************************************************** --
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_reg_load_hold PORT MAP (
          D_inputs => D_inputs,
          load_hold => load_hold,
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

      wait for 120ns;
		
		reset <= '0';		
		load_hold <= '1';
		D_inputs <= "1011";
		
		wait for 120ns;
		
		load_hold <= '0';
		D_inputs <= "1000";
		
		wait for 120ns;
		
		preset <= '1';

      wait;
   end process;

END;
