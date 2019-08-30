-- Engineer: Sohrab Dorodvand
--Student ID: 140703636
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
Port (   
    a : in STD_LOGIC;
	b : in STD_LOGIC;
	cin : in STD_LOGIC;
	sum : out STD_LOGIC;
	cout : out STD_LOGIC);
end full_adder;

architecture fa_arch of full_adder is
--we will create two components
--or gate component

	component OR_GATE
		port(
			a:in std_logic;
			b:in std_logic;
			z:out std_logic);
	end component;

--half adder component
	component HALF_ADDER
		port(
			a,b: in std_logic;
			s,c: out std_logic);
	end component;
signal sig1,sig2,sig3: std_logic;

begin

HalfA1	: HALF_ADDER port map(a,b,sig1,sig2);	
HalfA2	: HALF_ADDER port map(cin,sig1,sum,sig3);
OR1	: OR_GATE    port map(sig2,sig3,cout);


end fa_arch;
