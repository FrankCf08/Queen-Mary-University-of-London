--Engineer: Sohrab Dorodvand
--Student ID: 140703636


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY inverter_tb_vhd IS
END inverter_tb_vhd;

ARCHITECTURE test_arch of inverter_tb_vhd is
component inverter 
 Port ( a : in STD_LOGIC;
		f : out STD_LOGIC);
end component;

signal sig_a: std_logic := '0';
signal sig_f: std_logic;

begin
	uut: inverter PORT MAP ( sig_a, sig_f);

	tb: process
	
	BEGIN
	
	wait for 100 ns; --waitng for global reset
	sig_a <= '0'; -- check for input 0, output -> 1
	
	wait for 100 ns;
	sig_a <= '1'; -- check for input 1, output -> 0
	
	wait;
	end process;
end;