----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Raiyan Shaheen
-- 
-- Create Date:    20:31:29 11/12/2017 
-- Design Name: 
-- Module Name:    eight_bit_modulo_counter_async_reset - Behavioral 
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
entity eight_bit_modulo_counter_async_reset is

	 -- Ports
    Port ( M_value : in  STD_LOGIC_VECTOR(7 downto 0);
           count_enable : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q_outputs : inout  STD_LOGIC_VECTOR(7 downto 0));
end eight_bit_modulo_counter_async_reset;

-- ARCHITECTURE
architecture Behavioral of eight_bit_modulo_counter_async_reset is

-- COMPONENTS
component eight_bit_comparator
   Port ( InA : in  STD_LOGIC_VECTOR(7 downto 0);
          InB : in  STD_LOGIC_VECTOR(7 downto 0);
          Output : out  STD_LOGIC);
end component;

component two_input_or
	Port (a, b : in std_logic;
			f : out std_logic);
end component;

component nbit_count_enable
	generic ( n : positive);
   Port ( enable : in std_logic;
          CLK : in std_logic;
          reset : in std_logic;
          Q_outputs : inout std_logic_vector(n-1 downto 0);
			 ripple_carry_out : out std_logic);
end component;

-- SIGNALS
signal comp_out, count_reset, dummy : std_logic;

begin

	-- INSTANCES
	comparator : eight_bit_comparator port map (Q_outputs, M_value, comp_out);
	
	or_gate 	  : two_input_or port map (comp_out, reset, count_reset);
	
	counter 	  : nbit_count_enable generic map (8) port map (count_enable, CLK, count_reset, Q_outputs, dummy);

end Behavioral;

