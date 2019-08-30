----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    14:42:06 11/12/2017 
-- Design Name: 
-- Module Name:    four_bit_count_next_state_logic - Behavioral 
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
entity four_bit_count_next_state_logic is
	 -- PORTS
    Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
           Output : out  STD_LOGIC_VECTOR(3 downto 0));
end four_bit_count_next_state_logic;

-- ARCHITECTURE
architecture Behavioral of four_bit_count_next_state_logic is

begin
	
	-- Delay assumptions:
	-- Inverter - 7 ns
	-- Two input and - 14 ns
	-- Xor - 2 * two input and = 28 ns
	
	-- Output bit equations obtained from K-map
	Output(0) <= not Input(0) after 7 ns;
	Output(1) <= Input(0) xor Input(1) after 28 ns;
	Output(2) <= Input(2) xor (Input(1) and Input(0)) after 42 ns;
	Output(3) <= Input(3) xor (Input(2) and (Input(1) and Input(0))) after 56 ns;

end Behavioral;

