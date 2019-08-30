-- Engineer: Calvin Cheng
--Student ID: 160627440
-- DesignName: Half Adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity is initialising.
entity HALF_ADDER is 
  port(a,   b:     in  std_logic;
       s, c: out std_logic);
end HALF_ADDER;
--this is using the entity initialisation hence an entity/architecture pair. 
architecture behavioural of HALF_ADDER is
begin
    s   <= a xor b after 5ns; --sum
    c <= a and b after 5ns; --carry
end behavioural;


