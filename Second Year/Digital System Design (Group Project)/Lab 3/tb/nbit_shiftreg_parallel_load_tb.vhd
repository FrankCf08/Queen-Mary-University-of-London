--------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
--
-- Create Date:   18:34:02 10/29/2017
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nbit_shiftreg_parallel_load_tb IS
END nbit_shiftreg_parallel_load_tb;
 
ARCHITECTURE behavior OF nbit_shiftreg_parallel_load_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nbit_shiftreg_parallel_load
    PORT(
         shift_in : IN  std_logic;
         D_inputs : IN  std_logic_vector(7 downto 0);
         load_shift : IN  std_logic;
         CLK : IN  std_logic;
         reset : IN  std_logic;
         preset : IN  std_logic;
         Q_outputs : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal shift_in : std_logic := '0';
   signal D_inputs : std_logic_vector(7 downto 0) := (others => '0');
   signal load_shift : std_logic := '0';
   signal CLK : std_logic := '0';
   signal reset : std_logic := '0';
   signal preset : std_logic := '0';

 	--Outputs
   signal Q_outputs : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nbit_shiftreg_parallel_load PORT MAP (
          shift_in => shift_in,
          D_inputs => D_inputs,
          load_shift => load_shift,
          CLK => CLK,
          reset => reset,
          preset => preset,
          Q_outputs => Q_outputs
        );


	-- SET THE CLOCK PERIOD:
	clk <= not clk after 50 ns; -- define clock period 100ns

	tb : PROCESS
	BEGIN



		-- Wait 100 ns for global reset to finish
		wait for 100 ns;
		-- at this point the contents of the register's flip-flops are undefined
		-- register contains: UUUUUUUU

		load_shift <= '0';
		-- apply asynchronous reset signal:
		reset <= '1';				  
		-- register now contains: 00000000

		wait for 50 ns;

		-- disable reset
		reset <=	'0';				  
		-- register still contains: 00000000

		wait for 25 ns; 
		-- after this wait time we have 25 ns left before the first clock that 
		-- the register will shift data on. Now set the shift_in input to '1'

		shift_in	<= '1';			  

		wait for 800 ns;	-- wait 8 clock periods
		-- register will shift a '1' in at each clock edge until the shift_in
		-- value changes: 		  
		-- clock edge 1: 00000001
		-- clock edge 2: 00000011
		-- clock edge 3: 00000111
		-- clock edge 4: 00001111
		-- clock edge 5: 00011111
		-- clock edge 6: 00111111
		-- clock edge 7: 01111111
		-- clock edge 8: 11111111

		shift_in <= '0';			
										  
		wait for 100 ns; -- wait 1 clock period
		-- clock edge: 11111110

		shift_in <= '1';			  
		
		wait for 300 ns;	-- wait 3 clock periods
		-- clock edge 1: 11111101
		-- clock edge 2: 11111011
		-- clock edge 3: 11110111
		
		shift_in <= '0';			

		wait for 200 ns; 
		-- clock edge 1: 11101110
		-- clock edge 2: 11011100
		
		load_shift <= '1';
		D_inputs <= "00100011";				

		wait for 100 ns; -- wait clock period
		-- clock edge: 00100011
		
		wait for 40 ns;
		-- asynchronous preset
		preset <= '1';					
		
		-- all flipflops are set to 1:
		-- register now contains: 11111111
		
		wait; -- will wait forever
	END PROCESS;


END;
