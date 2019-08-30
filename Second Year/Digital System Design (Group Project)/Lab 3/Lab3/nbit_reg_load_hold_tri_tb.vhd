--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
--
-- Create Date:   20:47:44 10/29/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_reg_load_hold_tri_tb IS
END nbit_reg_load_hold_tri_tb;
 
ARCHITECTURE behavior OF nbit_reg_load_hold_tri_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_reg_load_hold_tri
    PORT(
         D_inputs : IN  std_logic_vector(3 downto 0);
         load_hold : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         output_enable : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_inputs : std_logic_vector(3 downto 0) := (others => '0');
   signal load_hold : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal output_enable : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_reg_load_hold_tri PORT MAP (
          D_inputs => D_inputs,
          load_hold => load_hold,
          CLK => CLK,
          reset => reset,
          output_enable => output_enable,
          Q_outputs => Q_outputs
        );

   -- SET CLOCK PERIOD
	clk <= not clk after 50 ns; -- period = 100ns

   tb: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		-- Reset register, output: Hi-Z
		
		reset <= '1';
		output_enable <= '0';
		
		wait for 120 ns;
		-- output should still be Hi-Z
		
		reset <= '0';
		D_inputs <= "1010";
		
		wait for 120 ns;
		-- Output should be 0000
		
		load_hold <= '1';
		output_enable <= '1';
		
		wait for 120 ns;
		-- rising edge: Output should now be 1010

      wait;
   end process;

END;
