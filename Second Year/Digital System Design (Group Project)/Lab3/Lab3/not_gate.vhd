----------------------------------------------------------------------------------
-- Company:  Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    15:50:25 10/19/2017 
-- Design Name: 
-- Module Name:    not_gate - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity not_gate is
    Port ( a : in  STD_LOGIC;
           f : out  STD_LOGIC);
end not_gate;

architecture Behavioral of not_gate is

begin
    f <= not a after 7 ns;
end Behavioral;

