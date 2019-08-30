----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Jayant Shivarajan
-- 
-- Create Date:    21:06:02 11/13/2017 
-- Design Name: 
-- Module Name:    washer_next_state_logic - Behavioral 
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
entity washer_next_state_logic is
	 
	 -- PORTS
    Port ( state : in  STD_LOGIC_VECTOR(2 downto 0);
           door_open : in  STD_LOGIC;
           control : in  STD_LOGIC;
           next_state : out  STD_LOGIC_VECTOR(2 downto 0));
end washer_next_state_logic;

-- ARCHITECTURE
architecture Behavioral of washer_next_state_logic is

begin
	
	-- DELAY ASSUMPTIONS
	-- inverter : 7 ns
	-- 2 input and / or : 14 ns
	-- two input xor : 28 ns
	
	-- Note: Using variables/signals seemed to interfere with the logic
	-- Apologies for the long-winded boolean expression.
	
	next_state(0) <= (not state(0)) xor (((state(2) and state(1)) and (not (state(0) or control ))) or (((not control) or door_open) and (not ((state(0) or state(1)) or state(2))))) after 105 ns;
	
	next_state(1) <= (state(1) xor state(0)) xor ((state(2) and state(1)) and (not (state(0) or control ))) after 63 ns;
		
	next_state(2) <= (state(2) xor (state(1) and state(0))) xor ((state(2) and state(1)) and (not (state(0) or control ))) after 63 ns;
	
end Behavioral;

