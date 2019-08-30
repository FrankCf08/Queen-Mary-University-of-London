----------------------------------------------------------------------------------
-- Company: Group B
-- Engineer: Redouan Farah
-- 
-- Create Date:    15:16:23 10/24/2017 
-- Design Name: 
-- Module Name:    four_bit_lac_adder - Behavioral 
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

entity four_bit_lac_adder is

	 -- PORTS
    Port ( InA : in  STD_LOGIC_VECTOR(3 downto 0);
           InB : in  STD_LOGIC_VECTOR(3 downto 0);
           C_in : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR(3 downto 0);
           C_out : out  STD_LOGIC);
end four_bit_lac_adder;

architecture Behavioral of four_bit_lac_adder is

-- COMPONENTS
component nbit_adder
	Generic (n : positive); -- generic value
	Port ( InA, InB : in std_logic_vector(n-1 downto 0);
			 C_terms : in std_logic_vector(n-1 downto 0);
		    Sum : out std_logic_vector(n-1 downto 0);
			 C_out : out std_logic);
end component;

component four_bit_LAC
	Port ( InA, InB : in std_logic_vector(3 downto 0);
			 C_in : in std_logic;
		    C_terms : out std_logic_vector(3 downto 0));
end component;

-- SIGNALS
signal C_terms : std_logic_vector(3 downto 0);

begin

	-- instantiate four bit lac
   fourbitlac: four_bit_LAC port map (InA, InB, C_in, C_terms);
	
	-- instantiate adder with a bit-width of 4 (map generic value "n" to 4)
	fourbitadder : nbit_adder generic map (4) port map (InA, InB, C_terms, Sum, C_out);

end Behavioral;

