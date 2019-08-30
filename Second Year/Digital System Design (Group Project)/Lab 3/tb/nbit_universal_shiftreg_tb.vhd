--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
--
-- Create Date:   18:58:25 10/29/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_universal_shiftreg_tb IS
END nbit_universal_shiftreg_tb;
 
ARCHITECTURE behavior OF nbit_universal_shiftreg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_universal_shiftreg
    PORT(
         D_inputs : IN  std_logic_vector(3 downto 0);
         Shift_in : IN  std_logic;
         Shift_rotate_bar : IN  std_logic;
         F : IN  std_logic_vector(1 downto 0);
         CLK : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_inputs : std_logic_vector(3 downto 0) := (others => '0');
   signal Shift_in : std_logic := '0';
   signal Shift_rotate_bar : std_logic := '0';
   signal F : std_logic_vector(1 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_universal_shiftreg PORT MAP (
          D_inputs => D_inputs,
          Shift_in => Shift_in,
          Shift_rotate_bar => Shift_rotate_bar,
          F => F,
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
		-- Load
		
		F <= "11";
		D_inputs <= "1011";
		
      wait for 120ns;
		-- clock edge: 1011
		-- Rotate Right
		
		F <= "10";
		shift_rotate_bar <= '0';
		
		wait for 120ns;
		-- clock edge: 1101
		-- Shift Left by 0
		
		F <= "01";
		Shift_in <= '0';
		shift_rotate_bar <= '1';
		
		wait for 120ns;
		-- clock edge: 1010
		-- Rotate left
		
		shift_rotate_bar <= '0';
		
		wait for 120ns;
		-- clock edge: 0101
		-- Shift right by 1
		
		F <= "10";
		Shift_in <= '1';
		shift_rotate_bar <= '1';
		
		wait for 120ns;
		-- clock edge: 1010
		-- Hold
		
		F <= "00";
		
		wait for 240 ns;
		-- Preset to 1111
		
		preset <= '1';
		
      wait;
   end process;

END;
