-- Author: Jayant Shivarajan

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( a, b : in std_logic;
           s, c : out std_logic);
end half_adder;

architecture my_architecture of half_adder is
begin
    s <= a xor b after 7 ns;
    c <= a and b after 7 ns;
end my_architecture;