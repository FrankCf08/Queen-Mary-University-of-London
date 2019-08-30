----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    15:01:55 10/24/2017 
-- Design Name: 
-- Module Name:    four_bit_adder - Behavioral 
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

entity four_bit_adder is
	
	-- PORTS
	Port ( InA, InB : in std_logic_vector(3 downto 0);
		    Control : in std_logic;
			 Sum : out std_logic_vector(3 downto 0);
			 C_out : out std_logic);
end four_bit_adder;

architecture Behavioral of four_bit_adder is

-- COMPONENTS
component nbit_xor_control
	Generic (n : positive); -- generic value
	Port ( Input : in std_logic_vector(n-1 downto 0);
		    Control : in std_logic;
			 Output : out std_logic_vector(n-1 downto 0));
end component;

component four_bit_lac_adder
		Port ( InA, InB : in std_logic_vector(3 downto 0);
				 C_in : in std_logic;
				 Sum : out std_logic_vector(3 downto 0);
				 C_out : out std_logic);
end component;

-- SIGNALS
signal xor_to_b : std_logic_vector(3 downto 0);

begin
	
	-- instantiate xor with a bit-width of 4 (map generic value "n" to 4)
	fourbitxor : nbit_xor_control generic map (4) port map (InB, Control, xor_to_b);

	-- instantiate four bit lac adder
   fourbitlacadder: four_bit_lac_adder port map (InA, xor_to_b, Control, Sum, C_out);

end Behavioral;

