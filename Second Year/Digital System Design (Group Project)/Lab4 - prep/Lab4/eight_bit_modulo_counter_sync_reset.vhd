----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    19:17:15 11/13/2017 
-- Design Name: 
-- Module Name:    eight_bit_modulo_counter_sync_reset - Behavioral 
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
entity eight_bit_modulo_counter_sync_reset is

	 -- PORTS
    Port ( M_value : in  STD_LOGIC_VECTOR(7 downto 0);
           count_enable : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(7 downto 0));
end eight_bit_modulo_counter_sync_reset;


-- ARCHITECTURE
architecture Behavioral of eight_bit_modulo_counter_sync_reset is

-- COMPONENTS
component eight_bit_comparator
   Port ( InA : in  STD_LOGIC_VECTOR(7 downto 0);
          InB : in  STD_LOGIC_VECTOR(7 downto 0);
          Output : out  STD_LOGIC);
end component;

component nbit_count_parallel_load
	generic ( n : positive);
   Port ( D_inputs : in  STD_LOGIC_VECTOR(n-1 downto 0);
          load_count : in  STD_LOGIC;
          count_enable : in  STD_LOGIC;
          CLK : in  STD_LOGIC;
          reset : in  STD_LOGIC;
          Q_outputs : inout  STD_LOGIC_VECTOR(n-1 downto 0));
end component;

-- SIGNALS
signal load_count_sig : std_logic;

begin

	-- INSTANCES
	comparator : eight_bit_comparator port map (Q_outputs, M_value, load_count_sig);
	
	counter 	  : nbit_count_parallel_load generic map (8) port map ("00000000", load_count_sig, count_enable, CLK, reset, Q_outputs);

end Behavioral;

