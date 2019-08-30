----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jariful Hoque
-- 
-- Create Date:    23:10:26 11/14/2017 
-- Design Name: 
-- Module Name:    washer_output_logic - Behavioral 
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

-- ENTITY
entity washer_output_logic is

	 -- PORTS
    Port ( state : in  STD_LOGIC_VECTOR(2 downto 0);
           door_lock : out  STD_LOGIC;
           water_pump : out  STD_LOGIC;
           soap : out  STD_LOGIC;
           rotate_drum : out  STD_LOGIC;
           drain : out  STD_LOGIC);
end washer_output_logic;

-- ARCHITECTURE
architecture Behavioral of washer_output_logic is

begin

	-- PROCESS
	process (state)
	
	begin
		
		door_lock <= (state(0) or state(1)) or state(2) after 21 ns;
		
		water_pump <= (not state(1)) and (state(0) xor state(2)) after 42 ns;
		
		soap <= ((not state(2)) and (not state(1))) and state(0) after 35 ns;
		
		rotate_drum <= (((not state(2)) and state(1)) and (not state(0))) or (state(2) and state(0)) after 35 ns;
		
		drain <= (((not state(2)) and state(1)) and state(0)) or (state(2) and state(1)) after 35 ns;
	
	end process;

end Behavioral;

