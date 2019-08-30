-- Name: Frank Cruz Felix
--Student ID: 150684871
-- Design: Three-Input OR gate

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- In entity function, it describes the inputs and outputs to use

entity three_InputOrgate is
	generic (delay: TIME := 5ns); 
	port (  a: in std_logic; -- input1
		b: in std_logic; -- input2
		c: in std_logic; -- input3
		z: out std_logic); -- output
end three_InputOrgate;

--architecture: It describes how the entity works 

architecture threInput_arch of three_InputOrgate is
begin
	z <= a or b or c after delay;
end threInput_arch;

