--Engineer: Sohrab Dorodvand
--Student ID: 140703636

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

ENTITY Testbench_full_adder IS
END Testbench_full_adder;

ARCHITECTURE behavior OF Testbench_full_adder IS 
 -- Component Declaration for the Unit Under Test (UUT)
 COMPONENT full_adder
 PORT(
	a : IN std_logic;
	b : IN std_logic;
	cin : IN std_logic;
	sum : OUT std_logic;
	cout : OUT std_logic
	);
 END COMPONENT;
 --Inputs
	signal sig_a : std_logic := '0';
	signal sig_b : std_logic := '0';
	signal sig_cin : std_logic := '0';
 --Outputs
	signal sig_sum : std_logic;
	signal sig_cout : std_logic;
BEGIN
 -- Instantiate the Unit Under Test (UUT)
 uut: full_adder PORT MAP (sig_a,sig_b,sig_cin,sig_sum,sig_cout);

 tb: process
 
 begin
 -- hold reset state for 100 ns.
	wait for 100 ns; 

	sig_a <= '0';
	sig_b <= '0';
	sig_cin <= '0';  --check input 0,0,0	-> sig_sum=0 and sig_cout=0
 
	wait for 100 ns;
	sig_a <= '0';
	sig_b <= '1'; 	--check input 0,1,0		-> sig_sum=1 and sig_cout=0

	wait for 100 ns;
	sig_a <= '1';
	sig_b <= '0';	--check input 1,0,0		-> sig_sum=1 and sig_cout=0
	
	wait for 100 ns;
	sig_a <= '1';
	sig_b <= '1';	--check input 1,1,0		-> sig_sum=0 and sig_cout=1
 
	wait for 100 ns;
	sig_a <= '0';
	sig_b <= '0';
	sig_cin <= '1';  --check input 0,0,1	-> sig_sum=1 and sig_cout=0
 
	wait for 100 ns;
	sig_a <= '0';
	sig_b <= '1';  --check input 0,1,1		-> sig_sum=0 and sig_cout=1

	wait for 100 ns;
	sig_a <= '1';
	sig_b <= '0';  --check input 1,0,1		-> sig_sum=0 and sig_cout=1
	
	wait for 100 ns;
	sig_a <= '1';
	sig_b <= '1';  --check input 1,1,1		-> sig_sum=1 and sig_cout=1
 
 wait;
 end process;
END;



