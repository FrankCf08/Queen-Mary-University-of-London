----------------------------------------------------------------------------------
-- Company:  Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    16:02:05 10/19/2017 
-- Design Name: 
-- Module Name:    two_to_one_mux - Behavioral 
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

entity two_to_one_mux is
    Port ( i0 : in  STD_LOGIC;
           i1 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           f : out  STD_LOGIC);
end two_to_one_mux;

architecture Behavioral of two_to_one_mux is

begin
	process (i0,i1,s0)
	begin
		 if s0='0' then
			  f <= i0 after 7 ns;
		 else
			  f <= i1 after 7 ns;
		 end if;
	end process;
end Behavioral;

