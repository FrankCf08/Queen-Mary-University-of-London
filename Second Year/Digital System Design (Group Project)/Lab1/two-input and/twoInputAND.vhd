-- Engineer: Frank Cruz
-- Student ID: 150684871
-- DesignName: 2inputANDGate


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
--entity is like initialising what the component is and what it consists of. (I/O and the ports)
entity ANDGATE is
port (a,b: in STD_LOGIC;
      c: out STD_LOGIC);
end ANDGATE;
--architecture (this is programming how the component will work)
architecture ANDBEHAVIOR of ANDGATE is
begin
  c <= a AND b after 5ns;
end ANDBEHAVIOR;
