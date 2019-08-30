--Engineer: Sohrab Dorodvand
--Student ID: 140703636

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter is
 Port ( a : in STD_LOGIC;
 f : out STD_LOGIC);
end inverter;

architecture Behavioral of inverter is
begin
f<= not a after 2ns;
end Behavioral;


