-- Engineer: Frank Cruz
-- Student ID: 150684871

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- ENTITY
entity and_test_bench is
end and_test_bench;

-- ARCHITECTURE
architecture and_testbench of and_test_bench is
component ANDGATE

	port (a,b : in  std_logic;
	    c : out std_logic);
end component;

-- INPUT
signal sig_a, sig_b : std_logic := '0';

-- OUTPUT
signal sig_f        : std_logic;

begin
	uut: ANDGATE port map (sig_a, sig_b, sig_f);
	tb:process
	begin

-- *** Comments on how this test bench works *** --

		-- truth table for a AND gate:

		--    a   b   :  f
		--------------:-----
		--    0	  0   :  0
		--    0	  1   :  0
		--    1	  0   :  0
		--    1	  1   :  1

		-- input test signals of the correct values to
		-- sig_a and sig_b at 100ns intervals to check
		-- that sig_f gives the expected output

-- ********************************************** --


		wait for 100 ns; -- TEST "00"
		sig_a <= '0';
		sig_b <= '0';

		wait for 100 ns; -- TEST "01"
		sig_a <= '0';
		sig_b <= '1';

		wait for 100 ns; -- TEST "10"
		sig_a <= '1';
		sig_b <= '0';

		wait for 100 ns; -- TEST "11"
		sig_a <= '1';
		sig_b <= '1';

		wait;
	end process;
end;
