----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    19:16:23 11/12/2017 
-- Design Name: 
-- Module Name:    eight_bit_comparator - Behavioral 
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
entity eight_bit_comparator is

	 -- PORTS
    Port ( InA : in  STD_LOGIC_VECTOR(7 downto 0);
           InB : in  STD_LOGIC_VECTOR(7 downto 0);
           Output : out  STD_LOGIC);
end eight_bit_comparator;

-- ARCHITECTURE
architecture Behavioral of eight_bit_comparator is

-- COMPONENTS
component two_input_xor
    Port ( a : in std_logic;
           b : in std_logic;
           f : out std_logic);
end component;

component n_input_nor
	 generic ( n : positive);
	 Port ( Inputs : in std_logic_vector(n-1 downto 0);
           Output : out std_logic);
end component;

-- SIGNALS
signal xor_out : std_logic_vector(7 downto 0);

begin

	-- FOR LOOP
	inst : for i in 7 downto 0 generate

		-- generate n instances of the device "two_input_xor"
		xor_gate_i : two_input_xor port map (InA(i), InB(i), xor_out(i));

	end generate;

	eight_input_nor : n_input_nor generic map (8) port map(xor_out, Output);

end Behavioral;

