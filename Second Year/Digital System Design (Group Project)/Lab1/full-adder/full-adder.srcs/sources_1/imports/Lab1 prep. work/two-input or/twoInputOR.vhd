-- Name: Frank Cruz Felix
--Student ID: 150684871
-- Design: Two-Input OR gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity: it describes the inputs and outputs to be used.

entity OR_GATE is
	generic(delay: TIME:= 5ns);
	port (  a: in std_logic;-- input1
		b: in std_logic;-- input2
	   	z: out std_logic);-- output
end OR_GATE;

--architecture it describes the behaviour of our entity

architecture behavioural_or of OR_GATE is
begin
	z <= a or b after delay;
end behavioural_or;

