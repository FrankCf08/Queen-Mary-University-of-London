----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    19:31:17 11/12/2017 
-- Design Name: 
-- Module Name:    n_input_nor - Behavioral 
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
entity n_input_nor is

	 -- GENERIC VALUE:
	 Generic ( n : positive := 4 );
	 
	 -- PORTS
    Port ( Inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
           Output : out  STD_LOGIC);
end n_input_nor;

-- ARCHITECTURE
architecture Behavioral of n_input_nor is

begin
	
	-- PROCESS
	process (Inputs)
	
	-- VARIABLES
	variable result : std_logic;
	variable delay : positive;
	
	begin
		result := '0';
		for i in Inputs'range loop
			result := result or Inputs(i);
		end loop;
		-- Assuming each input causes a 7 ns delay + 1 for inverter delay
		delay := ((n+1)*7);
		Output <= not result after delay * 1 ns;
	end process;
	
end Behavioral;

