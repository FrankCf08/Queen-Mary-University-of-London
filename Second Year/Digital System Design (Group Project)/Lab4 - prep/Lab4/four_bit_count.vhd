----------------------------------------------------------------------------------
-- Company: Group B 
-- Engineer: Redouan Farah
-- 
-- Create Date:    14:24:10 11/12/2017 
-- Design Name: 
-- Module Name:    four_bit_count - Behavioral 
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
entity four_bit_count is

	 -- PORTS
    Port ( CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : out  STD_LOGIC_VECTOR(3 downto 0));
end four_bit_count;

-- ARCHITECTURE
architecture Behavioral of four_bit_count is

-- COMPONENTS
component four_bit_count_next_state_logic
   Port ( Input : in  STD_LOGIC_VECTOR(3 downto 0);
          Output : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

component nbit_reg
	generic ( n : positive);
   Port ( CLK : in  STD_LOGIC;
          D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
          reset : in  STD_LOGIC;
          preset : in  STD_LOGIC;
          Q_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0);
          Q_bar_outputs : out  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- INTERNAL SIGNALS
signal reg_out, next_state, dummy : STD_LOGIC_VECTOR(3 downto 0);

begin
		
	-- Instantiate next-state logic
	count_next_state_logic: four_bit_count_next_state_logic port map (reg_out, next_state);
	
	-- Instantiate four bit register
	four_bit_reg: nbit_reg generic map (4) port map (CLK, next_state, reset, '0', reg_out, dummy);
	
	-- Assign output
	Q_outputs <= reg_out(3 downto 0);

end Behavioral;

